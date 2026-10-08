# Configure the banner, categories & service gates

## Show the banner

The consent banner is the **COOKiES UI** block (plugin `cookies_ui_block`). Place it via core Block
layout (**Admin → Structure → Block layout**) in any region. `cookies.knock_out` only knocks scripts out
on pages where this block is actually visible. A second block, `cookies_docs_block`, renders the cookie
documentation. Add a (footer) menu link to `#editCookieSettings` so users can re-open the dialog.

## Admin routes / forms

| Route | Path | Purpose | Permission |
|---|---|---|---|
| `cookies.overview` | `/admin/config/system/cookies` | Landing menu | `configure cookies config` |
| `cookies.config` | `/admin/config/system/cookies/config` | Base config form (`configure` target) | `configure cookies config` |
| `cookies.texts` | `/admin/config/system/cookies/texts` | Banner/widget texts | `configure cookies widget texts` |
| `entity.cookies_service.collection` | `.../cookies-service` | List/add/edit service entities | `administer cookies services and service groups` |
| `entity.cookies_service_group.collection` | `.../cookies-service-group` | List/add/edit groups | `administer cookies services and service groups` |
| `cookies.cookies_documentation` | `/cookies/documentation` | Public GDPR cookie docs page | `access content` |

## Base config object — `cookies.config`

Edit via the form or `drush cset cookies.config <key>`. Defaults from `config/install/cookies.config.yml`:

| Key | Default | Meaning |
|---|---|---|
| `cookie_name` | `cookiesjsr` | Name of the consent cookie |
| `cookie_expires` | `365` | Consent cookie lifetime (days) |
| `cookie_domain` | `''` | Cookie domain |
| `cookie_secure` | `false` | Secure flag |
| `cookie_same_site` | `Lax` | SameSite policy |
| `open_settings_hash` | `editCookieSettings` | URL hash that re-opens the dialog |
| `show_deny_all` | `true` | Show a "Deny all" button |
| `deny_all_on_layer_close` | `false` | Treat closing the layer as deny-all |
| `settings_as_link` | `false` | Render settings entry as a link |
| `group_consent` | `false` | Consent per group instead of per service |
| `cookie_docs` | `true` | Enable the cookie documentation |
| `lib_load_from_cdn` | `true` | Load cookiesjsr from CDN vs. local (`/libraries/cookiesjsr`) |
| `lib_scroll_limit` | `0` | Scroll distance that implies consent (0 = off) |
| `use_default_styles` | `true` | Load the bundled CSS (disable to fully restyle) |
| `store_auth_user_consent` | `false` | Persist consent for logged-in users |

Config schema: `config/schema/cookies.config.schema.yml`. All config is translatable
(`cookies.config_translation.yml`).

## Service groups (consent categories) — `cookies_service_group` config entity

Six groups ship in `config/install/`: `functional` (required), `performance`, `marketing`, `tracking`,
`social`, `video`. Fields: `id`, `label`, `weight`, `title`, `details`. The `functional` group is the
always-on essential category.

## Gate a script with a `cookies_service` config entity

Create a service (at `.../cookies-service/add`) to represent one third-party processor. Schema
`cookies.cookies_service.*` — key fields:

| Field | Notes |
|---|---|
| `id`, `label` | Machine name + label; the `id` is the consent key (e.g. `analytics`) |
| `group` | Which `cookies_service_group` it belongs to |
| `info` | text_format — the cookie-table shown in the GDPR docs |
| `consentRequired` | bool — whether the service needs explicit consent |
| `placeholderMainText` | Overlay message shown on a blocked element |
| `placeholderAcceptText` | Label of the "accept only this service" button |
| `purpose`, `processor`, `processorContact`, `processorUrl`, `processorPrivacyPolicyUrl`, `processorCookiePolicyUrl` | GDPR documentation fields |

An integration submodule then tags its script `data-cookieconsent="<service id>"` and knocks it out until
that consent key is granted (see [api/cookies.md](../api/cookies.md)).

## Enable a per-service integration (submodule)

Rather than hand-building a gate, `drush en cookies_ga` (or `cookies_matomo`, `cookies_gtag`,
`cookies_facebook_pixel`, `cookies_instagram`, `cookies_twitter_media`, `cookies_video`,
`cookies_recaptcha`, `cookies_ivw`, `cookies_asset_injector`, `cookies_filter`). Each submodule depends
on both `cookies` and the tool's own module (e.g. `cookies_ga` needs `google_analytics`) and ships its own
`cookies_service` in its `config/install/`.
