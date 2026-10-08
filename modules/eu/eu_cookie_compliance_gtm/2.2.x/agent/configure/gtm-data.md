<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Per-category GTM data & the dataLayer push

The module has **no settings page**. All configuration is a JSON payload per cookie category.

## Where it's set / stored

- UI: edit a cookie category at `/admin/config/system/eu-cookie-compliance/categories` — the module
  adds a **GTM data** textarea (form ids `cookie_category_add_form` / `cookie_category_edit_form`).
- Storage: a **third-party setting** `gtm_data` on the `cookie_category` config entity
  (`eu_cookie_compliance.cookie_category.<id>` → `third_party_settings.eu_cookie_compliance_gtm.gtm_data`).
- The value must be a **JSON object**; validation rejects invalid JSON or non-objects. Leaving the
  field empty **unsets** the third-party setting (entity builder).

## Tokens

Inside the JSON values you can use:

- `@status` → replaced with `1` or `0` depending on whether **this** category is accepted.
- `@<machine_name>_status` → the accepted state of **another** category (e.g. `@functional_status`).

Example on the "analytics" category:

```json
{"analytics": "@status", "functional": "@functional_status"}
```

## Read / write in code

```php
use Drupal\eu_cookie_compliance\Entity\CookieCategory;

$category = CookieCategory::load('analytics');

// read
$data = $category->getThirdPartySetting('eu_cookie_compliance_gtm', 'gtm_data'); // array|null

// write
$category->setThirdPartySetting('eu_cookie_compliance_gtm', 'gtm_data', ['analytics' => '@status']);
$category->save();

// clear
$category->unsetThirdPartySetting('eu_cookie_compliance_gtm', 'gtm_data');
$category->save();
```

Read back with drush:
`drush cget eu_cookie_compliance.cookie_category.analytics third_party_settings.eu_cookie_compliance_gtm.gtm_data`.

## How it reaches GTM

`js/eu_cookie_compliance_hooks.js` (library attached in the header on every page via
`hook_page_attachments`) subscribes to the consent events fired by the main EU Cookie Compliance
module. On a consent change it:

1. Reads each category's `gtm_data` from
   `drupalSettings.eu_cookie_compliance.cookie_categories_details` (exposed by the main module).
2. Replaces `@status` / `@<machine>_status` with the current 1/0 states.
3. Pushes the resulting object to the GTM `dataLayer`, so GTM triggers can react to consent.

No PHP API, hooks, or Drush are provided beyond the form integration above.
