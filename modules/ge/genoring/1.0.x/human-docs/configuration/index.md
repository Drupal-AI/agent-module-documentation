# Configuration

GenoRing isn't configured through a single settings form — instead you work
through a set of management screens, all reached from the dashboard. The typical
flow is: define your data models, point data locators at your files, create
datasets, and run processors to ingest the data. Everything here requires the
**administer genoring** permission (the dashboard itself also accepts **access
administration pages**).

## The dashboard

Open **`/genoring`** (config route `genoring.dashboard`). This is your overview
of data files, uploads, datasets, and data models — the starting point for every
other screen described below.

## Data models

Datasets are always created against a **data model**. Models come from the
**xnttdm** external‑entity data‑model dependency, and other modules can add more
via GenoRing's event system. You don't build models from scratch on a plain form
here; you define or import them through the data‑model tooling, then reference
them when creating datasets.

## Datasets

A dataset is a `genoring_dataset` entity:

- **List** existing datasets at `/genoring/dataset`.
- **Add** one against a chosen model at `/genoring/add/dataset/{model_id}`.
- **Edit or delete** individual datasets from the list, subject to per‑entity
  access.

## The locator → processor pipeline

This is the core workflow that turns raw files into managed data:

1. **Data locator** — go to `/genoring/manager/locator` and configure
   **DataLocator** plugins to discover files and metadata in your data
   directories. The built‑in locators are **Default**, **Metadata**,
   **Taxonomy**, and **MetadataTerm** — pick the one that matches how your files
   and their metadata are organised.
2. **Data processor** — go to `/genoring/process` and run **DataProcessor**
   plugins against the located files to parse and ingest them. The bundled
   **GFF3 processor** parses GFF3 genome‑annotation files; other processors can
   be contributed by additional modules.

## Organism taxonomy

`/genoring/taxonomy` manages organism taxonomy. It lets you match terms by
**taxid**, **code**, or **name**, backed by GenoRing's taxonomy service, so
datasets can be associated with the correct organism. (There is also a read‑only
autocomplete endpoint used by the term‑matching UI.)

## Extending GenoRing

Developers can extend the pipeline by adding their own DataLocator or
DataProcessor plugins, and can subscribe to GenoRing's events to contribute new
data models, file types, or operations. The `genoring_jbrowse` submodule is an
example of an extension, adding a JBrowse genome‑browser view.

## Access and permissions

All of the management screens above are gated behind **administer genoring** (or,
for the dashboard, **access administration pages**), and dataset create/edit/
delete respect per‑entity access. Grant the **administer genoring** permission
only to the researchers and site administrators who should curate data.
