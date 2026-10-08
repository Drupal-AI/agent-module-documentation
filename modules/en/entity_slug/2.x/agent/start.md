<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Slug (entity_slug) — agent index

Adds two field types — **`slug`** and **`slug_path`** — that turn editor-entered text (optionally
containing tokens) into a **URL-friendly slug** on entity save, via a stack of pluggable
**slugifier** plugins. Package `Fields`. Version **2.x** (installed 2.0.0). Core `^10 || ^11`.
License GPL-2.0-or-later. **Depends on `pathauto`** (`drupal/pathauto:~1.0`).

- **Field types, widget, formatter, the field settings, and the save/slugify pipeline** →
  [fields/slug-fields.md](fields/slug-fields.md)
- **The Slugifier plugin type: every shipped plugin, tokens, weights, and writing your own** →
  [plugins/slugifiers.md](plugins/slugifiers.md)

## What it actually is

- **2 field types** (`src/Plugin/Field/FieldType/`): `SlugItem` (id **`slug`**) and `SlugPathItem`
  (id **`slug_path`**), both extending `SlugItemBase`. Category *"Slug"*. Each stores two varchar(255)
  columns: `input` (what the editor typed) and `value` (the generated slug).
- **2 widgets** (`src/Plugin/Field/FieldWidget/`): `SlugWidget` (**`slug_default`**) and
  `SlugPathWidget` (**`slug_path_default`**) — a plain textfield bound to `input`, with an info list
  and a `token_tree_link`.
- **1 formatter**: `SlugFormatter` (**`slug_default`**) — outputs the stored `value` as `#markup`.
- **1 plugin type**: **Slugifier** (`Plugin/Slugifier`), managed by `SlugifierManager`
  (service `plugin.manager.slugifier`, defined in `entity_slug.services.yml`). 7 shipped plugins:
  `token`, `pathauto`, `entity_token`, `entity_alias`, `term_parent_token`, `short_circuit`.
- **1 hook**: `entity_slug_entity_presave()` in `entity_slug.module` — re-applies the forced default
  value for `slug`/`slug_path` fields whose *Force default value* setting is on.

## Mechanism (from source)

- On save, `SlugItemBase::preSave()` optionally overwrites `input` with the field's default literal
  (when `force_default`), then sets `value = slugify(input)`.
- `SlugItemBase::slugify()` loads the field's enabled slugifiers (`getSlugifiers()`), sorts them by
  the plugin `weight`, and runs `input` through each in turn (`$slug = $slugifier->slugify($slug, $entity)`).
- `SlugPathItem::slugify()` splits on `/`, slugifies each segment via the parent, and rejoins into a
  leading-slash path.
- Default enabled slugifiers per field: **`token` + `pathauto`** (`SlugItemBase::defaultFieldSettings()`);
  the others must be enabled explicitly in the field settings form.

## No security-relevant surface to worry about at the routing layer

- **No routes, no menu links, no permissions, no Drush, no config/install or config/schema.** All
  behavior is field-plugin + one presave hook. Configuration lives entirely in per-field settings
  (`slugifier_plugins`, `force_default`) — there is no admin settings form or config object.
