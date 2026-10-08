<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Managing data with GenoRing

## Dashboard
`/genoring` (`access administration pages`) — overview of data files, uploads, datasets and data models.

## Data models
Data models come from the `xnttdm` external-entity data-model dependency; other modules can add models
via the GenoRing event system (`DataModelsEvent`, `FileTypesEvent`, etc.).

## Datasets
- List: `/genoring/dataset` (`administer genoring`).
- Add against a model: `/genoring/add/dataset/{model_id}` (entity create access).
- Edit/delete: per-entity access.

## Locator → processor pipeline
1. **Data locator** (`/genoring/manager/locator`, `administer genoring`) — configure DataLocator plugins
   (Default, Metadata, Taxonomy, MetadataTerm) to discover files + metadata in your data directories.
2. **Data processor** (`/genoring/process`) — run DataProcessor plugins (e.g. `Gff3Processor`) to parse
   and ingest located files.

## Taxonomy / organisms
`/genoring/taxonomy` manages organism taxonomy. The `genoring.taxonomy_autocomplete` JSON endpoint
(`_access: TRUE`, read-only) matches terms by `taxid`/`code`/`name` via the `genoring.taxonomy` service.

## Extend
Add `Plugin/Genoring/DataLocator/*` or `Plugin/Genoring/DataProcessor/*` plugins; subscribe to
`GenoringEvents` to contribute data models, file types or operations. The `genoring_jbrowse` submodule
adds a JBrowse genome browser view.
