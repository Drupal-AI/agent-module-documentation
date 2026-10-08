Data Pipelines is a Drupal ETL framework that ingests CSV/JSON data from files, URLs or pasted text, runs it through a developer-defined validation/transform pipeline, and writes the result to configurable destinations.

---

The module centres on a `data_pipelines` (Dataset) content entity whose bundle is a **source plugin** — CSV or JSON, each available as a File, remote URL (Uri) or Text resource. A dataset also references a **pipeline** (a code plugin declared in YAML in `{module}.data_pipelines.yml`, made of field/record transforms and core validation constraints) and one or more **destination** config entities (a JSON File or CSV File writer ships in core; the Elasticsearch, OpenSearch and SFTP sub-projects add more). Content editors manage datasets at `/admin/content/datasets`; destinations are configured at `/admin/config/content/dataset_destinations`. When a dataset is saved it is queued for validation and processing via the Batch and Queue APIs (each dataset gets its own derived queue worker), so large inputs are processed outside the save request. Transforms include map, concat, remove and skip; validation reuses Drupal's typed-data constraint system plus a bundled `ItemCount` and `JsonPath` constraint. A `data-pipelines:reindex` and `data-pipelines:list` Drush command set is provided.

---

- Import a CSV file uploaded by a content editor and write the normalised rows to a JSON file.
- Ingest a JSON feed from a remote URL and index its records into a destination.
- Paste raw CSV or JSON text directly into a dataset for quick one-off processing.
- Select the CSV delimiter (comma, semicolon, tab, pipe or colon) per dataset.
- Use a JSONPath expression to drill into a nested JSON document and extract the array of records to process.
- Define a reusable pipeline in YAML that applies the same transforms/validations across many datasets.
- Map coded source values to canonical values (e.g. `Y`/`N` to `true`/`false`) with the `map` field transform.
- Concatenate several source columns into one field (e.g. last + first name) with the `concat` record transform.
- Drop unwanted columns from every record with the `remove` transform.
- Skip records that match (or don't match) a field value with the `skip` transform.
- Enforce a required record shape with the `ItemCount` record constraint (exact column count).
- Apply core field constraints such as `NotBlank` and `Length` to named source fields.
- Configure a JSON File destination that writes to a chosen file scheme and sub-directory.
- Register additional destinations (Elasticsearch/OpenSearch search indices, SFTP upload) from contributed sub-projects.
- Send the same processed dataset to multiple destinations at once via unlimited-cardinality destination references.
- Choose a batch size (10 to 100,000 rows) per dataset to trade throughput against memory use.
- Decide whether records that become invalid on re-processing are retained or removed (`invalid_values` handling).
- Unpublish a dataset to purge its data from all destinations without deleting the dataset definition.
- Re-run processing on demand from the dataset's **Process** tab, or in bulk with `drush data-pipelines:reindex`.
- List and filter existing datasets by pipeline or destination with `drush data-pipelines:list`.
- Iterate a dataset's transformed, valid records programmatically via `$dataset->getDataIterator()`.
- Add a custom source plugin to ingest a new file/field type by implementing `extractDataFromDataSet` and `buildFieldDefinitions`.
- Add a custom destination plugin to push processed data to any external system.
- Cache remote-URL fetches for 24 hours so repeated processing does not re-download the source.
- Strip BOM and non-printing/DOS characters from CSV input automatically during extraction.
