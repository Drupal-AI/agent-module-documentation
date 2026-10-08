# DCAT-BE — manual setup guide

**DCAT-BE** (`dcat_be`) extends [DCAT](https://www.drupal.org/project/dcat) and
[DCAT-AP](https://www.drupal.org/project/dcat_ap) to implement the **Belgian
Federal DCAT profile** (DCAT-BE / Belgif). If you publish an open-data catalog that
must comply with the Belgian federal profile, this module adds the
Belgium-specific fields, controlled vocabularies, validation rules, and extra
entity types that the profile requires — and produces **DCAT-BE-compliant JSON-LD**
output.

On top of extending the Dataset, Distribution, Agent, and vCard entities (again
through DCAT's field-provider plugin system), DCAT-BE introduces three dedicated
content entity types you manage as reusable, referenced records: **License**,
**Location**, and **Quality Measurement**. It replaces several generic URI fields
with entity references or taxonomy terms aligned to Belgian and EU vocabularies, and
it can enforce bilingual (Dutch/French) metadata through validation.

A key part of the setup is **controlled vocabularies**. The module imports terms
from official sources — Belgif, the EU Publications Office, ADMS, INSPIRE, and QUDT
— as multilingual taxonomy terms (with built-in fallback data if a source can't be
reached), via either the admin UI or Drush. It then **validates** datasets against
DCAT-BE cardinality and mandatory-field rules before export or publication, and
**exports** individual datasets or the whole catalog as DCAT-BE JSON-LD (it overrides
the base DCAT export feed for the catalog output).

Access is governed by granular permissions: an *Administer DCAT BE* permission for
settings and vocabulary import, separate export and validate permissions, and full
CRUD permission sets for each of the three new entity types.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, pull in its many
   dependencies, and enable it.
2. [Configuration](configuration/index.md) — settings, importing the controlled
   vocabularies, and validating and exporting datasets.

## Where it lives in the admin menu

DCAT-BE plugs into the DCAT admin area:

- **Settings:** `/admin/structure/dcat/settings/dcat-be` (*Administer DCAT BE*).
- **Vocabulary import:** `/admin/structure/dcat/vocabulary-import` (*Administer DCAT
  BE*).
- **Validate a dataset:** from a dataset's page at
  `/admin/content/dcat/dataset/{id}/validate` (needs the validate permission plus
  view access to the dataset).

The License, Location, and Quality Measurement entities are managed from the
**Content** admin area.
