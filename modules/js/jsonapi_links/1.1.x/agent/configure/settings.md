# Settings form & config (configure)

One settings page, backed by two config keys. There are no per-field, per-bundle, or per-format
settings — the behaviour is site-global.

## Route & form

- Route: `jsonapi_links.settings` → path `/admin/config/services/jsonapi/links`
  (`jsonapi_links.routing.yml`). Requirement `_permission: 'administer site configuration'`.
- Form: `Drupal\jsonapi_links\Form\SettingsForm` (extends `ConfigFormBase`, id
  `jsonapi_links_settings`, editable config `jsonapi_links.settings`). Standard config form — CSRF
  token and the core config save flow apply.
- Menu: appears as a local task **"JSON:API Links"** under the JSON:API settings tab
  (`jsonapi_links.links.task.yml`, base route `jsonapi.settings`).
- `configure:` in info.yml points here.

## Config object — `jsonapi_links.settings`

Schema `config/schema/jsonapi_links.settings.schema.yml` (`config_object`, `FullyValidatable`).
Install defaults (`config/install/jsonapi_links.settings.yml`): `remove_links: false`,
`ignore_list: ''`.

| Key | Type | Default | Form element | Meaning |
|---|---|---|---|---|
| `remove_links` | boolean | `false` | checkbox "Remove links attributes" | Master switch. While `false`, the subscriber makes no change (core JSON:API output is untouched). |
| `ignore_list` | string | `''` | textarea "Ignore list (regex to match to keep links attributes)" | Newline-separated PHP regexes (with delimiters). A dotted response path matching any regex keeps its `links` (subtree not stripped). Example lines: `/jsonapi\.foo\.bar/` or `/foo\.[0-9]+\.bar/`. |

## Set from code / config

```php
\Drupal::configFactory()->getEditable('jsonapi_links.settings')
  ->set('remove_links', TRUE)
  ->set('ignore_list', "/^data\\.[0-9]+\\.relationships\\.uid/")
  ->save();
```

```yaml
# config export: jsonapi_links.settings.yml
remove_links: true
ignore_list: "/^data\\.[0-9]+\\.relationships/"
```

Or via drush:

```bash
ddev drush config:set jsonapi_links.settings remove_links 1 -y
```

## Behaviour notes

- The `/jsonapi` root document is always preserved regardless of these settings (the subscriber
  skips the JSON:API base path), so `meta.links.me` and the root discovery links stay.
- The document-level `links` (pager `self`/`next`/`prev`) are always kept; only per-resource,
  per-`included`, per-relationship and per-resource `meta.links` are removed.
- How the keys drive the runtime walk: [../api/response-subscriber.md](../api/response-subscriber.md).
