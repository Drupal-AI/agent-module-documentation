# DCAT-AP — manual setup guide

**DCAT-AP** (`dcat_ap`) extends the base [DCAT](https://www.drupal.org/project/dcat)
module with support for the EU **DCAT-AP 2.1.0** application profile — the
harmonised metadata standard that European data portals expect. If the plain DCAT
model isn't enough because your catalog must follow the DCAT-AP profile (for
example, so your datasets can be harvested by an EU data portal), this is the layer
that adds the required fields and cardinality constraints.

Importantly, it introduces **no new entity types**. It works purely through DCAT's
`DcatFieldProvider` plugin system: it contributes additional dataset fields —
version information (`owl:versionInfo`), "is version of" and "has version"
relationships, source and provenance, and sample distributions — and it *alters*
existing fields to make the DCAT-AP-mandatory ones (dataset **description** and
**publisher**) required. It also adjusts distribution and agent fields to align with
DCAT-AP vocabularies. Once enabled, these fields simply appear on the existing DCAT
entity forms.

Because it is a pure field/metadata layer, there are **no routes, permissions,
services, or settings** to configure. On install it syncs the new and altered field
definitions into the database (the base tables already exist from DCAT), and you're
done. Set-up is literally: install DCAT, then enable DCAT-AP.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (alongside DCAT)
   and enable it.

There is **no configuration page** for this module — it has no settings form,
routes, or permissions of its own. Its effect is entirely in the fields and
constraints it adds to the DCAT entities, which you manage through the base
[DCAT](../../../dcat/2.0.x/human-docs/index.md) module's admin area and entity
forms.

## How to use it

1. Make sure the base **DCAT** module is installed and set up (see
   [Installation](installation/index.md)).
2. Enable DCAT-AP. The extra DCAT-AP fields appear automatically on the Dataset,
   Distribution, and Agent forms, and the mandatory fields (description, publisher)
   become required.
3. Fill in the DCAT-AP metadata as you create datasets, then publish through DCAT's
   export feed (the DCAT Export submodule) for harvesting by DCAT-AP-aware portals.
