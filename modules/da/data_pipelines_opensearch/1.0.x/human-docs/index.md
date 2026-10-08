# Data Pipelines - OpenSearch — manual setup guide

**Data Pipelines - OpenSearch** (`data_pipelines_opensearch`) is a connector for
the [Data Pipelines](https://www.drupal.org/project/data_pipelines) module. It
adds one thing: an **OpenSearch destination**, so that a pipeline can push its
processed data straight into an OpenSearch index. If you are using Data Pipelines
to ingest and transform datasets and you want the result searchable in OpenSearch,
this module is the piece that writes it there.

It is a small extension with a single job — it does not work on its own. It
**depends on the Data Pipelines module**, and you use it entirely from within Data
Pipelines' dataset screens: after enabling it, a new destination type appears when
you configure a dataset's destination. It runs on Drupal 10.1+ and 11.

Two things to plan for because this connector talks to an external system:

- **Egress.** It sends your pipeline data out to an OpenSearch cluster. Make sure
  that is acceptable for the data in question, and that your environment is allowed
  to reach the cluster.
- **Credentials.** Connecting to OpenSearch means authenticating. Store those
  credentials as secrets — an environment variable, ideally surfaced through a Key
  entity — rather than pasting them into plain configuration, and connect over
  HTTPS. See [Configuration](configuration/index.md) for the recommended pattern.

The module has no access‑control role of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Data Pipelines.
2. [Configuration](configuration/index.md) — add the OpenSearch destination to a
   dataset, and handle credentials safely.

## Where it lives in the admin menu

This module adds no page of its own. You use it from **Content → Datasets**
(`/admin/content/datasets`) in the Data Pipelines module — the OpenSearch
destination type becomes selectable when you configure a dataset's destination.
