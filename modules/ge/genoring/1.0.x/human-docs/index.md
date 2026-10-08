# GenoRing — manual setup guide

**GenoRing** (`genoring`) is a framework for managing **biological (genomic)
data** in Drupal. It's aimed at laboratories and research teams — especially
those with limited resources — who need to curate and share scientific data
without building bioinformatics infrastructure from scratch. This module centres
on a `genoring_dataset` entity and a set of admin tools that discover, describe,
and ingest scientific data files.

The heart of the module is a **locator → processor pipeline**. *Data locator*
plugins (Default, Metadata, Taxonomy, MetadataTerm) scan your data directories to
find candidate files and metadata; *data processor* plugins (such as the GFF3
processor) parse those files and turn them into managed data. Datasets are
created against a **data model**, which comes from the external‑entity data‑model
dependency (`xnttdm`), and other modules can contribute their own models, file
types, and operations through GenoRing's event system. A taxonomy service handles
organism identification by taxid, code, or name.

An important caveat: **this Drupal module is only one part of the wider GenoRing
platform**, which bundles "à la carte" bioinformatics tools around it. The
project recommends installing GenoRing through the platform rather than as a
standalone module. If you install just this module, you'll get the data‑management
UI but not the surrounding platform tooling.

It depends on core's **File** (`file`) module and the **xnttdm** module, and
ships an optional **`genoring_jbrowse`** submodule that integrates the JBrowse
genome browser. Management screens are gated behind the `administer genoring` and
`access administration pages` permissions.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its
   dependencies, and note the recommended platform install.
2. [Configuration](configuration/index.md) — the dashboard, data models,
   datasets, the locator/processor pipeline, and organism taxonomy.

## Where it lives in the admin menu

GenoRing's home is its **dashboard** at `/genoring` (config route
`genoring.dashboard`), which gives an overview of your data files, uploads,
datasets, and data models. From there you reach the data manager, data locator,
data processor, and taxonomy manager. The full workflow is described in
[Configuration](configuration/index.md).
