<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# synhelper — configuration

## Install
`composer require drupal/synhelper` then `drush en synhelper`. Requires the `idna` module. `hook_install()`
(`synhelper.install`) assigns the `administrator` role to user 1.

## Config object: `synhelper.settings`
One config object. Schema: `config/schema/synhelper.schema.yml` (`type: config_object`, label `SynHelper`).
Install defaults: `config/install/synhelper.settings.yml`. Keys:

| Key | Type | Default | Meaning |
| --- | --- | --- | --- |
| `fz152` | boolean | `true` | Add FZ-152 consent checkbox to contact/register forms; enables `/policy`. |
| `no-index` | boolean | `1` | Forbid search-engine indexing site-wide. |
| `style-page` | boolean | `0` | Enable the `/demo-page` styles page. |
| `no-index-1c` | boolean | `0` | Also no-index when host starts with `1c.`. |
| `link` | string | `""` | FZ-152 agreement link (relative internal only). |
| `link-text` | string | `""` | FZ-152 link text. |
| `agreement-text` | text | `""` | FZ-152 agreement text; `{ссылка}` is replaced by the link. |
| `ya-counter` | string | `""` | Yandex Metrica counter id. |
| `ya-goals` | text | `""` | Conversion goals, one per line `goal|form_id`. |
| `ya-ecommerce` | boolean | `0` | Enable Yandex Ecommerce dataLayer. |
| `ya-ecommerce-events` | sequence(string) | impressions/click/detail/add/remove/purchase | Enabled ecommerce events. |
| `show-ids` | boolean | `0` | Show contact form id as a status message (debug aid). |
| `debug` | boolean | `0` | Debug mode (adds `console.log` on goal fire). |
| `enable-cookies` | boolean | `1` | Show cookie-consent notice / attach `synhelper/agreement`. |
| `cookie-agreement-text` | text | `""` | Cookie notice text; `{ссылка}` replaced by the link. |
| `cookie-agreement-link` | string | `""` | Cookie notice link (relative internal only). |
| `cookie-agreement-link-text` | string | `""` | Cookie notice link text. |

## Settings form
`src/Form/Settings.php` (`Drupal\synhelper\Form\Settings`, `ConfigFormBase`, form id `synhelper`), editable
config `synhelper.settings`. Route `synhelper.settings` → `/admin/config/synapse/synhelper`, requirement
`administer site configuration`. Form groups: General, Cookie warning, FZ152, Yandex Metrica & goals.

`validateForm()` rejects non-relative values for `link` and `cookie-agreement-link` via
`RelativeInternalUrl::isValid()` (`src/Utility/RelativeInternalUrl.php`), which accepts only empty input or a
value parseable by `Url::fromUserInput()` (must start with `/`, `?` or `#`). `submitForm()` maps the form's
`add-checkbox` element to config key `fz152` and stores `ya-ecommerce-events` as a filtered value array.

Note: the form checkbox for FZ-152 is named `add-checkbox` in the form array but saved to config key `fz152`.

## Config translation & links
- `synhelper.config_translation.yml` exposes `synhelper.settings` for translation (base route
  `synhelper.settings`).
- `synhelper.links.menu.yml`: `synhelper.page` under `system.admin_config`, `synhelper.settings` under it.
- `synhelper.links.task.yml`: local tasks `synhelper.logo` and `synhelper.settings` on base `synhelper.page`.

## Related config consumed (not owned)
`PreprocessHtml`/`PreprocessPage` also read `synapse.settings` (`gtm-id`, `ga4-id`) when present, to avoid
double-loading tag managers.
