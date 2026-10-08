UI Patterns Settings makes UI Patterns components (patterns) configurable through typed **settings** — textfields, selects, booleans, tokens, attributes, colors, links and more — that a site builder fills in when placing a pattern, without writing preprocess code.

---

The module extends `ui_patterns` by adding a **setting** concept to a pattern's YAML definition: alongside `fields`, a pattern declares `settings`, each with a `type` and options. Each setting type is a plugin (`UiPatternsSettingType`, in `Plugin/UiPatterns/SettingType/`) that renders the appropriate form element and normalizes the submitted value before it reaches the Twig template — so `hook_preprocess` is no longer needed to pass configuration into a component. Many types ship: `textfield`, `select`, `radios`, `checkboxes`, `boolean`, `number`, `token`, `url`, `links`, `attributes`, `machine_name`, `media_library`, `colorwidget`/`coloriswidget`, `enumeration`, `value`, `group`, `publish`, and role/language access variants. A second plugin type, `UiPatternsSettingDataProvider` (`Plugin/UiPatterns/SettingDataProvider/`), supplies dynamic option lists — the built-ins are `menu` and `breadcrumb`. Settings appear wherever the pattern is placed: the pattern layout (Layout Builder / Display Suite), the field formatter, or the block. A `SettingFieldSource` source plugin can pull a setting's value from an entity field; those field-to-setting bindings are stored in the module's own `ui_patterns_settings.settings` config object under a `mapping` key (`{entity--field: "pattern_id::setting_id"}`), managed by `ConfigManager::addMapping()`. Two alter hooks (`hook_ui_pattern_settings_settings_alter`, `hook_ui_pattern_settings_variant_alter`) let code override resolved settings/variant per pattern, and a Twig extension exposes helpers. It requires the `ui_patterns` and `token` modules.

---

- Add a configurable "modifier" CSS-class textfield to a card component.
- Give a component a select list of style variants a site builder can choose.
- Add a boolean toggle (e.g. "show border") to a pattern without preprocess code.
- Let editors enter a token-based URL (e.g. `[node:url]`) as a pattern setting.
- Add an `attributes` setting so extra HTML attributes/classes can be passed to a pattern.
- Provide a color-picker setting for a component's accent color.
- Offer a multi-value checkboxes setting for feature flags on a pattern.
- Populate a setting's options dynamically from a menu via the `menu` data provider.
- Populate options from the breadcrumb via the `breadcrumb` data provider.
- Configure pattern settings when placing a pattern as a Layout Builder section.
- Configure pattern settings on a field formatter that renders a pattern.
- Configure pattern settings on a UI Patterns block.
- Bind an entity field's value to a pattern setting via the field source + `ui_patterns_settings.settings` mapping.
- Drive a component's variant from an entity field value.
- Add a numeric setting (e.g. columns count) to a grid pattern.
- Add a links setting to build a list of CTAs in a component.
- Add a machine-name setting used as an id/anchor in the template.
- Implement a custom setting type plugin for a bespoke widget.
- Implement a custom data provider to feed setting options from your own source.
- Override a pattern's resolved settings in code with `hook_ui_pattern_settings_settings_alter`.
- Force a specific variant for a pattern with `hook_ui_pattern_settings_variant_alter`.
- Use the module's Twig extension helpers to consume settings in templates.
- Standardize configurable design tokens across a component library.
- Migrate away from per-component preprocess functions to declarative YAML settings.
- Expose role- or language-based access options as pattern settings.
