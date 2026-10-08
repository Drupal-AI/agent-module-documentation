<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AB Age Gate configuration

## Install & enable

```bash
composer require drupal/ab_age_gate
drush en ab_age_gate -y
drush cr
```

Pulls in `csv_serialization` and `views_data_export`; `info.yml` also depends on core `rest` and
`serialization` (used by the statistics View's CSV data-export display). `hook_install()` just runs
`drupal_flush_all_caches()`. Configure at **`/admin/config/ab_age_gate`** (route
`ab_age_gate.admin_settings`, permission **`administer site configuration`**). Menu links live under
*Configuration → System* (`ab_age_gate.age_gate_settings`) with a child link to the statistics
dashboard (`view.custom_ab_agegate_statistics.page_1`).

## The settings form

`Form\AgeGateSettingsForm` (`getFormId()` = `age_gate_admin_settings`) extends `ConfigFormBase` and
edits the single config object **`ab_age_gate.settings`** (`const SETTINGS`). Injected services:
`config.factory`, `config.typed`, `entity_type.manager`, `language_manager`, `file_url_generator`,
`extension.path.resolver`, `request_stack`.

### Config keys (config/install/ab_age_gate.settings.yml + submitForm)

| Key | Default | Meaning |
|---|---|---|
| `age_gate_type` | `'1'` | Overlay mode: `1` full date (d/m/y), `2` Yes/No, `3` dynamic year. |
| `age_restriction` | `'18'` | Minimum allowed age. Form field bounds `#max` 25 (typo `#mix` 16). |
| `language_preselect` | (checkbox) | Show a language-choice step before verifying, then redirect. |
| `use_datalayer` | (checkbox) | Push GTM `dataLayer` GAEvents on interactions. |
| `age_gate_consent_type` | `'1'` | `1` URLs in footer text, `2` checkbox with URLs (README notes option 2 is not wired up). |
| `terms_of_consent_node` | `null` | Node id (entity_autocomplete, bundles article/page). |
| `private_policy_node` | `null` | Node id; used to substitute `[url_privacy_policy]` → `/node/<id>`. |
| `age_gate_logo_img` | `null` | Resolved URL string of the logo (set in submit; default logo URL if none). |
| `age_gate_logo_img_file_id` | `null` | Managed file id of uploaded logo. |
| `age_gate_background_img` | `null` | Resolved URL of background image (default bg URL if none). |
| `background_image_file_id` | `null` | Managed file id of uploaded background. |
| `bg_type` | `image` | `image` or `color` (gradient/solid). |
| `top_bg_color` / `bottom_bg_color` | `#636466` | Gradient endpoints (used when `bg_type=color`). |
| `primary_accent_color` | `#f5e003` | Overlay text color. |
| `secondary_accent_color` | `#fff` | Popup background color. |
| `button_bg_color` | `#e7bb50` | Submit-button background. |
| `button_text_color` | `#000` | Submit-button text. |
| `font_family` | `''` | CSS font-family applied to the overlay. |
| `ignore_pages` | `null` | Newline-separated paths to disable the gate on; `<front>` = homepage. |
| `language_texts` | (large map) | Per-locale strings under `language_texts.languages.<locale>`. |

There is **no `config/schema/`** in the module, so `ab_age_gate.settings` is schema-less (strict
config-schema checks will warn; values still save).

### Image uploads (submitForm)

Logo and background use `managed_file` elements (`public://age-gate`, image extensions, size limits).
On submit the file is marked permanent, saved, and its public URL is written to
`age_gate_logo_img` / `age_gate_background_img`. If no file is provided, the submit handler writes a
default URL built as `SchemeAndHttpHost + module_path + /assets/images/default_logo.png` (or
`default-agegate-bg.png`).

### Localized text (language_texts)

`config/install/ab_age_gate.settings.yml` ships `language_texts.languages` keyed by locale
(`be-fr`, `be-nl`, `de-de`, `dk-dk`, `es-es`, `eu-en`, `fi-fi`, `fr-fr`, `ie-en`, `it-it`, `nl-nl`,
`no-no`, `pl-pl`, `se-se`, `uk-en`). Each locale has: `header`, `subheader`, `placeholder_y/m/d`,
`error_invalid_dob`, `error_too_young`, `accept_cookies_*`, `error_cookies`, `remember_label`,
`remember_warning`, `button_continue`, `shortimprint`, `responsibledrinking`, `contentsharing`,
`dynamic_year`, `dynamic_year_month`, `dynamic_year_month_day`.

`buildForm()` renders a details group per *active* site language and, on submit, replaces the tokens
`[min_age]` → `age_restriction`, `[url_privacy_policy]` → `/node/<private_policy_node>`,
`[current_year]` → `date('Y')` inside each string. Some strings legitimately contain HTML anchors
(e.g. the cookie-info copy), which the overlay renders as markup.

> Caveat: `buildForm()` seeds missing language text by `file_get_contents()` on the **hard-coded
> path** `/var/www/html/web/modules/contrib/ab_age_gate/config/install/ab_age_gate.settings.yml`.
> This only works on a site rooted at that path (e.g. the standard DDEV/container layout); elsewhere
> the `else` branch throws.

## Ignore pages & excluded paths

`ignore_pages` is split on newlines. For each non-empty line: `<front>` matches only the exact front
URL; any other value matches if the current request URI **contains** that substring
(`str_contains`). The subscriber also always exits early on URIs containing `admin`, `node/add`, or
`translations/add`, so the gate never covers those.
