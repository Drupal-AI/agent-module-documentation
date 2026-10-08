<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Civic GovUK Cookie Control (civic_govuk_cookiecontrol) — agent index

Submodule of **civicccookiecontrol** (parent module machine name `civiccookiecontrol`). Renders the
Civic Cookie Control consent UI in the **GOV.UK / DWP Design System cookie-consent pattern** for
public-facing UK government (DWP) services. It adds two **blocks** (a banner + a details panel) and a
small settings form to customise/translate the pattern's fixed button/message text. Version **4.6.1**,
core `^9.3 || ^10 || ^11`, PHP 8.0.

Depends on `civiccookiecontrol`, `language`, `config_translation`. No permission of its own — everything
here is gated by the parent's `administer civiccookiecontrol`. Ships no config schema of its own.

Set up the parent first (API key, cookie categories, privacy-statement node), then place the two blocks.

- **The two blocks (banner + details) and how they render** → [blocks/blocks.md](blocks/blocks.md)
- **The GOV.UK text settings form + config keys + translation** → [configure/settings.md](configure/settings.md)

Key facts:
- Configure route `civic_govuk_cookiecontrol.admin_overview` → `/admin/config/system/cookiecontrol/govuk`
  (perm `administer civiccookiecontrol`), form `CivicGovUkCookieControlSettings`.
- Config object `civic_govuk_cookiecontrol.settings` (11 `govuk_cookiecontrol_*` text keys; defaults in
  `config/install/civic_govuk_cookiecontrol.settings.yml`).
- Blocks: `govuk_cookiecontrol_banner_block` ("GovUk CookieControl Banner"),
  `govuk_cookiecontrol_details_block` ("GovUk CookieControl Details").
- Themes/templates: `civic_govuk_cookiecontrol_banner`, `civic_govuk_cookiecontrol_details` (+ an admin
  page template); libraries `civic_govuk_cookiecontrol.banner` / `.details`.
- Reads parent data at runtime: `civiccookiecontrol.settings` (title/intro/statement/privacynode) and the
  `altlanguage` config entities for per-language text.

See the parent index: `../../../4.6.x/agent/start.md`.
