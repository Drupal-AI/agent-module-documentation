# Views Core Entity Reference — manual setup guide

**Views Core Entity Reference** (`views_core_entity_reference`) makes your
entity‑reference fields filter nicely in Views. Out of the box, when you add an
entity‑reference field (say "Related articles" or a taxonomy‑term reference) as a
filter or exposed filter in a View, Drupal offers only a raw comparison against
the referenced entity's numeric **target id** — so an editor has to know that
"Sports" is term `42` and type `42`. This module opts those filters into
Drupal Core's built‑in `entity_reference` Views filter instead, which renders as a
proper **Select list or Autocomplete of the actual referenced entities**. Editors
pick "Sports" by name; nobody guesses ids.

There is nothing to configure. The module is a tiny glue layer with no settings
form, no permissions, and no plugins of its own. When it's enabled it quietly
rewrites the Views data so that every entity‑reference field's `*_target_id`
filter uses core's `entity_reference` handler wherever it was previously the
generic numeric or string handler. The capability already exists in Drupal Core
(10.2+); this module simply turns it on for your reference fields automatically.

If your site previously relied on the long‑standing core *patch* that added this
filter, the module also runs a one‑time migration when you install it. That
migration cleans up the old `_reference` suffix the patch appended to filter ids
and operators in your saved views, so views built against the patched core keep
working after you switch to this module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

Nowhere — there is no settings page. The module has no admin UI of its own.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Rebuild caches with `drush cr` so Views picks up the changed field data.
3. Edit any View that filters (or exposes a filter) on an entity‑reference field.
   The filter for that field now offers a **Select** or **Autocomplete** widget of
   the referenced entities instead of asking for a numeric entity id.

That's the whole workflow. Because the change applies automatically to every
entity‑reference field on the site, you don't have to touch each view by hand or
write your own `hook_views_data_alter()`.
