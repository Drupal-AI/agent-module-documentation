<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config Filter - Ignore Disabled Languages (idlc) — agent index

One `config_filter` plugin that keeps `drush cex`/`cim` from exporting, importing or
deleting the `language.<langcode>` config **collections** of languages that are not
installed on the current site. Built for shared-codebase / multisite setups with one
config sync directory but different enabled languages per site (project short-name IDLC =
"Ignore Disabled Languages Config"). It plugs into `config_filter`'s config transformation
pipeline; it never touches active runtime config, only what crosses the sync boundary.

Setup is just enabling the module (pulls in `config_filter`). No config UI, no PHP-version
constraint, and nothing else to wire up.

- Depends on: `config_filter` (info.yml `config_filter:config_filter`; composer `drupal/config_filter:^2.0`). Behaviour is undefined without it enabled.
- Core: `^8 || ^9 || ^10 || ^11`. Package: `Config`.
- Settings page / configure route: none (`configure` null). Permissions: none. Drush commands: none. Config schema: none. Plugin types defined: none (it *implements* a plugin type from `config_filter`).
- No solution sub-docs: the module is one plugin with no API surface to call. No security surface.

## Key facts (real machine names)
- Plugin: `Drupal\idlc\Plugin\ConfigFilter\DisabledLanguagesConfigIgnore`
  (`@ConfigFilter` `id = "disabled_languages_config_ignore"`, `label = "disabled languages config ignore"`, `weight = 101`).
- Extends `config_filter`'s `ConfigFilterBase`; implements `ContainerFactoryPluginInterface`.
  Injects the core `language_manager` service.
- Overrides three filter methods — `filterListAll($prefix, array $data)`,
  `filterDelete($name, $delete)`, `filterDeleteAll($prefix, $delete)`
  (`src/Plugin/ConfigFilter/DisabledLanguagesConfigIgnore.php`). Each builds the list of
  installed-language collection names (`language.<langcode>` from
  `$languageManager->getLanguages()`) and inspects `getSourceStorage()->getCollectionName()`:
  - empty collection name (the default collection) → pass through unchanged.
  - name equals `language.<langcode>` for a **currently installed** language → pass through.
  - any other `language.<langcode>` (an uninstalled language) → return `[]` / `FALSE`,
    hiding that collection from list/export and blocking its deletion on import.
  (`filterDelete` also short-circuits to `FALSE` when `$delete` is already `FALSE`.)
