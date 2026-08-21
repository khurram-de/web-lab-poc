#!/bin/bash

echo "Truncating SALES table..."
bteq << ENDBTEQ
.LOGON ${DB_HOST}/${DB_USERNAME},${DB_PASSWORD};
DELETE FROM ${DB_USERNAME}_DEMO.SALES ALL;
.LOGOFF;
.QUIT;
ENDBTEQ

echo "Writing TPT script..."
cat > /tmp/tpt_resolved.tpt << EOF
DEFINE JOB LOAD_SALES_DATA
DESCRIPTION 'Load sales data into SALES table'
(
    DEFINE SCHEMA SALES_SCHEMA
    (
        SALE_ID       VARCHAR(20),
        SALE_DATE     VARCHAR(10),
        PRODUCT_ID    VARCHAR(20),
        QUANTITY      VARCHAR(20),
        SALE_AMOUNT   VARCHAR(20),
        CUSTOMER_ID   VARCHAR(20),
        REGION        VARCHAR(20)
    );

    DEFINE OPERATOR FILE_READER
    TYPE DATACONNECTOR PRODUCER
    SCHEMA SALES_SCHEMA
    ATTRIBUTES
    (
        VARCHAR FileName        = '/workspace/sales_data.txt',
        VARCHAR Format          = 'Delimited',
        VARCHAR TextDelimiter   = '|',
        VARCHAR OpenMode        = 'Read'
    );

    DEFINE OPERATOR LOAD_OPERATOR
    TYPE LOAD
    SCHEMA SALES_SCHEMA
    ATTRIBUTES
    (
        VARCHAR TdpId           = '$DB_HOST',
        VARCHAR UserName        = '$DB_USERNAME',
        VARCHAR UserPassword    = '$DB_PASSWORD',
        VARCHAR TargetTable     = '${DB_USERNAME}_DEMO.SALES',
        VARCHAR LogTable        = '${DB_USERNAME}_DEMO.SALES_TPT_LOG',
        VARCHAR ErrorTable1     = '${DB_USERNAME}_DEMO.SALES_ET',
        VARCHAR ErrorTable2     = '${DB_USERNAME}_DEMO.SALES_UV',
        VARCHAR DateForm        = 'ANSIDATE'
    );

    APPLY
    (
        'INSERT INTO ${DB_USERNAME}_DEMO.SALES
        (
            SALE_ID,
            SALE_DATE,
            PRODUCT_ID,
            QUANTITY,
            SALE_AMOUNT,
            CUSTOMER_ID,
            REGION
        )
        VALUES
        (
            :SALE_ID (INTEGER),
            :SALE_DATE (DATE),
            :PRODUCT_ID (INTEGER),
            :QUANTITY (INTEGER),
            :SALE_AMOUNT (DECIMAL(10,2)),
            :CUSTOMER_ID (INTEGER),
            :REGION
        );'
    )
    TO OPERATOR (LOAD_OPERATOR)
    SELECT * FROM OPERATOR (FILE_READER);
);
EOF

echo "Running TPT job..."
tbuild -f /tmp/tpt_resolved.tpt

echo "Verifying load..."
bteq << ENDBTEQ
.LOGON ${DB_HOST}/${DB_USERNAME},${DB_PASSWORD};
SELECT COUNT(*) AS ROWS_LOADED FROM ${DB_USERNAME}_DEMO.SALES;
.LOGOFF;
.QUIT;
ENDBTEQ