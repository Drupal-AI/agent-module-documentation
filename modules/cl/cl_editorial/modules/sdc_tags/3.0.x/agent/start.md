<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SDC Tagging (sdc_tags) — agent index

Submodule of **cl_editorial**. Lets modules/themes declare **tags** that Single Directory
Components opt into, so other features can filter components by tag. No `configure` info.yml key
(so `configure: null`), no permissions of its own, no Drush.

- **Define tagging rules, config location, the admin UI, and `sdc_tags_get_tag_filters()`** →
  [configure/tagging.md](configure/tagging.md)
- **Define a `component_tag` plugin (the `*.component_tags.yml` file, manager, alter hook)** →
  [plugins/component-tag.md](plugins/component-tag.md)

Key facts:
- Plugin type `component_tag`: manager `plugin.manager.sdc_tags.component_tag`, YAML discovery of
  `MODULE.component_tags.yml`, default class `ComponentTagDefault`, alter hook `component_tag_info`.
- Rules stored in config `sdc_tags.settings` → `component_tags.<tag_id>` =
  `{tag_id, statuses[], allowed[], forbidden[]}`.
- Admin UI: `/admin/config/user-interface/sdc/component-tagging` (+ `/auto/{tag}`), requires
  `administer site configuration`.
- Runtime dependency on parent `cl_editorial` (uses its `NoThemeComponentManager` and
  `ComponentFiltersFormTrait`).
