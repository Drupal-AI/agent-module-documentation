# Field Defaults — manual setup guide

**Field Defaults** (`field_defaults`) applies a field's configured default value to
**existing** content in bulk. Out of the box, Drupal only applies a field's default value
to *new* entities — if you add a field to a content type that already has hundreds of
nodes, or change a field's default, none of your existing content is touched. Field
Defaults closes that gap: it pushes the field's default onto content that is already
there, either filling only the empty fields or overwriting every entity of that type and
bundle.

It works **one field at a time**. On a field's *Manage fields → Edit* page it adds an
**"Update existing content"** section with a checkbox to overwrite existing content with
the field's default value, an optional per‑language checklist for translations, and a
"Keep existing values" checkbox that limits the update to fields that are currently empty.
Saving the field then runs a batch that loads every matching entity (in small groups) and
writes the field's default into each. The same operation is available headlessly through
the `field_defaults:bulk-update` Drush command (alias `fdbu`), which is handy in deploy or
update hooks.

One thoughtful touch: a single site setting, **"Retain original entity updated time"**
(on by default), preserves each entity's original *changed* timestamp during the update,
so a mass backfill does not re‑sort all your content to the top of "recently updated"
lists. The module targets **Drupal 10 or 11** and depends on core's **Field UI** module.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module.
2. [Configuration](configuration/index.md) — the one global setting, the per‑field
   "Update existing content" controls, and the Drush command.

## Where it lives in the admin menu

Field Defaults has two touch points:

- **Global setting:** **Configuration → System → Field defaults settings**
  (`/admin/config/system/field_defaults/settings`), a single checkbox.
- **The actual update:** on any field's edit form under **Structure → (entity type) →
  Manage fields → (field) → Edit**, in the **"Update existing content"** section (shown to
  users with the *Administer field defaults* permission).

## How to use it

The key thing to remember is that Field Defaults applies the field's **own configured
default value** — it never asks you to type a value during the update. So the workflow is
always: **set the field's Default value first**, then trigger the bulk update. Do the
update either from the field's edit form or with the `fdbu` Drush command — both are
covered in [Configuration](configuration/index.md).
