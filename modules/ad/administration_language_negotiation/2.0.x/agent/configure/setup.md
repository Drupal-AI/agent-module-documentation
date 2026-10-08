<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enable and configure admin-language negotiation

## 1. Enable & order the negotiation method

The method must be turned on for the **interface** language type and placed **before** other
methods (URL, browser, …) so it wins on admin pages.

- UI: *Configuration → Regional and language → Languages → Detection and selection*
  (`/admin/config/regional/language/detection`) → enable **"Administration language"** for
  *Interface text language detection*, then drag it to the top and Save.
- Config: the enabled methods live in `language.types` at
  `negotiation.language_interface.enabled.<method-id>: <weight>`. Enable via:

```php
$c = \Drupal::configFactory()->getEditable('language.types');
$enabled = $c->get('negotiation.language_interface.enabled');
$enabled['administration-language-negotiation'] = -10; // low weight = runs first
$c->set('negotiation.language_interface.enabled', $enabled)->save();
```

Read back: `drush cget language.types negotiation.language_interface.enabled` — look for the
`administration-language-negotiation` key.

## 2. Settings form

Route `administration_language_negotiation.negotiation_administration_language`
(`/admin/config/regional/language/detection/administration_language`, permission `administer
languages`). It writes the config object `administration_language_negotiation.negotiation`:

| Key | Type | Default | Meaning |
|---|---|---|---|
| `paths` | sequence of strings (glob) | `/admin`, `/admin/*`, `/admin*`, `/node/add/*`, `/node/*/edit`, `/node/*/translations`, `/node` | Locations where the admin language is applied. `*` is a wildcard; `<front>` = front page; language URL prefixes are matched too. |
| `admin_routes` | boolean | `false` | If true, apply on **every admin route** (via `router.admin_context`), in addition to `paths`. |
| `use_default_lang` | boolean | `false` | If true, fall back to the site default language when the user has no `preferred_admin_langcode`. |

Set via config:

```bash
drush cset administration_language_negotiation.negotiation admin_routes true -y
```

Or in PHP set the whole `paths` sequence:

```php
\Drupal::configFactory()->getEditable('administration_language_negotiation.negotiation')
  ->set('paths', ['/admin', '/admin/*', '/dashboard/*'])
  ->save();
```

## 3. Per-user preferred admin language

For users with the `use administration language negotiation` permission the module unhides
the core **"Administration pages language"** field (`preferred_admin_langcode`) on the user
edit form (`hook_form_user_form_alter`). That value is what the method returns on matching
admin locations. Administrators can also set it via `drush user:information` / the user API.

## How it decides

For a permitted user, the method runs each condition plugin; if **any** condition "blocks"
(matches an admin location) it returns the user's `preferred_admin_langcode` (with the
`use_default_lang` fallback). Otherwise it returns FALSE and the next negotiation method
runs. See plugins/conditions.md.
