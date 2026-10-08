Configuration Rewrite lets one module change configuration that another extension already owns — deep-merging or replacing values — by shipping YAML files in its own `config/rewrite/` directory, which are applied automatically when the module is installed. It saves you from writing custom `hook_install()` / `hook_update_N()` code just to tweak someone else's default config.

---

Drupal core's `config/install/` mechanism can only *create* configuration that does not yet exist; it cannot touch config another module already installed. Configuration Rewrite fills that gap. On `hook_module_preinstall`, its `config.rewriter` service (`config_rewrite.config_rewriter`) scans the installing module's `config/rewrite/` folder, and for every `some.config.name.yml` it finds it loads the *active* config of that name, deep-merges the YAML on top of it (via `NestedArray::mergeDeep`), and saves the result. So a module can, at install time, flip `system.site` values, add a permission to an existing role, tweak a View, or adjust `user.settings` without an install/update hook. The optional `config_rewrite:` control key changes the merge strategy: `config_rewrite: replace` swaps the whole object, while `config_rewrite: { replace: [key.path, …] }` replaces only the listed keys (deleting a listed key that is absent from the rewrite). By default the original `uuid` and `_core` keys are preserved so the rewrite does not orphan the entity; `config_rewrite_uuids` opts out of that. It throws `NonexistentInitialConfigException` if you try to rewrite config that was never installed — you can only rewrite what already exists. Multilingual overrides are supported via `config/rewrite/language/<langcode>/`. The service is also callable directly in code (`rewriteConfig()` returns the merged array; `rewriteModuleConfig($module)` applies a whole module's rewrite folder), which is how deployment/recipe tooling reuses it. It is a small, dependency-free building block used mostly inside install profiles, distributions, and "glue" modules that must adjust third-party defaults.

---

- Add a permission to an existing role (e.g. core `authenticated`) at install without an install hook.
- Set `system.site` values (name, slogan, mail) from a distribution's config module.
- Rewrite `user.settings` (e.g. registration mode, `anonymous` name) on install.
- Tweak a View another module shipped — add a filter or change a title — via `views.view.*` rewrite.
- Enable a field or widget setting on a content type installed by another module.
- Adjust a core or contrib module's `*.settings` object without touching its code.
- Replace an entire config object wholesale with `config_rewrite: replace`.
- Replace only selected keys of a config object with `config_rewrite: { replace: [...] }`.
- Delete a specific key from existing config by listing it under `replace` but omitting its value.
- Change an image style's effects by rewriting `image.style.*`.
- Set a default theme setting or block placement provided by another extension.
- Preserve an entity's original `uuid`/`_core` while changing its data (the default behavior).
- Force new UUIDs on a rewritten entity with the `config_rewrite_uuids` key.
- Apply language-specific overrides via `config/rewrite/language/<langcode>/name.yml`.
- Package opinionated defaults in an install profile that adjust core config on install.
- Bundle "site tweaks" as a single install-once module instead of scattered update hooks.
- Programmatically merge a rewrite array onto live config via `rewriteConfig()` in custom code.
- Re-apply a module's whole rewrite folder on demand with `rewriteModuleConfig('mymodule')`.
- Guard against rewriting missing config — the service errors instead of creating a broken object.
- Keep environment tweaks in exportable YAML instead of imperative PHP.
- Adjust `node.settings`, `filter.format.*`, or other core defaults from a glue module.
- Let a distribution override a contrib module's default config while staying update-safe.
- Change a menu, contact form, or date format installed by another module.
- Standardize config edits across many sites by shipping the same rewrite module everywhere.
