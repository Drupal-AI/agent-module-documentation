<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure: notfound.org key & language fallback

Settings form `Drupal\childfocus_notfound\Form\ChildfocusNotfoundForm` (a `ConfigFormBase`,
form id `childfocus_notfound_settings_form`).

- Route: `childfocus_notfound.admin_settings` → `/admin/config/childfocus_notfound`
- Permission: `administer site configuration` (core; no module-defined permission)
- Menu link: `childfocus_notfound.admin_settings`, parent `system.admin_config_system`
- Config object edited: `childfocus_notfound.settings`

## Config keys

| Key | Type | Form element | Default | Meaning |
|-----|------|--------------|---------|---------|
| `key` | string | textfield | `''` | Your notfound.org embed key. Get it from notfound.org (copied out of the embed code). Passed as `?key=` on the iframe URL. |
| `fallback_langcode` | string | radios (`en`/`nl`/`fr`) | `en` | Language used when the site's current UI language is not one notfound.org supports (it serves only Dutch, French, English). |
| `langcode` | string | — (not on the form) | `en` | Present in `config/install/childfocus_notfound.settings.yml`; shipped default config value, not exposed by the form. |

Config schema `childfocus_notfound.settings` (type `config_object`) declares `key` and
`fallback_langcode` as strings. The install default config also ships `langcode: en` and
`fallback_langcode: en` with an empty `key`.

## Set via drush / PHP

```bash
drush config:set childfocus_notfound.settings key 'YOUR_NOTFOUND_KEY' -y
drush config:set childfocus_notfound.settings fallback_langcode nl -y
```

```php
\Drupal::configFactory()
  ->getEditable('childfocus_notfound.settings')
  ->set('key', 'YOUR_NOTFOUND_KEY')
  ->set('fallback_langcode', 'nl')
  ->save();
```

The block reads these via `\Drupal::config('childfocus_notfound.settings')` at render time; no
cache clear is normally needed for a config change, but the block output is cached per interface
language (context `languages:language_interface`).
