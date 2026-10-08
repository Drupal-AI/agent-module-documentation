<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# securitytxt — configure

![Security.txt configuration form](../../../../../../../screenshots/securitytxt/1.6.x/settings.png)

Everything lives in the config object **`securitytxt.settings`**. Edit it via the form or
`drush config:set`. Form: **Admin → Configuration → System → Security.txt**
(route `securitytxt.configure`, path `/admin/config/system/securitytxt`, permission
`administer securitytxt`). The **Sign** subtab is route `securitytxt.sign`, path
`/admin/config/system/securitytxt/sign`.

## Config keys (`securitytxt.settings`)

| Key | Type | security.txt line it produces | Notes |
|---|---|---|---|
| `enabled` | boolean | — | Master switch. `FALSE` (default) → the `/.well-known/*` routes 404. |
| `enabled_signature` | boolean | wraps PGP block | When TRUE the file is wrapped as a PGP SIGNED MESSAGE using `signature_text`. |
| `contact_email` | email | `Contact: mailto:<email>` | |
| `contact_phone` | string | `Contact: tel:<phone>` | Full international format, e.g. `+1-201-555-0123`. |
| `contact_page_url` | string | `Contact: <url>` | Should be HTTPS (form warns if not). |
| `encryption_key_url` | string | `Encryption: <url>` | URL of your PGP public key. |
| `expiry_date` | integer (Unix timestamp) | `Expires: <ISO-8601>` | **Required in the form**; rendered via date formatter as `\DateTime::ATOM`. Not present in install defaults until first save. |
| `policy_url` | string | `Policy: <url>` | |
| `acknowledgments_url` | string | `Acknowledgments: <url>` | Note US spelling (renamed from `acknowledgement_url` in update 8001). |
| `hiring_url` | string | `Hiring: <url>` | |
| `preferred_languages` | string | `Preferred-Languages: <list>` | Comma list, e.g. `en, es, fr`. Defaults to site default language. |
| `canonical_urls` | string (textarea) | one `Canonical: <url>` per line | Only lines starting `https://` are emitted. |
| `signature_text` | string | — | The detached PGP signature; also served at `.sig`. Set on the Sign tab. |

Install defaults (`config/install/securitytxt.settings.yml`) ship `enabled`/`enabled_signature`
`FALSE` and all string keys empty. `expiry_date`, `hiring_url`, `preferred_languages` and
`canonical_urls` are defined in the schema but only get written once the form is saved (or you
set them explicitly).

## The enabled gotcha

- The file will not save as `enabled: TRUE` from the form unless at least one of
  `contact_email` / `contact_phone` / `contact_page_url` is set (form validation).
- Setting `enabled: TRUE` in code bypasses that validation, but the serializer still emits an
  empty body if no contact is set — set a contact too.
- After changing config, run `drush cr` so the served file reflects the new values.

## Drush recipe (enable with an email contact + expiry)

```bash
drush config:set securitytxt.settings contact_email security@example.com -y
drush config:set securitytxt.settings policy_url https://example.com/security-policy -y
# expiry_date is a Unix timestamp; set one a year out:
drush php:eval '\Drupal::configFactory()->getEditable("securitytxt.settings")->set("expiry_date", strtotime("+1 year"))->set("enabled", TRUE)->save();'
drush cr
curl -s https://example.com/.well-known/security.txt
```

`drush config:get securitytxt.settings` dumps the whole object;
`drush config:get securitytxt.settings contact_email` reads one key.
