<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings form, config object, routes, permission & Test ASIN page

## Install / enable

```
composer require drupal/amazon_paapi   # pulls thewirecutter/paapi5-php-sdk ^1.3
drush en amazon_paapi -y
```

No other Drupal module is required (`dependent_modules: []`). You must be an Amazon Associate and
have PA-API 5.0 credentials.

## Routes & permission

`amazon_paapi.routing.yml` defines two routes, both under `/admin/config/services/amazon-paapi/`,
both `options._admin_route: TRUE`, both gated by `_permission: 'administer amazon paapi'`:

| Route id                     | Path                | Form                     |
|------------------------------|---------------------|--------------------------|
| `amazon_paapi.settings_form` | `.../settings`      | `Form\SettingsForm`      |
| `amazon_paapi.test_asin_form`| `.../test-asin`     | `Form\TestAsinForm`      |

`amazon_paapi.permissions.yml` declares the single permission **`administer amazon paapi`**
(title "Administer Amazon Paapi", `restrict access: true` — treated as security-sensitive). Menu
links (`system.admin_config_services` parent) and local tasks are declared in
`amazon_paapi.links.menu.yml` / `amazon_paapi.links.task.yml`. `info.yml` sets
`configure: amazon_paapi.settings_form`.

## The settings form

`Drupal\amazon_paapi\Form\SettingsForm` (`src/Form/SettingsForm.php`) is a `ConfigFormBase` editing
`amazon_paapi.settings`, form id `amazon_paapi_settings`. It renders five **required** textfields —
`access_key`, `access_secret`, `host`, `region`, `partner_tag` — each pre-filled with the resolved
value from `AmazonPaapi::get*()`.

Env-var awareness: for every key where `AmazonPaapi::isSetInEnv()` is TRUE, the field is set
`#disabled` + `#required = FALSE` and its description notes it is controlled by the named env var.
On submit, only keys **not** set in env are written back to config — so an env-provided value can
never be overwritten by the form. There is no `validateForm()`; values are stored as entered.

## Config object `amazon_paapi.settings`

A simple config object with five string keys (`access_key`, `access_secret`, `host`, `region`,
`partner_tag`). The module ships **no `config/install` default file and no `config/schema`** — the
object is created on first form save (so a `drush config:export` before saving shows nothing, and
these keys are schema-less). Example after saving:

```yaml
# amazon_paapi.settings
access_key: AKIA...
access_secret: '...'
host: webservices.amazon.com     # SDK prepends https://
region: us-east-1
partner_tag: yourtag-20
```

Valid host/region pairs per marketplace are listed in Amazon's PA-API "Host and Region"
documentation. Prefer supplying `access_secret` (and the others) via the `AMAZON_PAAPI_*` env vars
rather than committing them to config; env values override config and lock the form field.

## Test ASIN page

`Drupal\amazon_paapi\Form\TestAsinForm` (`src/Form/TestAsinForm.php`, uses `AmazonPaapiTrait`)
takes a single `asin` textfield and, on submit, calls `fetchProductData($asin)`, which issues a
live `GetItems` request (a broad fixed `GetItemsResource` set: title/by-line/classifications,
primary+variant images S/M/L, offer price/availability/promotions/saving-basis/Prime, review
rating+count). It surfaces ASIN, title, detail-page URL and buying price as status messages, any
API errors as warnings, and stashes the full response object in
`$_SESSION['amazon_paapi.debug_asin.response']`. On the next build that object is shown via
`var_export()` in a **disabled** textarea, then the session key is unset. Admin-only debug aid; not
for production display. Output is rendered through the Form API (escaped) — do not treat it as a
sanitized rendering helper for untrusted data.
