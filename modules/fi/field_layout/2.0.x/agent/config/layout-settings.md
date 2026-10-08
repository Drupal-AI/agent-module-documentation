<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field Layout — stored config, schema, install/uninstall, Layout Builder interop

## Where the layout is stored

Field Layout does **not** create its own config object. A display's layout is kept as
**third-party settings** on the standard display config entities, under provider `field_layout`:

- `id` — the layout plugin ID (e.g. `layout_onecol`, `layout_twocol`, any discovered layout).
- `settings` — that layout plugin's configuration array.

So a two-column node teaser display exports as, inside
`core.entity_view_display.node.article.teaser.yml`:

```yaml
third_party_settings:
  field_layout:
    id: layout_twocol
    settings:
      label: ''
      # ...plugin-specific keys...
dependencies:
  module:
    - field_layout
    - layout_discovery
```

Each field component's `region` key (already part of core display config) then names one of the
selected layout's regions; fields whose region is not valid for the current layout are moved to
the layout's default region (see `setLayoutId()` in `api/display-and-builder.md`).

## Config schema

`config/schema/field_layout.schema.yml`:

- Attaches type `field_layout.third_party_settings` to
  `core.entity_view_display.*.*.*.third_party.field_layout` and the matching
  `core.entity_form_display.*` path.
- `field_layout.third_party_settings` is a mapping of:
  - `id`: `string` (label "Layout ID").
  - `settings`: dynamic type `layout_plugin.settings.[%parent.id]` — i.e. the settings are
    validated against the schema of the layout plugin named by the sibling `id`.

There is **no `config/install/`** directory; nothing is written at install beyond backfilling
displays (below).

## Install / uninstall behavior (`field_layout.install`)

- `field_layout_install()`: iterates every `EntityViewDisplay` and `EntityFormDisplay`, and for
  each that is an `EntityDisplayWithLayoutInterface` calls `->ensureLayout()->save()` — this
  backfills a `layout_onecol` layout on displays that have none. Then invalidates cache tag
  `rendered`.
- `field_layout_uninstall()`: sets every display's layout to `layout_onecol` via
  `->setLayoutId('layout_onecol')->save()` (best approximation of "no layout"), then invalidates
  `rendered`.

## Layout Builder interop (`hook_modules_installed`)

`FieldLayoutHooks::modulesInstalled()` runs only when `layout_builder` is among the newly
installed modules. For each `LayoutBuilderEntityViewDisplay`, if it carries `field_layout`
third-party settings with an `id`, it:

1. `enableLayoutBuilder()`,
2. `appendSection(new Section($field_layout['id'], $field_layout['settings']))`,
3. `save()`, and invalidates the `rendered` cache.

This migrates existing Field Layout displays into Layout Builder's first section. Because most of
Field Layout's capability now lives in core Layout Builder, this is the intended forward path;
the project itself is minimally maintained.

## Operating notes

- No admin settings page and no permission are added — layout selection happens on the existing
  Field UI **Manage display** / **Manage form display** screens (requires Field UI and the usual
  `administer <entity> display` permissions from core/Field UI).
- Depends on `layout_discovery`; the available layout options are exactly the discovered layout
  plugins (`plugin.manager.core.layout`).
