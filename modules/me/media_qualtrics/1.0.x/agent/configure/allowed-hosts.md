<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure allowed Qualtrics hosts

The module's only settings form. It controls **which hosts** the `media_qualtrics` formatter
will render (and, if CSP is enabled, which hosts get added to `frame-src`).

## Config object

`media_qualtrics.settings`:

```yaml
allowed_hosts:
  - 'https://qualtrics.com'      # shipped default (config/install)
```

- Type: `config_object`; `allowed_hosts` is a sequence of strings.
- Each host must be a bare `https://` domain (scheme required, must be `https`, no path).
  The form rejects `http://…`, and rejects URLs with a path (offering the corrected domain).
- If the list is ever empty, the formatter falls back to the hardcoded
  `MediaQualtricsEmbedFormatter::DEFAULT_DOMAIN` = `https://qualtrics.com`.

## Via the UI

Route `media_qualtrics.allowed_hosts_settings` → **`/admin/config/media/qualtrics`**
(Configuration → Media → Qualtrics settings). Permission: **`administer qualtrics allowed hosts`**
(`restrict access: true`). Enter one host per line in the **Allowed Hosts** textarea, Save.
Include custom Qualtrics domains and vanity URLs.

## Via drush

```bash
# read
drush cget media_qualtrics.settings allowed_hosts

# set (replace the whole sequence)
drush cset media_qualtrics.settings allowed_hosts.0 'https://qualtrics.com' -y
drush cset media_qualtrics.settings allowed_hosts.1 'https://survey.example.com' -y
```

Or scriptably:

```php
\Drupal::configFactory()->getEditable('media_qualtrics.settings')
  ->set('allowed_hosts', ['https://qualtrics.com', 'https://survey.example.com'])
  ->save();
```

## How the list is consumed

`MediaQualtricsEmbedFormatter::getUrlRegexPattern()` turns each host into a regex
`scheme:\/\/(?:.*\.)?<domain>` (so subdomains match), joined with `|`. A field value only
renders if it matches; non-matching values are silently skipped. Changing the list changes
both what renders **and** the CSP `frame-src` hosts (see [api/mechanism.md](../api/mechanism.md)).
