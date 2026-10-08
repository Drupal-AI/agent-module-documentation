<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration & settings form

The engine has **no config route, config schema, or config-install file of its own**. Its settings
are the plugin configuration that **Entity Print** stores for the selected PDF engine (Entity Print's
settings form, typically `/admin/config/content/entityprint`; gated by Entity Print's own
permission). Form building lives in `BrowserlessApi::buildConfigurationForm()` /
`validateConfigurationForm()` in `src/Plugin/EntityPrint/PrintEngine/BrowserlessApi.php`.

## Install / enable

- `composer require drupal/entity_print_browserless_pdf` (pulls `drupal/entity_print:^2.4`).
- `drush en entity_print_browserless_pdf`.
- On the Entity Print settings form choose **Browserless API** as the PDF engine, then set the
  endpoint (and token if your instance requires one).

## `defaultConfiguration()` keys and defaults

- `endpoint` — `'https://chrome.browserless.io'` (base URL; `/pdf` is appended at runtime).
- `token` — `NULL` (Browserless access token).
- `print_background` — `FALSE`.
- `safe_mode` — `FALSE`.
- `display_header_footer` — `FALSE`.
- `header_template` — `NULL`.
- `footer_template` — `NULL`.
- `asset_url` — `NULL` (override base URL for rewriting root-relative CSS/JS; blank ⇒ current
  scheme+host).
- `margin_unit` — `'mm'` (or `'px'`).
- `margin_top` / `margin_right` / `margin_left` / `margin_bottom` — `'10'`.

These merge over `PdfEngineBase::defaultConfiguration()`, which supplies `default_paper_size`.

## Form fields

- **Custom API Endpoint** (`endpoint`, textfield) — leave to use the paid browserless.io service, or
  point at a self-hosted instance (include a non-80 port, e.g. `https://example.com:3000`).
- **Token** (`token`, `#type => 'password'`) — optional; used to secure a Browserless instance.
- **Alternate asset URL** (`asset_url`, textfield).
- **Chrome Print Options** (details): **Display Background Graphics** (`print_background`),
  **Safe Mode** (`safe_mode`), **Display Header and Footer** (`display_header_footer`),
  **Header Template** / **Footer Template** (textareas; inline styling only — no external
  fonts/CSS/JS), and a **Margins** fieldset (`margin_unit` select + four numeric margin fields).
- On form build the engine calls `testEndpoint()`; a `200` shows a "Successfully connected…" message,
  and `endpoint_debug` markup prints the resolved absolute endpoint URL.

## How the token is stored (accurate)

The token is a **plain plugin configuration value**, held in Entity Print's engine configuration and
seeded into the password field via `#default_value`. The module implements **no** environment-variable
lookup, **no** Key-module (`key`) integration, and **no** encryption — it reads/writes
`$this->configuration['token']` directly, and appends it to the request URL as the `token` query
parameter. There is no dotenv/`getenv()`/Key-entity mechanism in this module's source.

## Validation (`validateConfigurationForm()`)

Uses the Symfony validator on the `browserless_api` values:

- `endpoint` and `asset_url` — must be a valid `http`/`https` URL and must **not** end with a trailing
  slash (a `Callback` constraint enforces the no-trailing-slash rule).
- `token`, `header_template`, `footer_template` — must be strings.
- `margin_unit` — one of `mm` / `px`; the four margins — `PositiveOrZero`.
- `safe_mode` / `print_background` / `display_header_footer` — `Choice([0, 1])`.

Violations are mapped back to the matching form element by `validateValues()` (recursive property-path
match) and reported via `setErrorByName('browserless_api][…')`.
