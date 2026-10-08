Deconfig exempts selected configuration keys or whole config objects from Drupal's config import/export so administrators can change them without the config-management system overwriting them on the next sync.

---

Drupal's configuration management enforces site config from the sync directory, but developers sometimes need to hand certain settings (site email, front page, an API endpoint that differs per environment) to the site administrator without those values being reverted by `drush cim`. Deconfig solves this by decorating the `config.storage.sync` service with `Drupal\deconfig\DeconfigStorage`, which reads exempted items from active storage instead of the sync files, so they always look up to date and are never rewritten on export. You declare exemptions inline in the sync YAML with a `_deconfig` entry that mirrors the config hierarchy, keeping the exclusion documented right next to the affected setting and visible in code review. As a safety measure the hidden item must be absent from the sync file; if it is present, import/export throws `FoundHiddenConfigurationError` so the drift is obvious. A "soft" mode (prefix the key with `@`) keeps a default value in sync but uses it only when active storage has no value, for settings that must have a value present (for example `system.site` name is required to install from config). The `deconfig-remove-hidden` Drush command (alias `drh`) cleans any stray hidden config out of sync storage. The module has no UI, routes, permissions, or config schema of its own — it is pure config-sync plumbing.

---

- Let a site administrator change site email (`system.site` `mail`) without it reverting on config import.
- Let editors set the front page (`system.site` `page.front`) per environment while keeping the rest of `system.site` enforced.
- Exempt a whole config object from import/export by adding a top-level `_deconfig: 'reason'` and removing the values from sync.
- Deconfig individual nested keys by mirroring the config hierarchy under `_deconfig`.
- Document *why* a setting is excluded — the `_deconfig` values are free-text reason strings surfaced in code review.
- Keep environment-specific endpoints or IDs administrator-editable across dev/stage/prod without per-environment config overrides.
- Use "soft" deconfig (`'@name': 'reason'`) to keep a required default in sync but let the active value win when set.
- Preserve a default value that must exist for a module to function, while still not overwriting an administrator's change.
- Make a config exemption obvious in pull requests by declaring it in the YAML rather than in a settings.php override.
- Fail `drush cex`/`drush cim` loudly (via `FoundHiddenConfigurationError`) when a hidden item accidentally lands back in sync, catching drift early.
- Recover from that error state by running `drush deconfig-remove-hidden` to strip hidden config from sync storage.
- Alias `drh` for `deconfig-remove-hidden` in scripted deploy pipelines that need to normalize sync storage.
- Avoid `config_ignore`-style separate exclusion lists by co-locating the exemption with the config it governs.
- Let a multisite or client-editable install expose a curated set of settings for editing while enforcing everything else.
- Allow admin-editable theme or contact settings that should not be clobbered on deployment.
- Keep a per-site API key placeholder as a soft-deconfig default so the site installs, then let the administrator supply the real value in active config.
- Support recursive exemptions so only a leaf key deep inside a large config object is freed, leaving siblings enforced.
- Work across config collections (language overrides, etc.), since the storage wrapper recreates itself per collection.
- Integrate transparently with the existing `drush cim`/`drush cex` workflow — no separate export step for exempted items.
- Serve as a developer-only tool: enable it in code, declare exemptions in YAML, and leave no admin UI surface for editors to misconfigure.
