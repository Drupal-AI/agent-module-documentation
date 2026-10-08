<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The curated entity block plugin

Block plugin `curated_entity_block` in `src/Plugin/Block/CuratedEntityBlock.php` (extends
`BlockBase`, `ContainerFactoryPluginInterface`), derived one-per-display by
`CuratedEntityBlockDeriver`. Each block corresponds to one View display built on the
`curated_entity_block` Views display plugin (see [../views/display.md](../views/display.md)).

## Install & enable

```bash
composer require drupal/curated_entity_block
drush en curated_entity_block -y
```

Only dependency is core **`views`**. No permissions, routes, services or Drush of its own. On
install it ships the example View `curated_entities_example`. To use the optional Custom Element
rendering you also need `drupal/custom_elements` (suggested, not required).

## The deriver

`CuratedEntityBlockDeriver` (`ContainerDeriverInterface`) loads all enabled Views and, for every
display whose plugin id is `curated_entity_block`, emits one block derivative keyed
`{view_id}-{display_id}`. Each derivative carries runtime metadata baked in: `admin_label` (the
display title), `config_dependencies` (the View), `view_id`, `display_id`,
`target_entity_type_id` (the view's base entity type), and `render_mode`. Selection *constraints*
(allowed view modes, entity-count bounds) are **not** baked in — the block reads them live off the
view display via `getDisplayOptions()`.

## Block settings & default configuration

`defaultConfiguration()`:

| Key | Default | Meaning |
|---|---|---|
| `selected` | `[]` | Ordered list of picked entity IDs (strings). |
| `view_mode` | `'default'` | View mode used to render every pick. `'default'` (not `''`) so Canvas accepts the placed block's defaults. |
| `label_display` | `'visible'` | Set explicitly because Canvas rejects `label_display = FALSE` during strict schema validation. |

Schema `block.settings.curated_entity_block:*` (in `config/schema/…schema.yml`) is marked
`FullyValidatable` so the block qualifies as a Drupal Canvas component. `selected` is a sequence of
strings; `view_mode` is a plain string (the short view-mode id, e.g. `teaser`), not a config
relationship.

## The configuration form (`blockForm`)

- **View mode** (`#weight 80`) — a required `select` whose options come from `getViewModeOptions()`:
  `default` plus the entity type's view modes, intersected with the display's `allowed_view_modes`
  when that option is set (empty ⇒ all allowed).
- **Selected** (`#weight 90`) — a `#type => table` with tabledrag ordering (group
  `curated-entity-weight`). One row per current pick plus `EMPTY_ROWS` (3) blank rows so editors can
  add picks without an AJAX rebuild (AJAX is unreliable inside Canvas's settings panel). Each row has:
  - an `entity_autocomplete` element targeting `target_entity_type_id`, using
    `#selection_handler => 'views'` bound to the source view/display, so the **pool is exactly the
    view's referenceable entities**;
  - a `_weight` select for ordering.

`blockValidate()` counts the non-empty picks (`extractSelected()`); an **empty selection is always
valid** (block then falls back to the view). Otherwise it enforces the display's `min_entities`,
`max_entities` and `step_entities` (step checked as `(count - min) % step === 0`).

`blockSubmit()` only rewrites a value when its element was actually submitted (Canvas may submit a
subset), storing the ordered IDs from `extractSelected()` (sorts rows by `_weight`, drops empties).

## Rendering (`build`)

1. Resolve `entity_type_id`, `view_mode` (falls back to `default`), and whether Custom Elements are
   used (`usesCustomElements()` = `render_mode === 'custom_element'` **and** the
   `custom_elements.generator` service is present).
2. Entity IDs come from `getRenderedEntityIds()`: the editor's `selected` picks if any, else
   `getDefaultEntityIds()` — which runs the source view, collects `$row->_entity->id()`, and caps at
   `max_entities` (else `DEFAULT_RENDER_COUNT` = 3). The entity-reference display forces
   items-per-page to 0, so the cap is applied here, not by the view.
3. For each ID: load the entity; **re-check `view` access** with `$entity->access('view', NULL,
   TRUE)` and skip if not allowed; add the access result and entity as cache dependencies; render
   via `custom_elements.generator->generate($entity, $view_mode)->toRenderArray()` when Custom
   Elements are used, otherwise the entity view builder `view($entity, $view_mode)`.
4. Apply collected `CacheableMetadata` to the build.

Because each picked entity's own view access is re-evaluated at render time and the autocomplete
pool is bounded by the view's access filters, a block never renders an entity the viewer may not see.

## Custom Element / decoupled rendering

`render_mode` is a **display-level** (View) setting, not per-block. When a display is set to
`custom_element` and `custom_elements` is installed, each entity is emitted as a Custom Element,
suitable for a Lupus Decoupled frontend (the `lupus_ce_renderer` CE API serves it as JSON).
`calculateDependencies()` on the block adds a hard `custom_elements` module dependency when the
derivative's `render_mode` is `custom_element`; with the default rendering the module is not
required.

## Drupal Canvas notes

The explicit `label_display`/`view_mode` defaults, the `FullyValidatable` schema, and the blank-row
approach (avoiding AJAX rebuilds) exist so the block is a valid, placeable Canvas component whose
settings survive Canvas's partial submits and strict validation.
