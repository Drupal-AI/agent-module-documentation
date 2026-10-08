<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Canvas Entity Reference (canvas_entity_reference) — agent index

Makes **Canvas (Experience Builder) component props reference Drupal content entities**. A
component author adds an `x-entity-type` JSON Schema annotation (or the legacy
`taxonomy-term-reference` `$ref` URI) to a prop in its `.component.yml`, and the module auto-wires
an `entity_reference` field with the right storage, handler, widget, cardinality, and Canvas
live-preview transforms — no custom field config or PHP. Package **Canvas**. Depends on
**`canvas`**. Core `^10.3 || ^11 || ^12`. `lifecycle: experimental`. License GPL-2.0-or-later.
Version 1.0.4.

- **Config form, config object + schema, the settings keys** →
  [config/settings.md](config/settings.md)
- **The shape matcher, hooks, annotations, Twig `entity_render()`, the auto-create endpoint** →
  [api/shape-matching.md](api/shape-matching.md)

## What it actually is (from source)

- **One hook orchestrator**, `EntityReferenceHooks` (`src/Hook/EntityReferenceHooks.php`, attribute
  hooks): `canvas_storable_prop_shape_alter` delegates to the shape matcher; `field_widget_info_alter`
  registers Canvas transform metadata on `entity_reference_autocomplete` (single) and
  `entity_reference_autocomplete_tags` (multi); two `field_widget_single_element_*_form_alter` hooks
  attach the auto-create JS behaviour + a `_canvas_ref_sentinel` hidden field.
- **One service**, `EntityReferenceShapeMatcher`
  (`src/ShapeMatcher/EntityReferenceShapeMatcher.php`): `matches()` recognises the prop shape,
  `apply()` builds the `ReferenceFieldTypePropExpression`, storage/instance settings, widget, and
  cardinality from the schema annotations + module config.
- **One Twig extension**, `EntityRenderExtension` (`src/Twig/EntityRenderExtension.php`): the
  `entity_render(entity_type, entity_id, view_mode='default')` function. Loads the entity, checks
  `access('view')`, renders via the entity view builder; returns `''` on empty id / not-found /
  no-access / exception.
- **One controller**, `AutoCreateTermController` (`src/Controller/AutoCreateTermController.php`):
  POST `/api/canvas-entity-reference/create-term`, creates/matches a taxonomy term for the
  auto-create widget.
- **Constants** in `src/EntityReferenceConstants.php` — config name/keys, widget IDs, the
  `REF_URI_TO_ENTITY_TYPE` map (taxonomy_term, node, user, media, block_content).
- **`schema.json`** — the 5 well-known `$defs` (`taxonomy-term-reference`, `node-reference`,
  `user-reference`, `media-reference`, `block-content-reference`).

## Routes

- `canvas_entity_reference.settings` → `/admin/config/content/canvas-entity-reference`
  (`SettingsForm`, perm `administer site configuration`).
- `canvas_entity_reference.auto_create_term` → POST `/api/canvas-entity-reference/create-term`
  (perm `access content` + `_csrf_token: TRUE`; controller additionally requires
  `administer taxonomy` or `edit terms in <vocab>` before creating).

## Config / provides

- Config object **`canvas_entity_reference.settings`** — keys `widget`, `target_bundles`
  (sequence), `auto_create` (bool). Schema in `config/schema/`, install defaults in `config/install/`.
- No permissions defined, no Drush, no plugin types. JS libraries `auto_create` and
  `canvas.transform.entityReferenceAutocomplete`.
- Ships example test SDCs under `components/` (media/node/user/multi/bundle-filter/etc.) — examples,
  not required.
