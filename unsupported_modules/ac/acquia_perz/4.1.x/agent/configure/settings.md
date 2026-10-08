<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Global settings — `acquia_perz.settings`

Form: `Drupal\acquia_perz\Form\AdminSettingsForm` (route `acquia_perz.admin_settings`,
path `/admin/config/services/acquia-perz/settings`, permission `administer acquia perz`).
Editable config object: **`acquia_perz.settings`**. Credentials themselves come from
`acquia_connector` (the Acquia subscription), not from this form.

## Config keys (with shipped defaults)

```yaml
api:
  discovery_endpoint_page_size: 20
  assets_url: 'https://builder.lift.acquia.com'   # Personalization JS asset base
  site_id: ''                                     # required; migrated from acquia_lift if present
identity:
  capture_identity: false
  identity_parameter: ''
  identity_type_parameter: ''
  default_identity_type: ''        # SettingsHelper::DEFAULT_IDENTITY_TYPE_DEFAULT = 'email'
field_mappings:
  content_section: ''
  content_keywords: ''
  persona: ''
udf_person_mappings: []            # each: {id, value, type}; max 50 (SettingsHelper::getUdfLimitsForType)
udf_touch_mappings: []             # max 20
udf_event_mappings: []             # max 50
visibility:
  path_patterns: "/admin\n/admin/*\n/batch\n/node/add*\n/node/*/*\n/user/*\n/block/*"
advanced:
  bootstrap_mode: 'auto'           # 'auto' | 'manual'
  content_replacement_mode: 'trusted'   # 'trusted' | 'customized'
  content_origins: ''              # origin site UUIDs
  dynamic_js_support: false        # attach per-element libraries on rendered pages
override_lift_meta_tags: false
langcode: en
```

`visibility.path_patterns` is an *exclusion* list: the personalization JS + context are attached
only when the current path does **not** match these patterns (see `PathContext::shouldAttach()`).

## Read / write with drush

```bash
drush cget acquia_perz.settings
drush cget acquia_perz.settings api.site_id
drush cset acquia_perz.settings api.site_id my_site_123 -y
drush cset acquia_perz.settings advanced.dynamic_js_support 1 -y
```

## Region endpoints

The API region maps to a CIS host via `PerzHelper::getRegionEndpoint($region)`:
`us` → `https://us.perz-api.cloudservices.acquia.io`, `eu` → `https://eu.…`,
`ap` → `https://ap.…`, `demo` → `https://demo.…`. `PerzHelper::getRegions()` returns the labels
(`us` = The Americas, `eu` = Europe, `ap` = Asia-Pacific, `demo` = Demo).

## Validation helpers (`Service/Helper/SettingsHelper`)

- `isValidCredentialSiteId()` — Site ID must be non-empty and only `[A-Za-z0-9_-]`.
- `isValidCredentialAccountId()` — must start with a letter/underscore, alphanumeric.
- `isValidBootstrapMode()` — `auto` or `manual`; `isValidContentReplacementMode()` — `trusted` or `customized`.
- `getUdfLimitsForType('person'|'touch'|'event')` — returns 50 / 20 / 50.

## Health check

`hook_requirements('runtime')` (in `acquia_perz.install`) surfaces `PerzHelper::getConfigErrorMessages()`
on the status report: it errors if `acquia_perz_push` is not installed, if the Site ID is missing,
or if the service cannot be reached with the current Acquia Connector credentials.
