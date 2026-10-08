<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
DCAT models the W3C Data Catalog Vocabulary as first-class Drupal content entities so a site can describe and publish datasets as structured, machine-readable metadata.
---
The module defines four content entity types — Dataset, Distribution, Agent and vCard (contact point) — each with its own bundle-less entity, permission set, list builder, HTML route provider and access-control handler. A Dataset references Distributions (the actual downloadable files/services), an Agent (publisher/organisation) and a vCard (contact point), plus two designated taxonomy vocabularies (`dataset_keyword`, `dataset_theme`) whose delete/vid options are locked by a form alter. Field defaults can be centrally enforced through the `dcat_field_default` config entity and a `DcatFieldProvider` plugin type that supplies the core fields for each class. The bundled `dcat_export` submodule serialises all DCAT entities into a single RDF feed (via easyrdf/easyrdf) at `/dcat`, gated by the `access dcat export feed` permission.

Access is permission-based per entity type: each of Dataset/Distribution/Agent/vCard has add/edit/delete/administer/view-published/view-unpublished permissions enforced by a dedicated access-control handler (admins with `administer <type> entities` get full access, otherwise view checks published state). Admin UI lives under `/admin/structure/dcat` behind `access dcat admin pages`; field-default rules need `administer dcat field defaults`. Typical setup: enable the module, grant the relevant per-entity permissions, create Agent and vCard records, then create Datasets with Distributions and (optionally) enable `dcat_export` to publish the RDF feed.
---
Create a Dataset entity describing an open-data resource.
- Attach one or more Distributions (files/URLs) to a Dataset.
- Record a publishing Agent (organisation) for datasets.
- Add a vCard contact point for a dataset.
- Tag datasets with the `dataset_keyword` vocabulary.
- Classify datasets against the `dataset_theme` vocabulary.
- Browse all datasets at the Dataset overview page.
- Grant editors `add dataset entities` to let them create datasets.
- Restrict dataset viewing to `view published dataset entities`.
- Expose unpublished datasets only to trusted roles.
- Configure per-entity-type settings under DCAT types.
- Define enforced field-default rules via DCAT Field Defaults.
- Extend the fields of a DCAT class with a DcatFieldProvider plugin.
- Enable `dcat_export` to publish a combined RDF feed at `/dcat`.
- Limit feed access with the `access dcat export feed` permission.
- Administer export settings under DCAT settings.
- Manage Agents and vCards from the Content admin menu.
- Lock the designated DCAT taxonomies against accidental deletion.
- Build Views over Dataset/Distribution/Agent/vCard entities.
- Reference DCAT entities from other content via entity reference.
- Integrate external DCAT providers' metadata into the site.