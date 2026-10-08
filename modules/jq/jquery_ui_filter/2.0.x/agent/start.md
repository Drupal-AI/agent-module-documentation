<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# jQuery UI Filter (jquery_ui_filter) — agent index

Text-format filter that converts `[accordion]…[/accordion]` and `[tabs]…[/tabs]` token markup in
body HTML into jQuery UI accordion and tabs widgets. The PHP filter rewrites the tokens into
`<div data-ui-*>` wrappers; the bundled JavaScript (`js/jquery_ui_filter.js`) builds the actual
widget from the heading structure at render time. Content stays plain HTML, so the widgets degrade
gracefully when JS is off or the page is printed.

Dependencies (all required to enable): core `filter`, plus contrib `jquery_ui (>=8.x-1.7)`,
`jquery_ui_accordion (>=2.1)`, `jquery_ui_tabs (>=2.1)` — jQuery UI is no longer in Drupal core.
Configure route: `jquery_ui_filter.settings` → `/admin/config/content/formats/jquery_ui_filter`
(permission `administer filters`). No permissions of its own, no Drush; ships one Filter plugin and
config schema.

- **Enable the filter on a text format + the `[accordion]`/`[tabs]` authoring syntax and options** →
  [configure/filter.md](configure/filter.md)
- **Global accordion/tabs default options (the settings form + `jquery_ui_filter.settings` config)** →
  [configure/settings.md](configure/settings.md)

Key facts:
- Filter plugin `@Filter(id = "jquery_ui_filter", title = "jQuery UI accordion and tabs widgets",
  type = TYPE_TRANSFORM_IRREVERSIBLE)` → `Drupal\jquery_ui_filter\Plugin\Filter\jQueryUiFilter`.
- Config object `jquery_ui_filter.settings` with `accordion.options` and `tabs.options` maps
  (schema `type: ignore`). Settings form `jQueryUiFilterSettingsForm` (id `jquery_ui_filter_settings_form`).
- Attached asset library `jquery_ui_filter/jquery_ui_filter` (deps: `core/jquery`, `core/drupal`,
  `core/drupalSettings`, `core/once`, `jquery_ui_accordion/accordion`, `jquery_ui_tabs/tabs`).
- Widget options: `headerTag` (default `h3`), `mediaType` (`screen`/`all`/`print`), `scrollTo`,
  `scrollToDuration` (500), `scrollToOffset` (`auto`), `collapsed`, plus any jQuery UI option
  (JSON-valued options supported). Global defaults live in config; per-widget tokens override them.
- Menu link `jquery_ui_filter.settings` under `system.admin_config_content`.
