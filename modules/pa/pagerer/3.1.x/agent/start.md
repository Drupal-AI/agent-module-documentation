<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Pagerer — agent index

Configurable pager styles. Define **preset** pagers (`pagerer_preset` config entities), each a
three-pane (left/center/right) pager built from **style plugins**, then use a preset to override
the core pager site-wide or as a Views pager. Admin UI:
`/admin/config/user-interface/pagerer` (route `entity.pagerer_preset.collection`).

- **Presets, site-wide override, URL querystring settings, config entities, Views pager** →
  [configure/presets.md](configure/presets.md)
- **The `@PagererStyle` plugin type and how to add a custom style** →
  [plugins/style.md](plugins/style.md)

Key facts:
- Built-in styles (ids): `standard`, `basic`, `progressive`, `adaptive` (`style_type: base`) and
  `multipane` (`style_type: composite`). Each has defaults in a `pagerer.style.<id>` config object.
- Preset = `pagerer.preset.<id>` config, key `panes` = `{left,center,right}`, each
  `{style: <id|none>, config: {...}}`. A fresh preset defaults to center=`standard`, left/right=`none`.
- `pagerer.settings`: `core_override_preset` (default `core` = no override; set to a preset id to
  replace the core pager), and `url_querystring` (`core_override`, `querystring_key` default `pg`,
  `index_base` 0/1, `encode_method`).
- Views pager plugin id `pagerer` ("Paged output, Pagerer"). Plugin manager service
  `pagerer.style.manager`. Uses `pagerer`/`pagerer_base` theme hooks. Permission:
  `administer site configuration` (no custom permission).
- Submodule `pagerer_example` adds a demo page at `/pagerer/example`.
