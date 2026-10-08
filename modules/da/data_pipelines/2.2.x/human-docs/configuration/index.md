# Configuration

Setting up Data Pipelines has two halves: a **developer** defines the pipeline in
code, and then an **editor** (or administrator) creates datasets that run through
it from the admin UI. This page covers both, plus the permissions that keep the
whole thing safe.

## 1. Define a pipeline (developer, in YAML)

A pipeline is a named series of **transforms** and **validation rules** that data
passes through, ending at one or more **destinations**. You declare it in YAML
following the module's README — this is a code/config task rather than a form. A
pipeline decides:

- the shape of the data it expects,
- the transforms applied to each record,
- the validation rules (including JSON‑path based checks) that a record must pass,
- and the destination(s) the transformed data is written to (JSON and CSV file
  outputs ship by default; connector modules add others such as SFTP sources or
  OpenSearch/Elasticsearch destinations).

Because pipelines process input you should treat as **untrusted**, put real thought
into the validation rules — that is the layer that protects the rest of the system
from malformed or malicious input.

## 2. Manage datasets (editor, in the UI)

Once a pipeline exists, go to **Content → Datasets** (`/admin/content/datasets`)
to add and manage datasets. A dataset is a concrete run of data through a pipeline —
you provide the source (a **CSV or JSON** file upload, or a CSV/JSON **URL**),
choose the pipeline, and the module ingests, validates, transforms, and writes the
result to the pipeline's destination. From this screen editors keep datasets up to
date over time.

## 3. Set permissions

Data Pipelines provides its own permissions, and getting these right is the main
security control for the module. On **People → Permissions**:

- Grant the dataset‑management permissions only to **trusted operators**. Pipeline
  operations run with the site's privileges, so anyone who can run a pipeline is
  effectively trusted with what those operations can do.
- Keep the ability to define/upload data sources restricted to roles you trust to
  supply data, since ingested input is treated as untrusted until validated.

## Connectors

If you install a connector module, its extra source or destination becomes
available when you configure a dataset:

- **SFTP source** — see the
  [Data Pipelines SFTP](https://www.drupal.org/project/data_pipelines_sftp) guide;
  its credentials are stored via the Key module.
- **OpenSearch destination** — see the
  [Data Pipelines OpenSearch](https://www.drupal.org/project/data_pipelines_opensearch)
  guide; it sends data to an external cluster, so mind credentials and egress.
