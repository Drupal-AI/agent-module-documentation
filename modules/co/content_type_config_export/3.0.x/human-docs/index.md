# Content Type Config Export — manual setup guide

**Content Type Config Export** (`content_type_config_export`) gives site builders
a simple way to **export the configuration of bundles** — content types, block
types, paragraph types, and taxonomy vocabularies — as a self‑contained set,
including their fields and form/view displays. The goal is reuse: bundling a
bundle's configuration so it can be transferred to another environment, prepared
for a migration, turned into a reusable content set, or shared across several
Drupal installations.

It is a **configuration‑management / administration** helper. It does not create
new content types or modify existing ones, and it requires no text‑format or
permission changes to the content itself — it reads the structure you already
have and packages it for transfer. The module provides its own permission to
control who may run an export.

One thing to keep in mind before sharing an export: **exported configuration can
contain sensitive values** depending on how your site is set up. Treat an export
file the way you would any configuration dump — gate the module's permission to
trusted administrators, and review what an export contains before handing it to
anyone outside your team. Beyond that permission, the module has no access‑control
role.

The module runs on Drupal 10 and 11, has no dependencies beyond core, and is
actively maintained. Note that this version is **not covered** by Drupal's
security advisory policy — weigh that for production use.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

The export is driven by a straightforward admin flow rather than a persistent
settings form, so it is described here in "How to use it" rather than in a
separate Configuration page.

## How to use it

After enabling the module (and granting its permission to the roles that should
be allowed to export):

1. Open the module's **Content Export** page in the admin UI.
2. **Select the bundle(s)** you want to export — a content type, block type,
   paragraph type, or vocabulary.
3. **Configure which fields and references** are included in the export, so you
   capture the structure you actually need.
4. **Run the export** to generate the output, then move that output to the target
   site or store it for reuse.

Because the module only reads and packages existing configuration, running an
export is non‑destructive — it will not alter your content types or content. Just
remember to review the output for sensitive values before sharing it.
