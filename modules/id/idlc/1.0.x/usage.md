<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
IDLC ("Config Filter - Ignore Disabled Languages") is a single `config_filter` plugin that stops Drupal's config export/import (`drush cex`/`cim`) from touching the `language.<langcode>` config collections of languages that are not installed on the current site.

---

The module registers one ConfigFilter plugin, `disabled_languages_config_ignore` (weight `101`), and has no settings, permissions, routes or Drush commands of its own — enabling it (and its dependency `config_filter`) is the entire setup. Drupal stores language-specific config overrides in *config collections* named `language.<langcode>` (e.g. `language.de`, `language.fr`). The filter inspects the source storage's collection name on every `filterListAll`, `filterDelete` and `filterDeleteAll` call: if the collection is empty (the default collection) **or** matches a currently installed language (`language.<installed_langcode>`), it passes data through unchanged; otherwise it returns empty/false so config for that uninstalled language is neither listed for import, exported, nor deleted. The main use case is a shared codebase / multisite where all sites share one config sync directory but each site enables a different set of languages: without the filter, `drush cim` on a site that lacks German would try to delete `language.de.*` config, and `drush cex` would drop languages other sites depend on. It relies entirely on `config_filter` (a required dependency) to hook into the config transformation pipeline, so no config is changed at runtime — only what crosses the sync boundary is affected.

---

- Keep a single shared config sync directory across a multisite where each site enables a different set of languages.
- Prevent `drush cim` from deleting `language.de.*` config on a site that has not installed German.
- Prevent `drush cex` from dropping language config that other sites in the codebase still need.
- Stop uninstalled-language config from appearing in `drush config:status` as pending deletions.
- Run `drush cim` cleanly on a staging site that has fewer languages than production.
- Share one `config/sync` folder between an English-only site and a multilingual site without conflicts.
- Avoid accidental removal of translation overrides when importing config on a partially-translated environment.
- Let each site in an affiliate/multisite network manage its own language set while sharing base config.
- Prevent config drift warnings caused purely by language collections that differ per site.
- Keep CI/CD config-import steps green on environments that install only a subset of the project's languages.
- Ship a codebase to a client where they can enable/disable languages without breaking config sync.
- Exclude `language.*` collections for disabled languages from a config export snapshot.
- Preserve French config in the sync directory while deploying to a site that only runs English.
- Combine with other `config_filter` plugins (e.g. config_ignore, config_split) in one pipeline.
- Reduce noise in config diffs by ignoring languages irrelevant to the current site.
- Protect per-language interface settings during blue/green deployments with differing language sets.
- Allow a subsite to be spun up with a single language against a multilingual shared config repo.
- Avoid manual `--partial` juggling on `drush cim` just to sidestep uninstalled-language deletions.
- Guarantee that enabling a new language later re-includes its config on the next export.
- Standardise language-aware config workflows across a large multisite farm.
