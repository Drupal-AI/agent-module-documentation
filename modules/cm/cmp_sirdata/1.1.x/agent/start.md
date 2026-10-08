<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CMP Sirdata (cmp_sirdata) — agent index

Integrates the **Sirdata Consent Management Platform** (GDPR/ePrivacy/CCPA cookie-consent banner,
IAB TCF v2.1 certified). An admin enters two keys; the module then loads Sirdata's two CMP scripts
as **external JS** on every non-admin front-end page. There is **no server-side call, no entity, no
block, no theming** — the whole module is one settings form plus two `hook`s that attach a
dynamically-built external JS library. Package `Custom`. Core `^9 || ^10 || ^11`. License
GPL-2.0-or-later. Installed as **1.1.0** (version dir `1.1.x`). No Composer/PHP-library
dependencies beyond core (`php >=7.2.5`).

## What it provides (from source)

- **Settings form** `Drupal\cmp_sirdata\Form\SettingsForm` (`ConfigFormBase`), route
  `cmp_sirdata.settings_form` → `/admin/config/system/cmp-sirdata`
  (`cmp_sirdata.routing.yml`), menu link under *Configuration → System*
  (`cmp_sirdata.links.menu.yml`). Three fields, stored in config object
  `cmp_sirdata.settings`: `enable` (bool), `customer_key` (string, required),
  `app_key` (string, required). `submitForm()` `trim()`s both keys.
- **Permission** `administer cmp sirdata configuration` (`cmp_sirdata.permissions.yml`,
  `restrict access: true`) — the only gate on the settings route.
- **Config schema** `cmp_sirdata.settings` (`config/schema/cmp_sirdata.schema.yml`):
  `enable` boolean, `customer_key` string, `app_key` string.
- **`cmp_sirdata.module`** — three hooks:
  - `hook_help` (help.page text, links to https://cmp.docs.sirdata.net/).
  - `hook_page_attachments` — attaches library `cmp_sirdata/scripts` to the page, but **only** when
    `enable` is on, the route is **not** an admin route (`router.admin_context`), and **both**
    `app_key` and `customer_key` are set. Merges the config's cache tags onto the page.
  - `hook_library_info_build` — dynamically defines the `scripts` library as two **external** JS
    files whose URLs embed the two keys (see [config/settings.md](config/settings.md)).
- **No** `.services.yml`, `.libraries.yml` (library is built in code), `.install`, block, controller,
  or submodule. One functional test (`tests/src/Functional/CmpSirdataTests.php`) asserts the two
  `<script>` tags appear for anon + auth (and under Big Pipe) when enabled, and vanish when disabled.

## The two loaded scripts (from `hook_library_info_build`)

Rendered as external `<script>` tags on front-end pages (attributes `referrerpolicy="unsafe-url"`,
`charset="utf-8"`, `type="text/javascript"`):

- `https://cache.consentframework.com/js/pa/{app_key}/c/{customer_key}/stub`
- `https://choices.consentframework.com/js/pa/{app_key}/c/{customer_key}/cmp`

These are Sirdata's third-party CMP scripts; they manage consent, may set cookies, and contact
Sirdata. No Subresource Integrity (SRI) hash is applied (inherent to a live CMP script).

## Field-name note (corrects the project page)

The drupal.org project description talks about pasting your *"partner"* and *"config"* IDs. The
**actual module fields** are labelled **CMP Sirdata Customer Key** (`customer_key`) and **CMP
Sirdata App Key** (`app_key`) — those are the two identifiers to enter, mapped into the script URLs
above (`app_key` → `.../pa/{app_key}/...`, `customer_key` → `.../c/{customer_key}/...`).

## Solution docs

- **Settings form, config schema, page-attachment gating, script-injection mechanics** →
  [config/settings.md](config/settings.md)
