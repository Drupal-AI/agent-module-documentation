<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure allowed hosts

The module's only configuration is the **allowed hosts** list — the Data & Insights origins that
embeds may come from. It gates both validation (rejecting embeds from other hosts) and, optionally,
the CSP `frame-src` directive.

## Config object

`media_tyler_data_insights.settings`:

```yaml
allowed_hosts:
  - 'https://data.example.gov'
  - 'https://insights.example.com'
```

Each entry must be an **`https://` origin with no path** (validated by the settings form:
must start with `https://`, host only). Schema type is a sequence of `uri`.

## Settings form

Route `media_tyler_data_insights.allowed_hosts_settings` → `/admin/config/media/tyler-data-insights`
(permission `administer media_tyler_data_insights hosts`). It is a textarea, one host per line;
submit stores the trimmed, non-empty lines as the `allowed_hosts` sequence.

## Drush / scripting

```bash
drush cget media_tyler_data_insights.settings
```

```php
\Drupal::configFactory()->getEditable('media_tyler_data_insights.settings')
  ->set('allowed_hosts', ['https://data.example.gov'])
  ->save();
```

## How the list is used

- **Validation** (constraint `media_tyler_data_insights`): the pasted embed must contain exactly one
  iframe, its path must match `/w/…` or `/stories/…`, and its host (compared after stripping the
  `https://` scheme) must be in `allowed_hosts`; otherwise the media fails to save with the
  constraint's invalid-embed or invalid-host message.
- **CSP** (only when `drupal/csp` is enabled): `AllowedHostsCspEventSubscriber` listens to
  `csp.policy_alter` and, on non-admin routes, appends every allowed host to the `frame-src`
  directive (creating the directive if absent), so the iframes are permitted to load.

## Permission

- `administer media_tyler_data_insights hosts` — reach the settings form and edit the allowed hosts.
  (Creating media of the Tyler type is governed by normal core Media permissions on the media type.)
