<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure GA4 tracking

Settings form: `ga4_google_analytics.configure` → `/admin/config/services/ga4-google-analytics`
(menu: Configuration » Web services » GA4 Google Analytics). Gated by permission `ga4 configre`.

All values are stored in the simple config object **`ga4_google_analytics.config`**. There is
**no `config/install` default**, so the object does not exist until the form is saved once (or
you write it yourself). Schema: `config/schema/ga4_google_analytics.schema.yml`.

## Config keys

```yaml
# ga4_google_analytics.config
measurement_id: 'G-XXXXXXXXXX'        # required; the GA4 property Measurement ID
scripts_custom_attributes: ''         # extra attributes added to the injected <script> tags
ga4_access_roles:                     # sequence of role IDs; empty => all users tracked
  - authenticated
ga4_access_pages:                     # core request_path condition config
  id: request_path
  negate: false                       # false => track ONLY listed pages; true => track all EXCEPT
  pages: "/user/*\n/admin/*"          # one path per line; '*' wildcard; <front> for front page
```

- **`measurement_id`** — the `G-` property ID. Required on the form. Tracking is a no-op if empty.
  Output is run through `Xss::filter()`.
- **`ga4_access_roles`** — checkbox list of role IDs. A visitor is tracked when they hold at
  least one selected role. If none are selected the condition is TRUE for everyone.
- **`ga4_access_pages`** — a core `request_path` condition configuration. `negate: false` means
  "track only the listed pages"; `negate: true` means "track everywhere except the listed pages".
- **`scripts_custom_attributes`** — a strict allow-list string. Only `async`, `type="…"`,
  `data-*="…"`, and `crossorigin="anonymous"` pass validation (see the form's `validateForm`);
  `javascript:` / `data:text/html` values are rejected. Used mainly for cookie-consent tools.

## Klaro / cookie-consent integration

To let Klaro block GA until consent, set:

```
scripts_custom_attributes: 'type="text/plain" data-type="application/javascript" data-name="ga"'
```

where `data-name` matches the Klaro service machine name for Google Analytics.

## Read / write with drush

```bash
# Read current config
drush cget ga4_google_analytics.config

# Set the Measurement ID (creates the object if missing)
drush cset ga4_google_analytics.config measurement_id 'G-ABCDE12345' -y
```

Nested/sequence keys (roles, the pages mapping) are easiest to set with `drush php:eval`:

```php
$c = \Drupal::configFactory()->getEditable('ga4_google_analytics.config');
$c->set('measurement_id', 'G-ABCDE12345');
$c->set('ga4_access_roles', ['authenticated']);
$c->set('ga4_access_pages', ['id' => 'request_path', 'negate' => TRUE, 'pages' => "/admin/*"]);
$c->save();
```
