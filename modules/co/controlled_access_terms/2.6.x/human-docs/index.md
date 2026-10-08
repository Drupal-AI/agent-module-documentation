# Controlled Access Terms — manual setup guide

**Controlled Access Terms** (`controlled_access_terms`) brings standards‑based
**authority control** to Drupal for libraries, archives, and digital‑collection
projects. Cultural‑heritage and scholarly metadata does not use free‑text tags; it
uses *authorities* — controlled records for a person, place, or subject, usually
linked to an external identifier such as LCNAF, VIAF, or geonames. This module
supplies the pieces needed to model that: structured vocabulary types for the
standard agent and subject entities, and a field that can carry an authority link.

Concretely, it creates taxonomy bundles for the named entities common in archival
description — **Corporate Bodies**, **Families**, **Persons**, and subject **Topic**
and **Geographic** terms — and it adds several specialised field types that assist
library and archival cataloguing: **EDTF Dates**, **Authority Links**, and **Typed
Relations**. The authority‑link field is what connects a local term to its external
authority record.

It is designed to work alongside (but does not depend on) the ArchivesSpace/Drupal
integration and **Islandora**, and can be used on its own. It does depend on the
**Geolocation** module (for geographic terms) and **Token**. This is very much a
metadata‑serious tool — for a digital collection, archive, or research repository —
and would be far more structure than a general content site needs. A `_defaults`
submodule ships default configuration so you have a working starting point.

Note that despite the word "access" in its name, this module is about
*authority‑controlled* terms and metadata modelling, not about permissions or
restricting who can view content. It has no central settings page — you work with
the vocabularies and fields it provides.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and optionally enable the defaults submodule.

There is **no dedicated settings page** for this module. It provides vocabularies
and field types that you use through Drupal's normal Taxonomy and Field UI, as
described in "How to use it" below.

## Where it lives in the admin menu

The module adds no configuration form of its own. You work with what it provides
through core admin pages:

- **Structure → Taxonomy** (`/admin/structure/taxonomy`) — the vocabulary bundles
  for Persons, Families, Corporate Bodies, Topic, and Geographic terms.
- **Field UI** on your content types and vocabularies — where you add the EDTF
  Dates, Authority Links, and Typed Relations field types to your entities.

## How to use it

1. Enable the module (and, to start from ready‑made configuration, the `_defaults`
   submodule — see [Installation](installation/index.md)).
2. Under **Structure → Taxonomy**, review the authority vocabularies it provides
   and start cataloguing agents (persons, families, corporate bodies) and subject
   terms there instead of using free‑text tags.
3. On your content types (or on the vocabularies themselves), add the module's
   field types where you need them — **EDTF Dates** for archival dating,
   **Authority Links** to connect a term to an external record (LCNAF, VIAF,
   geonames), and **Typed Relations** to express relationships.
4. Populate the authority‑link fields to tie your local terms to their external
   authority records, following your project's metadata practice.
