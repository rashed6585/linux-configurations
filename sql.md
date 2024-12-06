SQL> set loadformat csv
SQL> unload DUMMY_TBL_DAILY_CX_360_KPI_small

format csv

column_names on
delimiter ,
enclosures ""
encoding UTF8
row_terminator default

** UNLOAD Start ** at 2024.12.06-11.55.11
Export Separate Files to /home/appadmin/tools/datasets/export
DATA TABLE DUMMY_TBL_DAILY_CX_360_KPI_SMALL
File Name: /home/appadmin/tools/datasets/export/DUMMY_TBL_DAILY_CX_360_KPI_SMALL_DATA_TABLE.csv
Number of Rows Exported: 1000000
** UNLOAD End ** at 2024.12.06-12.01.09
SQL> exit

SQL> set loadformat loader
SQL> unload DUMMY_TBL_DAILY_CX_360_KPI_small

format loader

** UNLOAD Start ** at 2024.12.06-11.39.43
Export Separate Files to /home/appadmin/tools/datasets/export
DATA TABLE DUMMY_TBL_DAILY_CX_360_KPI_SMALL
File Name: /home/appadmin/tools/datasets/export/DUMMY_TBL_DAILY_CX_360_KPI_SMALL_DATA_TABLE.ldr
File Name: /home/appadmin/tools/datasets/export/DUMMY_TBL_DAILY_CX_360_KPI_SMALL_DATA_TABLE.ctl
Number of Rows Exported: 1000000
** UNLOAD End ** at 2024.12.06-11.46.32

~/tools/datasets ❯ ./export_dummy_table.sh                                                                                                   appadmin in PBVU-ACE-INTELAUTO in 19s12:40:01
Enter DB User: islam3982
Enter DB Password:
Exporting 1000000 rows from VW_TBL_BASE_SNP_CX_360_KPI_SMALL into 2 CSV file(s) on Fri Dec  6 12:40:19 PM +06 2024...
Created file: VW_TBL_BASE_SNP_CX_360_KPI_SMALL_part1.csv
Created file: VW_TBL_BASE_SNP_CX_360_KPI_SMALL_part2.csv
Export completed. Files are saved in ./export on Fri Dec  6 01:06:26 PM +06 2024.

~/tools/datasets ❯ ll export
-rw-rw---- 1 appadmin appadmin 1.8G Dec  6 12:01 DUMMY_TBL_DAILY_CX_360_KPI_SMALL_DATA_TABLE.csv
-rw-rw---- 1 appadmin appadmin 7.7K Dec  6 11:46 DUMMY_TBL_DAILY_CX_360_KPI_SMALL_DATA_TABLE.ctl
-rw-rw---- 1 appadmin appadmin 1.8G Dec  6 11:46 DUMMY_TBL_DAILY_CX_360_KPI_SMALL_DATA_TABLE.ldr

~/tools/datasets ❯ ll export                                                                                                              appadmin in PBVU-ACE-INTELAUTO in 26m23s13:06:26
total 4.6G
-rw-rw---- 1 appadmin appadmin 1.8G Dec  6 12:01 DUMMY_TBL_DAILY_CX_360_KPI_SMALL_DATA_TABLE.csv
-rw-rw---- 1 appadmin appadmin 7.7K Dec  6 11:46 DUMMY_TBL_DAILY_CX_360_KPI_SMALL_DATA_TABLE.ctl
-rw-rw---- 1 appadmin appadmin 1.8G Dec  6 11:46 DUMMY_TBL_DAILY_CX_360_KPI_SMALL_DATA_TABLE.ldr
-rw-rw---- 1 appadmin appadmin 592M Dec  6 12:51 VW_TBL_BASE_SNP_CX_360_KPI_SMALL_part1.csv
-rw-rw---- 1 appadmin appadmin 592M Dec  6 13:06 VW_TBL_BASE_SNP_CX_360_KPI_SMALL_part2.csv