# Entity Usage — manual setup guide

**Entity Usage** (`entity_usage`) answers the question every content team
eventually asks: *"where is this being used?"* It tracks the relationships between
entities — recording where each node, media item, taxonomy term, block, file, or
custom entity is referenced by other content — and surfaces that information in a
per-entity **Usage** tab, in reports, in Views, and through a programmatic API.

The module watches *source* entities as they are created, updated, and deleted and
asks a set of pluggable tracking methods to record every *target* entity they point
to. Out of the box it detects relationships made through entity-reference fields
(including Entity Reference Revisions, file, image, and webform fields), link
fields, plain HTML links to entity URLs inside text, entities embedded via Entity
Embed / LinkIt / core media embed, inline `<img>` tags in CKEditor, Layout Builder
inline blocks, and Block Field and Dynamic Entity Reference fields.

Entity Usage does its most valuable work once you configure it: you choose which
entity types are tracked as sources and targets, which tracking plugins are active,
and which entity types show a **Usage** tab on their canonical page. It can also
warn editors when they edit or delete something that is still referenced elsewhere,
preventing accidental breakage. It has **no hard module dependencies**, and it
provides Drush commands to rebuild the usage data after big changes.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — choose tracked types, active plugins,
   the Usage tab, and edit/delete warnings, then rebuild the usage table.

## Where it lives in the admin menu

The settings form is at **Configuration → Content authoring → Entity Usage
Settings** (`/admin/config/entity-usage/settings`, route
`entity_usage.settings.form`). Once you enable the Usage tab for an entity type, a
**Usage** local task appears on that entity's canonical page (e.g. on a node) for
users with the right permission.

## How to use it

After enabling and configuring the module, editors and site managers can:

- Open the **Usage** tab on a node, media item, or term to see every place it is
  referenced.
- Get a **warning** when editing or deleting content that is still in use.
- Regenerate all usage statistics after a bulk import or a configuration change —
  from the batch-update form or with a Drush command.

Because tracking only begins when a source entity is saved, run a rebuild after
first configuring the module so existing content is accounted for.
