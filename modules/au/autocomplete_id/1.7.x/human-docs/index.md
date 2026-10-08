# Autocomplete Entity ID — manual setup guide

**Autocomplete Entity ID** (`autocomplete_id`) extends Drupal's core entity
autocomplete so editors can find and pick a referenced entity by typing its
numeric **entity ID**, not just its label. If two nodes share the same title, or a
power user is working from a spreadsheet of IDs, they can type `123` and get
`Article title (123)` inserted into the field.

It keeps all of core's normal label matching — the ID suggestion is simply added
at the top of the results list when the number you typed matches a real entity. You
can turn ID matching on **per field** (by choosing a special widget on an entity
reference field) or **globally** (one config toggle that applies to every core
entity autocomplete field at once). Either way, users only ever see ID-based
suggestions if they have the right permission, and they can never surface an entity
they lack view access to.

The module respects the field's bundle restrictions and match limit, works with
both single- and multi-value (tags) fields, and adds no database tables. It has no
dependencies beyond core.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

The global on/off toggle sits at **Configuration → Content → Entity Autocomplete id
settings** (`/admin/config/content/autocomplete-id`). The per-field option lives on
each entity reference field's **Manage form display** tab. Two permissions control
who can administer the setting and who sees ID results.

## How to use it

There are two ways to enable ID matching. First make sure the roles that should see
ID results have the **View entity autocomplete id results** permission — without
it, a field falls back to core's label-only matching even when everything else is
switched on.

### Option A — per field (recommended)

1. Go to the entity reference field's **Manage form display** tab
   (**Structure → Content types → [type] → Manage form display**, or the equivalent
   for other entity types).
2. Change that field's widget to **Autocomplete match ID**.
3. Save. The field now matches by ID as well as by label. This widget is just
   core's autocomplete widget with ID matching added, so all its usual settings
   (match operator, match limit, size, placeholder) still apply.

### Option B — globally

1. Go to **Configuration → Content → Entity Autocomplete id settings**
   (`/admin/config/content/autocomplete-id`). You need the **Administer entity
   autocomplete id** permission.
2. Tick the single checkbox to enable ID matching for **every** core entity
   autocomplete field on the site — no per-field change needed.
3. Save.

Global mode requires both the toggle *and* the "View entity autocomplete id
results" permission before anyone sees ID suggestions. You can also set the flag
from the command line:

```bash
drush cset autocomplete_id.settings autocomplete_id_global true -y
```

### For developers

The module also provides an `entity_id_autocomplete` render element you can use in
custom forms exactly like core's `entity_autocomplete`, except users may type a
bare ID. See the [`agent/`](../agent/start.md) docs for the element and widget
details.
