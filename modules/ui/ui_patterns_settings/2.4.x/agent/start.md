# UI Patterns Settings — agent index

Adds typed **settings** to `ui_patterns` components so site builders configure a pattern
(textfields, selects, tokens, attributes, colors…) instead of writing preprocess code.
Requires `ui_patterns` + `token`. No config UI route of its own (`configure: null`).

- **Declaring settings in a pattern's YAML, and the `ui_patterns_settings.settings` field→setting
  mapping config** → [configure/settings-config.md](configure/settings-config.md)
- **Setting type plugins (`UiPatternsSettingType`): the built-in ids and how to add one** →
  [plugins/setting-types.md](plugins/setting-types.md)
- **Data provider plugins (`UiPatternsSettingDataProvider`: `menu`, `breadcrumb`)** →
  [plugins/data-providers.md](plugins/data-providers.md)
- **Alter hooks** → [hooks/hooks.md](hooks/hooks.md)

Key facts:
- Two plugin types: `UiPatternsSettingType` (`Plugin/UiPatterns/SettingType/`, manager
  `plugin.manager.ui_patterns_settings`) and `UiPatternsSettingDataProvider`
  (`Plugin/UiPatterns/SettingDataProvider/`, manager
  `plugin.manager.ui_patterns_settings_data_provider`).
- Built-in setting types include `textfield`, `select`, `radios`, `checkboxes`, `boolean`,
  `number`, `token`, `url`, `links`, `attributes`, `machine_name`, `media_library`,
  `colorwidget`, `coloriswidget`, `enumeration`, `value`, `group`, `publish`.
- Field→setting bindings live in **`ui_patterns_settings.settings`** under `mapping`
  (`{entity--field: "pattern_id::setting_id"}`, written by `ConfigManager::addMapping()`).
- `hook_preprocess` is not needed — the setting type normalizes the value for the template.
