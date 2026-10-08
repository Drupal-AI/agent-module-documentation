<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
GenoRing is a framework for managing biological (genomic) data in Drupal. It centres on a `genoring_dataset` entity and a set of admin tools — a dashboard, data manager, data locator and data processor — that discover, describe and ingest scientific data files, backed by external-entity data models (dependency on `xnttdm`).

---

Datasets are created against a data model (`/genoring/add/dataset/{model_id}`), and a pluggable pipeline turns raw files into managed data: **DataLocator** plugins (Default, Metadata, Taxonomy, MetadataTerm) find candidate files and metadata, and **DataProcessor** plugins (e.g. `Gff3Processor`) parse them. A GenoRing event system (`GenoringEvents` + subscriber) lets other modules contribute data models, file types and operations; the `genoring_jbrowse` submodule integrates the JBrowse genome browser. A custom form element and a `genoring.taxonomy` service provide organism/taxonomy handling (taxid/code/name matching). All management screens — dashboard, data manager, locator, processor, taxonomy manager, dataset list/add/edit/delete — are behind `access administration pages`, `administer genoring`, or per-entity access. The dataset access handler grants `view` to everyone, but no route exposes an individual dataset view to anonymous users (the list and CRUD routes are all admin/permission-gated).

Typical setup: install GenoRing (and `xnttdm`), open the dashboard at `/genoring`, define/import data models, configure data locators pointing at your data directories, create datasets, and run processors to ingest files.
---
- Manage genomic/biological datasets as `genoring_dataset` entities
- Create a dataset from a chosen data model
- Browse the GenoRing dashboard at /genoring
- Configure data locators to discover data files (/genoring/manager/locator)
- Run data processors to ingest files (/genoring/process)
- Parse GFF3 annotation files with the Gff3Processor plugin
- Locate files by metadata, taxonomy, or metadata-term
- Manage organism taxonomy (/genoring/taxonomy) with taxid/code/name
- Autocomplete taxonomy terms via a JSON endpoint
- List, edit and delete datasets under /genoring/dataset
- Define data models via external-entity data models (xnttdm)
- Contribute data models/file types through GenoRing events
- Extend discovery with a custom DataLocator plugin
- Extend parsing with a custom DataProcessor plugin
- Integrate the JBrowse genome browser (genoring_jbrowse submodule)
- Attach a GenoRing input field element to content
- Restrict data management with the `administer genoring` permission
- Use the data manager to oversee files, uploads and datasets
- Associate datasets with taxonomy/organism terms
- Provide a licensing element on dataset forms
