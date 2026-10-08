# Configure EU Cookie Compliance Matomo

Config object **`eu_cookie_compliance_matomo.settings`** with a single key. Form
`EuCookieComplianceMatomoForm` at `/admin/config/system/eu-cookie-compliance/matomo` (route
`eu_cookie_compliance_matomo.settings`, permission `administer eu cookie compliance popup` — provided
by EU Cookie Compliance, not this module).

## The one setting

| Key | Type | Default | Effect |
|---|---|---|---|
| `categories` | array of strings | `[]` | Cookie-category machine names that must be agreed before Matomo gets consent. Only used when EU Cookie Compliance runs in **"opt-in with categories"** mode. |

The form renders `categories` as a checkboxes element whose options come from EU Cookie
Compliance's cookie categories (`CategoryStorageManager::getCookieCategories()`). If no cookie
categories are defined, the form has no options and this setting stays empty.

## Read / write

```bash
drush cget eu_cookie_compliance_matomo.settings           # show categories
```

`categories` is an array — set it with `php:eval`:
```php
\Drupal::configFactory()->getEditable('eu_cookie_compliance_matomo.settings')
  ->set('categories', ['analytics', 'marketing'])   // cookie category machine names
  ->save();
```

The module's `hook_page_attachments_alter()` reads these back and filters out empties
(`if ($category)`), so both a plain indexed array (`['analytics']`) and the raw checkboxes array
(`['analytics' => 'analytics', 'other' => 0]`) work.

## Related config it reads (not owned here)

- `eu_cookie_compliance.settings`: `method` (`opt_in` vs categories), `cookie_name` (default
  `cookie-agreed`), `popup_delay`.
- `matomo.settings`: `privacy.disablecookies` (if already true, the module does **not** add a second
  `disableCookies`).

Do not edit those two config objects to configure this module — they belong to the other modules.
