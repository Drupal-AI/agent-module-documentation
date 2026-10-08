# Akamai — agent index

Integrates Drupal cache invalidation with the Akamai CDN's CCUv3 (Fast Purge) API. Config
lives in the `akamai.settings` config object, edited at `/admin/config/akamai/config`
(route `akamai.settings`). Requires the `akamai-open/edgegrid-client` library. Usually
driven through the Purge module; can also purge URLs manually.

- **Settings keys, credential storage, config UI, common config changes via drush** →
  [configure/settings.md](configure/settings.md)
- **Permissions (`administer akamai`, `purge akamai cache`)** →
  [permissions/permissions.md](permissions/permissions.md)
- **Plugin types & plugins: `akamai_client`, Purge purgers (`akamai`, `akamai_tag`), diagnostics** →
  [plugins/plugins.md](plugins/plugins.md)
- **Services, factory, Edgescape helper, Edge-Cache-Tag header, token** →
  [api/services.md](api/services.md)

Key facts: config object = `akamai.settings`; `disabled: TRUE` is a global killswitch;
`storage_method` is `file` (.edgerc) or `key` (Key module); purge network is
`domain.production` / `domain.staging`; CCUv3 action is `action_v3.delete` /
`action_v3.invalidate`. No Drush commands are provided.
