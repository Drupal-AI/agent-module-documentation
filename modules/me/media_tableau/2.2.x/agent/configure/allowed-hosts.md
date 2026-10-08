<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Allowed hosts (host whitelist) + CSP

`media_tableau` only embeds URLs whose host is in the whitelist. The whitelist drives the
formatter's URL regex, the valid-URL examples, and (optionally) the CSP `frame-src` directive.

## Config

Config object: `media_tableau.settings`, key `allowed_hosts` — a **sequence of strings**.
Default (set at install / update 9201): `['https://public.tableau.com']`.

```bash
drush cget media_tableau.settings allowed_hosts
```

```php
// Add an internal Tableau Cloud host programmatically.
$config = \Drupal::configFactory()->getEditable('media_tableau.settings');
$hosts = $config->get('allowed_hosts') ?? [];
$hosts[] = 'https://my-org.online.tableau.com';
$config->set('allowed_hosts', array_values(array_unique($hosts)))->save();
```

## Settings form

Route `media_tableau.allowed_hosts_settings` → `/admin/config/media/tableau`
(menu: *Configuration → Media → Tableau settings*). Permission:
`administer media_tableau allowed hosts`.

- One host per line in the **Allowed Hosts** textarea.
- Validation (`AllowedHostsSettingsForm::validateDomain`) requires each host to:
  - use the `https://` scheme (http/other → error),
  - contain **only** the domain — no path (a trailing `/` is allowed; anything else is
    rejected with a "use only the domain" suggestion).
- The submit handler stores the trimmed, non-empty lines as the `allowed_hosts` sequence.

## CSP integration

If the [CSP module](https://www.drupal.org/project/csp) is installed, the
`media_tableau.host_subscriber` event subscriber listens on `csp.policy_alter` and, on
**non-admin** routes, appends every allowed host to the `frame-src` directive (creating the
directive if absent). No configuration needed — enabling CSP is enough. The settings-form
description also hints at this when CSP is loaded.
