<summary><b style="color:Maroon;">Apache Airflow on docker</b></summary>

<sub>The `AIRFLOW_HOME` is set by default to /opt/airflow/ - this means that DAGs are by default in the /opt/airflow/dags folder and logs are in the /opt/airflow/logs<sub>

```bash
# make directories
mkdir airflow-etl
cd airflow-etl
mkdir dags logs plugins

# fetch docker-compose.yaml
curl -LfO 'https://airflow.apache.org/docs/apache-airflow/2.9.2/docker-compose.yaml'

# compose the requirements and get image airflow-init, redis, postgres
docker compose up -d airflow-init

# start all the service
docker compose up -d
```