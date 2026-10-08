<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Slug and Slug Path field types

## Install & enable

```bash
composer require drupal/entity_slug   # pulls drupal/pathauto:~1.0
drush en entity_slug -y
```

Dependency: **`pathauto`** (declared in `entity_slug.info.yml` and `composer.json`). No submodules,
no permissions, no Drush commands, no admin settings page.

## The two field types

Both live in `src/Plugin/Field/FieldType/` and extend `SlugItemBase`:

| Field type id | Class | Default widget | Default formatter | Notes |
|---|---|---|---|---|
| `slug` | `SlugItem` | `slug_default` | `slug_default` | Single URL-friendly identifier. |
| `slug_path` | `SlugPathItem` | `slug_path_default` | `slug_default` | Multiple slugs joined into a `/`-path. |

Both declare `category = "Slug"` in their `@FieldType` annotation, so they appear grouped as *Slug*
in the *Add field* UI.

### Storage (`SlugItemBase::schema()` / `propertyDefinitions()`)

Two `varchar(255)`, nullable columns / string properties:

- **`input`** — the raw text the editor typed (may contain tokens). This is the "source of truth".
- **`value`** — the generated slug, produced from `input` on save.

`isEmpty()` returns true when **`input`** is null or `''` (the generated `value` is ignored for
emptiness).

## Field settings (`SlugItemBase::defaultFieldSettings()` / `fieldSettingsForm()`)

Two settings, edited on the field's *settings* tab:

| Setting key | Default | Meaning |
|---|---|---|
| `slugifier_plugins` | `{ token: token, pathauto: pathauto }` | Checkboxes of enabled Slugifier plugins for this field. Options come from `SlugifierManager::getDefinitions()`, ordered by plugin `weight`. |
| `force_default` | `FALSE` | When on, the field's value is forced to the field's **default value literal** on every save (editor input is ignored). |

There is **no config schema** shipped for these settings (`config/schema/` does not exist), so
strict config-schema tooling may warn about the field-config `settings` — they still save and work.

## Widget

`SlugWidgetBase::formElement()` (`src/Plugin/Field/FieldWidget/`) renders:

- `input` — a `textfield` (`#size` 60, `#maxlength` 255) bound to the item's `input` value;
- `information` — an `item_list` of help strings; the base string plus each enabled slugifier's
  `information()` lines (so the editor sees what the current slugifier stack will do);
- `token_help` — a `token_tree_link` (`#token_types => 'all'`; a source `TODO` notes it is not yet
  scoped to the host entity type).

`SlugPathWidget::getInformation()` prepends *"Multiple slugs can be separated with a '/' to form a
path."* before the base help.

## Formatter

`SlugFormatter` (id **`slug_default`**, `field_types = { slug, slug_path }`) is trivial:
`viewElements()` outputs each item as `['#type' => 'markup', '#markup' => $item->value]` — i.e. the
already-generated slug string. (The `@FieldFormatter` annotation's `module = "slug_field"` is a
harmless mislabel; the plugin is discovered normally.)

## The save / slugify pipeline

1. **`SlugItemBase::preSave()`** — if `force_default` is set, overwrite `input` with
   `getFieldDefinition()->getDefaultValueLiteral()[0]['input']`; then set
   `value = slugify(input)` and call `parent::preSave()`.
2. **`entity_slug_entity_presave()`** (`entity_slug.module`) — belt-and-braces for forced defaults:
   for every `slug`/`slug_path` field on the entity whose `force_default` setting is on, it re-sets
   `$field->input` to the default literal and calls `$field->preSave()` again. (This is why a forced
   field ignores editor input entirely.)
3. **`SlugItemBase::slugify($input)`** — fetch enabled slugifiers via `getSlugifiers()`, then run
   `$input` through each `->slugify($slug, $entity)` in turn, feeding the previous output into the
   next. Order is by plugin `weight` (`SortArray::sortByWeightProperty`, ascending).
4. **`SlugPathItem::slugify($input)`** — overrides the above: `explode('/', trim($input,'/'))`, run
   each segment through `parent::slugify()`, `implode('/')`, and return with a single leading `/`.

`getSlugifiers()` reads `slugifier_plugins`, `array_filter`s the enabled ones, instantiates each via
`plugin.manager.slugifier`, and `uasort`s by weight — so with the defaults, `token` (weight -50)
runs before `pathauto` (weight 50): tokens are replaced first, then the whole string is cleaned into
a URL-safe form.

## Operating notes

- **Uniqueness is not enforced.** The module never checks for duplicate `value`s and provides no
  route. If slugs must be unique, add your own validation/constraint or a unique index.
- **Re-saving applies current settings.** Because `value` is regenerated on every save from `input`,
  changing Pathauto's cleaning settings (or the enabled slugifier set) only takes effect for a given
  entity when it is next saved.
- **The generated value is what you consume.** The module does not wire the slug into routing,
  aliases, or menus — read `field_x.value` wherever you need it.
