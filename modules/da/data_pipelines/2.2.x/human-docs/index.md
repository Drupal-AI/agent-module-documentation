# Data Pipelines — manual setup guide

**Data Pipelines** (`data_pipelines`) gives a Drupal site a lightweight ETL
(extract, transform, load) engine for arbitrary datasets. A developer declares a
*pipeline* — a named series of transforms and validation rules — in YAML, and
content editors then get a place in the admin UI to upload or point at data,
which the module ingests, validates, transforms, and writes out to a destination.
It supports **CSV and JSON** as both uploaded files and remote URLs, and ships
JSON and CSV file outputs as default destinations.

The division of labour is the key idea: **developers** define what a pipeline does
(the transforms and validation, including JSON‑path based checks) in code;
**editors** manage the actual *datasets* — the data that flows through a pipeline —
from **Content → Datasets**. The module is extended by connector modules for other
sources and destinations, such as
[Data Pipelines SFTP](https://www.drupal.org/project/data_pipelines_sftp) (an SFTP
source) and
[Data Pipelines OpenSearch](https://www.drupal.org/project/data_pipelines_opensearch)
/ Elasticsearch (index destinations).

It requires **PHP 8.0** and depends on the Link, File, Options, and contrib
**Entity** modules. It provides its own permissions and runs on Drupal 10.3+ and
11.

A word on safety before you build pipelines: this is a data‑processing feature that
runs with the site's privileges and ingests input data you should treat as
**untrusted** — that is exactly why validation is a first‑class part of a pipeline.
The module has no access‑control logic beyond its permissions, so gate those
permissions to trusted operators (see [Configuration](configuration/index.md)).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its dependencies.
2. [Configuration](configuration/index.md) — defining a pipeline, managing
   datasets, and setting permissions.

## Where it lives in the admin menu

Datasets are managed at **Content → Datasets** (`/admin/content/datasets`), where
editors add and manage the data that flows through your pipelines. Pipelines
themselves are declared in YAML by a developer rather than through a form — see
[Configuration](configuration/index.md).
