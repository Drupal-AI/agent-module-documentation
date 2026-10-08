# Select2 — manual setup guide

**Select2** (`select2`) integrates the Select2 JavaScript library into Drupal,
turning ordinary `<select>` boxes and entity reference fields into searchable,
tag-style widgets. It also provides a reusable `select2` form render element you
can drop into any custom form.

The module ships two field widgets — **`select2`** for list fields
(`list_integer`, `list_float`, `list_string`) and **`select2_entity_reference`**
for entity reference fields — plus a `#type => 'select2'` render element. For
entity reference fields the widget adds two big capabilities on top of core:
**autocomplete**, where options are lazy-loaded over AJAX so the field scales to
thousands of entities, and **autocreate/tags**, where typing a new label creates
the referenced entity on the fly, mirroring core's entity-reference autocomplete.

The render element sets sensible Select2 defaults — placeholder, clear button,
right-to-left and translated UI, per-theme styling, and a maximum selection count
drawn from the field's cardinality — all of which you can override per property.
It relies on the external Select2 JavaScript library (installed under
`/libraries/select2`) and provides Claro, Gin, and Seven admin-theme integrations.
Multiple selections are drag-reorderable. Two submodules extend it: **Select2
Facets** brings a Select2 widget to the Facets module, and **Select2 Publish**
marks referenced entities with their published status in the dropdown.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, add
   the required Select2 JavaScript library, and enable the submodules you want.
2. [Configuration](configuration/index.md) — the two field widgets and their
   settings (width, autocomplete, match operator and limit, autocreate).

## Where it lives in the admin menu

Select2 has no global settings page. You apply it per field on the entity's
**Manage form display** page (for example **Structure → Content types → *(type)* →
Manage form display**) by choosing a Select2 widget and configuring it with the
gear icon.

## How to use it

1. Install the module and the Select2 library (see
   [Installation](installation/index.md)).
2. Go to **Manage form display** for a content type (or other entity), find a list
   or entity reference field, and set its widget to **Select2** (or **Select2
   (entity reference)**).
3. Click the gear icon to set the widget's options — see
   [Configuration](configuration/index.md).
4. Save. The field now renders as a searchable Select2 box on the entity form.

To use it in code, add a `#type => 'select2'` element to a form and override any
Select2 option through the `#select2` property.
