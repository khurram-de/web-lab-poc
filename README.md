# SYCLOPS Training Lab - Demo Workspace

This workspace contains sample data and scripts for Teradata training exercises.

## Database Schema

**Database**: `${DB_USERNAME}_DEMO` (pre-created, user's only accessible database)

**Tables**:
- `DEPARTMENT` - Department information
- `EMPLOYEE` - Employee records
- `SALES` - Daily sales transactions
- `PRODUCT` - Product catalog

## Files Overview

### Setup Scripts
- `00-setup.sql` - Creates database and tables (run in SQL Assistant)
- `00-setup.bteq` - Same setup using BTEQ (run in TD Terminal)

### SQL Assistant Scripts (*.sql)
- `01-basic-queries.sql` - SELECT statements
- `02-joins.sql` - JOIN operations
- `03-aggregations.sql` - GROUP BY and analytics
- `04-advanced.sql` - Window functions and CTEs

### BTEQ Scripts (*.bteq)
- `05-bteq-export.bteq` - Export data to file
- `06-bteq-report.bteq` - Formatted report generation

### TPT (Teradata Parallel Transporter) Scripts
- `run_tpt.sh` - Bulk load sales data using TPT
- `sales_data.txt` - Sample data for TPT load

### Jupyter Notebook
- `teradata-vantage-demo.ipynb` - Python data analysis notebook for Teradata Vantage
  - Connects to Teradata using environment variables
  - Demonstrates SQL queries with pandas DataFrames
  - Includes data visualizations (matplotlib, seaborn)
  - Advanced analytics and summary statistics

## Getting Started

**Prerequisites**: Database `${DB_USERNAME}_DEMO` must already exist

1. **In SQL Assistant**: Open `00-setup.sql` and run to create tables and load data
2. **In TD Terminal**: Try BTEQ scripts with `bteq < 05-bteq-export.bteq`
3. **For TPT bulk load**: Run `./run_tpt.sh` (truncates and reloads SALES table)
4. **In JupyterHub**: Open `teradata-vantage-demo.ipynb` for Python-based data analysis with visualizations

## Environment Variables

All scripts use pre-configured environment variables:
- `DB_HOST` - Teradata host
- `DB_USERNAME` - Your username
- `DB_PASSWORD` - Your password
