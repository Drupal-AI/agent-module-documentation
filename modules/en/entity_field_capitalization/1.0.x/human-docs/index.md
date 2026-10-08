# Entity Field Capitalization — manual setup guide

**Entity Field Capitalization** (`entity_field_capitalization`) automatically
capitalizes the values of the entity fields you choose — making the first letter
of each word a capital — whenever an entity is created or updated. It's a quiet
content-consistency helper: instead of relying on editors to type titles and names
in a consistent case, the module enforces it for you on save.

The problem it solves is style drift. Across many editors and imports, the same
kind of value ends up capitalized every which way. Point this module at the fields
that should follow a consistent capitalization and it normalizes them during entity
save/update, so your content stays tidy without manual editing. You can select
**multiple fields across any entity type**, and you can define an **exclusion
list** of strings that should be left exactly as they are — handy for brand names
and terms like *jQuery* that you don't want "corrected".

It needs a small amount of configuration to be useful: on a fresh install it isn't
touching any fields until you list them on the settings form. It supports Drupal 8
through 11, has no module dependencies, and provides its own permission for
reaching the settings.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — choose the fields to capitalize and
   the strings to exclude.

## Where it lives in the admin menu

The settings form is at **Configuration → Entity Field Capitalization settings**
(`/admin/config/field-capitalization-settings`).
