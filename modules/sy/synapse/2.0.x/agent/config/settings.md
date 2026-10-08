<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Synapse settings & output behavior

## Install / enable
`drush en synapse -y`. No dependencies beyond Drupal core (`^11 || ^12`). Enabling installs `synapse.settings` from `config/install/synapse.settings.yml` (seeds empty `gtm-id`, `wm-yandex`, `wm-google`).

## Settings form
`\Drupal\synapse\Form\Settings` (`src/Form/Settings.php`), form id `synapse_settings`, editable config `synapse.settings`.
- Route: `synapse.settings` → path `/admin/config/synapse/settings`, `_form` `\Drupal\synapse\Form\Settings`, requirement `_permission: 'administer site configuration'` (`synapse.routing.yml`).
- Menu: `synapse.links.menu.yml` places it under `system.admin_config_system`.
- Injects `LanguageManagerInterface` (constructor) to localize the help links (GTM / Google / Yandex consoles use the current UI language id).

### Form fields → config keys
| Form element | Config key | Notes |
|---|---|---|
| `gtm_id` (textfield, maxlength 20) | `gtm-id` | GTM container ID, e.g. `GTM-XXXXXX`. |
| `ga4_id` (textfield, maxlength 20) | `ga4-id` | GA4 measurement ID, stored for Data Layer / ecommerce use. |
| `gtm_admin_disable` (checkbox) | `gtm-admin-disable` | When on, GTM is not emitted for user 1. |
| `webmaster_yandex` (textfield, maxlength 255) | `wm-yandex` | Content for the `yandex-verification` meta tag. |
| `webmaster_google` (textfield, maxlength 255) | `wm-google` | Content for the `google-site-verification` meta tag. |

`submitForm()` writes all five keys back to `synapse.settings`. Note the seeded install config only contains three keys; `ga4-id` and `gtm-admin-disable` are created on first save. There is no `config/schema/`, so these keys are schema-less (untyped) config.

## Site-verification meta tags — `PageAttachments`
`\Drupal\synapse\Hook\PageAttachments::hook()` runs on `hook_page_attachments()`. For each of `wm-google` / `wm-yandex`, when the value is truthy it appends to `$page['#attached']['html_head']` a `meta` element:
- `wm-google` → `<meta name="google-site-verification" content="…">` (key `google`).
- `wm-yandex` → `<meta name="yandex-verification" content="…">` (key `yandex`).

These render on every page head (including admin). Content is placed via the render array's `#attributes`, so Drupal escapes it.

## GTM snippet — `PreprocessHtml`
`\Drupal\synapse\Hook\PreprocessHtml::hook()` runs on `hook_preprocess_html()`. It injects the standard GTM loader `<script>` into `$variables['page_bottom']['gtm']` (render array with `#weight => 999`) only when ALL hold:
- `gtm-id` is set (and is a string), and
- the request path does not start with `/admin/`, and
- not suppressed: suppression applies when the current user is user 1 AND `gtm-admin-disable` is on.

The GTM ID is interpolated into the inline loader script string; the `#markup` uses `#allowed_tags => ['script']`. The GA4 id (`ga4-id`) is stored but not emitted directly by this module — it is intended for use inside GTM's own Data Layer configuration.

## Operate
- Set GTM: fill GTM-ID, save; verify a `googletagmanager.com/gtm.js` script appears at the bottom of a non-admin page.
- Verify with a search console: paste the console's meta content into the Google/Yandex field, save, then confirm ownership from the console (the meta tag appears in every page `<head>`).
- Keep admins out of analytics: enable "Disable GTM for user 1".
