# 📂 Hadoop Data Ingestion Script

### 📝 Project Description

This repository contains a simple **bash script** (`landing.sh`) that automates a fundamental data engineering task: **ingesting data from a web source into HDFS**. The script downloads a `.csv` file from a public GitHub repository to a local "landing" directory and then transfers it to a designated HDFS directory. The process includes a cleanup step to remove the temporary local file.

---

### 🚀 The Challenge and Solution

#### **Initial Problem**

The first version of the script resulted in a "**command not found**" error for `curl`. This happened because the `curl` executable's directory was not in the system's `PATH` environment variable, preventing the script from finding and executing it.

#### **Solution**

To resolve this, the script (`landing.sh`) was updated to use **`wget`**, a common alternative for downloading files. `wget` was correctly installed and accessible on the system. This change bypassed the `PATH` issue and allowed the script to function as intended.

---

### ✅ Execution and Results

The updated script successfully completed the entire process, as shown by the terminal output and HDFS verification.

#### **Terminal Output**

The script's execution log confirms the successful download and transfer.

```bash
hadoop@9438ecee3c21:~/scripts$ ./landing.sh
Creando el directorio temporal /home/hadoop/landing si no existe...
Descargando el archivo starwars.csv al directorio /home/hadoop/landing...
--2025-09-16 08:02:40--  [https://raw.githubusercontent.com/fpineyro/homework-0/master/starwars.csv](https://raw.githubusercontent.com/fpineyro/homework-0/master/starwars.csv)
... (download progress) ...
2025-09-16 08:02:40 (12.2 MB/s) - '/home/hadoop/landing/starwars.csv' saved [5462/5462]

Enviando el archivo a HDFS en el directorio /ingest...
Borrando el archivo local...
Script terminado. El archivo se ha movido exitosamente a HDFS.
```

### HDFS Verification

The final check confirms the `starwars.csv` file now resides in the `/ingest` directory of HDFS.

```bash
hadoop@9438ecee3c21:~/scripts$ hdfs dfs -ls /ingest
Found 2 items
-rw-r--r--  1 hadoop supergroup      5462 2025-09-16 08:02 /ingest/starwars.csv
-rw-r--r--  1 hadoop supergroup 125981363 2022-05-09 17:58 /ingest/yellow_tripdata_2021-01.csv
```

### 📜 How to Use the Script

1.  Clone the repository to your local machine.
2.  Ensure `wget` is installed by running `which wget`. If not, install it via your package manager (e.g., `sudo apt-get install wget`).
3.  Give the script execute permissions with `chmod +x landing.sh`.
4.  Run the script with `./landing.sh`.
