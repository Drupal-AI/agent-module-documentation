<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Edit + (edit_plus) — agent index

Front-end **inline (in-place) editing** for the Navigation+ / +Suite page builder. Adds a
Navigation+ **tool plugin** id `edit_plus`, label *"Change"*, hotkey `c` (`src/Plugin/Tool/EditPlus.php`).
In Edit Mode, rendered fields become clickable; clicking one opens that entity's **normal `default`
entity form** in the Navigation+ right sidebar. Edits are buffered per user in a `tempstore_plus`
entity tempstore and rendered back live via AJAX; the user saves (one revision) or discards.

- Package `Page Building`. Core `^11`. License GPL-2.0-or-later. Version 2.3.4 (version-dir 2.3.x).
- **Deprecated** on drupal.org — superseded by `drupal/daedalus` (`info.yml` `lifecycle: deprecated`;
  composer `abandoned: drupal/daedalus`).
- Dependencies (all required, `edit_plus.info.yml`): `navigation_plus`, `tempstore_plus`,
  `field_sample_value`, `twig_events`.
- One permission: **`access inline editing`** (`edit_plus.permissions.yml`) — gates every route.
- No settings form / no `configure` route. Config schema is third-party field settings only.
- 8 optional submodules (block types, landing page, LB/non-LB node) — see `modules/*` in source.

## Solution docs

- **Architecture: tool, routes, controllers, tempstore save/discard flow, hooks, libraries** →
  [architecture.md](architecture.md)
- **Per-field config (Edit+ third-party settings, `field_config_edit` alter, schema) + Drush** →
  [config/fields.md](config/fields.md)
- **Extending: events, event subscribers, `inline_textarea` element, JS field-plugin system** →
  [api/extending.md](api/extending.md)

## Key source map

- Tool plugin: `src/Plugin/Tool/EditPlus.php` (attaches `edit_plus/library` + editor libs).
- Routes: `edit_plus.routing.yml` — 4 routes, all `_permission: 'access inline editing'`.
- Controllers: `src/Controller/MultipleEntityFormController.php` (builds the form),
  `src/Controller/Tempstore.php` (save / delete tempstore entities).
- Form alters: `src/Form/InlineEntityFormAlter.php` (submit → tempstore instead of save),
  `EntityEditFormAlter.php`, `FieldConfigFormAlter.php`, `LayoutBuilderBlockFormAlter.php` (lb_plus),
  `ViewsFormMediaLibraryWidgetAlter.php`; shared `src/EditPlusFormTrait.php`.
- Tempstore swap gate: `src/ParamConverter/EditPlusTempstoreActivationChecker.php` (decorates
  `tempstore_plus.activation_checker`).
- Hooks: `edit_plus.module` (`preprocess_block`, `form_alter`, `theme`, `element_info_alter`).
- Drush: `src/Drush/Commands/UpdateInlineEditor.php`.
