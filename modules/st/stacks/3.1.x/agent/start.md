<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Stacks — agent index

Component/page-building system. Editors build reusable field-based **widgets** and place
them, ordered, on an entity through the **`stacks_type`** field ("Stacks"). Each widget's
HTML is a Twig **template variation** authored in the active theme. Admin hub / configure
route: `stacks.admin` → `/admin/structure/stacks`.

- **Entity model, the `stacks_type` field + widget/formatter, services, Twig
  functions/filters, alter hooks** → [api/entities-and-field.md](api/entities-and-field.md)
- **Setup: add the field, form-display widget settings (enabled/required bundles), widget
  & extend bundles, theme templates, `stacks.settings.yml`, admin routes** →
  [configure/stack-types.md](configure/stack-types.md)
- **The `stacks_widget_type` (`@WidgetType`) plugin type** →
  [plugins/widget-type.md](plugins/widget-type.md)
- **Permissions** → [permissions/permissions.md](permissions/permissions.md)

Submodules (own doc trees):
- **stacks_content_feed** — Views-like dynamic node listing widget (`content_feed` WidgetType
  plugin) → `../../modules/stacks_content_feed/3.1.x/agent/start.md`
- **stacks_content_list** — manual list widget using `widget_extend` rows →
  `../../modules/stacks_content_list/3.1.x/agent/start.md`

Key facts:
- **5 entity types**: `widget_entity` (content; saved widget/field values; bundle key
  `type`), `widget_entity_type` (config bundle; extra key `plugin` = a `stacks_widget_type`
  plugin id, default `default_widget`), `widget_instance_entity` (content; per-placement
  wrapper: title, `enable_sharing`, required, status; no bundles), `widget_extend`
  (content; repeatable sub-items; bundle key from `widget_extend_type`), `widget_extend_type`
  (config bundle).
- **Field**: `stacks_type` (label "Stacks"), single column `widget_instance_id` →
  widget `form_widget_type`, formatter `widget_formatter_type`. Add it multi-value to a
  content type; pick offered/required bundles in Manage form display.
- **Plugin type**: `stacks_widget_type` — namespace `Plugin/WidgetType`, annotation
  `@WidgetType`, manager `plugin.manager.stacks_widget_type`, alter `stacks_widget_type`.
  Core ships `default_widget` only; `content_feed` comes from the submodule.
- **Templates live in the THEME**, not the module: `stacks/<bundle-dashes>/templates/<bundle>--<variation>.html.twig`; a `default` variation is required.
- Config schema: yes. Permissions: yes (~19). Drush commands: none.
- Config object `stacks.settings` keys: `widget_type_groups`, `template_themes_config`,
  `content_feed_search_api_index`, `content_feed_search_api_fulltext_field`.
