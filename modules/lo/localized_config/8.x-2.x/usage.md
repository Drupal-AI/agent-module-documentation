<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Localized Configuration is a developer-oriented layer over Drupal's configuration system that lets modules define configuration plugins whose values can be set globally or per language/locale.

---

Each plugin (annotated, discovered by `LocalizedConfigPluginManager`) implements `add`/`validate`/`submit` to build its own settings form; the module handles storing the values in `localized_config.PLUGINNAME.yml` (global) and `languages/LANGCODE/localized_config.PLUGINNAME.yml` (per language). Values are read back through the `localized_config.helper` service (`getVariable()`, `getGlobalVariable()`, `addConfigCache()`), which resolves a per-context priority (current language → global) and can attach cache tags so cached output invalidates when config changes. A decorator on `language.config_factory_override` integrates the localized values into config overrides, and a Twig extension exposes helper functions to templates. It is meant as a library — the bundled `localized_config_example` submodule shows a working plugin.

Access is handled by a real custom access checker: the localized editing route uses `_localized_config_access: 'TRUE'`, which is backed by the `LocalizedConfigAccess` service (tagged `access_check`, `applies_to: _localized_config_access`) that requires the `access localized config` permission and, for language tabs, that the language is in the user's allowed set and not blacklisted. The settings route requires `access localized config settings`, and each enabled plugin gets its own generated permission. The `'TRUE'` string here is the access-check marker, not an open route.
---
- Define a configuration plugin whose values differ per language.
- Store some settings globally and others per locale from one interface.
- Read a localized value with `getVariable($plugin, $var, $langcode)`.
- Force-read the global value with `getGlobalVariable($plugin, $var)`.
- Attach config-specific cache tags to a render array via `addConfigCache()`.
- Build a centralized site configuration UI backed by plugins.
- Use language codes in `language-sitename` format for multisite separation.
- Filter the interface to only site-coded languages via settings.
- Toggle language support off to expose only global configuration.
- Grant per-plugin edit permissions to specific roles.
- Enable/disable individual localized config plugins.
- Expose localized config values to Twig templates via the Twig extension.
- Override Drupal config per language through the factory-override decorator.
- Scaffold a new plugin with the DrupalConsole generator.
- Ship default configuration as `localized_config.PLUGINNAME.yml` files.
- Provide per-language marketing/legal strings without full string translation.
- Restrict which languages a user may edit via `getLanguagesOfUser()`.
- Blacklist languages from the localized config interface.
- Use the example submodule as a reference implementation.
- Centralize customer/site settings even without using the locale aspect (global_only plugins).
