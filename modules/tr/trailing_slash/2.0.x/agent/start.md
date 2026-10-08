# Trailing Slash — agent index

Appends trailing slashes to selected outbound URLs (by path pattern and/or content-entity
bundle) for SEO/URL consistency. Works on **outbound** URL generation only — it does not add
inbound redirects. Depends on core `language`. No Drush, no plugins.

- **Settings form, config keys (`enabled`, `paths`, `enabled_entity_types`), the permission** →
  [configure/settings.md](configure/settings.md)
- **How it works internally (outbound path processor, url_generator swap, matching rules) —
  for overriding/debugging** → [extend/architecture.md](extend/architecture.md)

Key facts:
- Config `trailing_slash.settings`: `enabled` (bool), `paths` (newline string, wildcards ok),
  `enabled_entity_types` (**PHP-serialized** nested map `entity_type → bundle → bool`).
- Route `trailing_slash.admin_settings_form` → `/admin/config/trailing-slash/settings`,
  permission `administer trailing slash` (defined in `trailing_slash.permissions.yml`,
  `restrict access: TRUE`).
- Outbound path processor `TrailingSlashOutboundPathProcessor` (tag `path_processor_outbound`,
  priority **-1** = runs last). Excludes `<front>`, empty, `/admin*`, `/devel*`.
- Slash only added when the path matches a configured pattern (via `path.matcher`) OR resolves
  to an enabled entity bundle; regex skips final segments containing a `.` (file-like).
- `TrailingSlashServiceProvider` swaps `url_generator.non_bubbling` →
  `TrailingSlashUrlGenerator` to keep the multilingual `<front>` slash after language prefixing.
