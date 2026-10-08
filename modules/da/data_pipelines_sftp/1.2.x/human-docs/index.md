# Data Pipelines SFTP — manual setup guide

**Data Pipelines SFTP** (`data_pipelines_sftp`) is a source connector for the
[Data Pipelines](https://www.drupal.org/project/data_pipelines) module. It lets a
pipeline pull its input from a remote **SFTP** file server rather than from an
uploaded file or a URL — so you can drop data files on an SFTP server and have Data
Pipelines fetch and process them. At present it supports pulling supported source
files (for example JSON) over the SFTP protocol.

It does not work on its own: it **depends on Data Pipelines** (the engine) and on
the **[Key](https://www.drupal.org/project/key)** module. The Key dependency is the
nicest thing about this module from a security standpoint — the SFTP username and
password are stored as a Key entity, and the dataset connection *references* that
Key rather than holding the password in plain configuration. That means the
credentials never end up in your exported config. It runs on Drupal 10.1+ and 11.

A couple of things to keep in mind: the module connects to a **remote SFTP server**
(traffic is encrypted in transit by SSH), and it imports **remote files** that you
should treat as untrusted content once they enter the pipeline — so use a
least‑privilege SFTP account and rely on your pipeline's validation. The module has
no access‑control role of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Data Pipelines and Key.
2. [Configuration](configuration/index.md) — create the credential Key and add the
   SFTP source to a dataset.

## Where it lives in the admin menu

This module adds no page of its own. You use it from **Content → Datasets**
(`/admin/content/datasets`) in the Data Pipelines module — SFTP becomes available
as a source when you configure a dataset's connection, where you point it at a
credential Key created in the Key module.
