<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Civic GovUK Cookie Control — banner block

## Install / enable

```bash
drush en civic_govuk_cookiecontrol -y   # pulls in civiccookiecontrol, language, config_translation
```

Then place the **GovUk CookieControl Banner** block (`govuk_cookiecontrol_banner_block`) in a region
and configure text at `/admin/config/system/cookiecontrol/govuk`
(`civic_govuk_cookiecontrol.admin_overview`, permission `administer civiccookiecontrol`).

## Blocks (`src/Plugin/Block/`)

- **`CivicGovUkCookieControlBannerBlock`** — id `govuk_cookiecontrol_banner_block`,
  admin label "GovUk CookieControl Banner". Block form adds one option `fixed_top` (checkbox:
  show the banner fixed at the top of the page). Injects `config.factory`, `language_manager`,
  `entity_type.manager`, `locale.storage`.
- **`CivicGovUkCookieControlDetailsBlock`** — companion block for a cookie-preferences details view
  (`templates/block--civic-govuk-cookiecontrol-details.html.twig`).

## Render flow (`build()` → `loadCookieTextsInRenderArray()`)

`build()` sets `#theme => 'civic_govuk_cookiecontrol_banner'`, attaches the
`civic_govuk_cookiecontrol.banner` library and a `civic-govuk-cookiecontrol` wrapper class, then
loads text:
- For the current language it queries the `altlanguage` storage for an entity whose id equals the
  language code (`accessCheck(FALSE)`, a read of admin-managed config entities).
- **Non-English + altlanguage entity found**: banner title/description/statement/accept/reject come
  from the entity (`getAltLanguageTitle()`, `…Intro()`, `…StmtDescrText()`, `…AcceptSettings()`,
  `…RejectSettings()`), policy link from `getAltLanguageStmtUrl()` + `…StmtNameText()`.
- **Else (English / no entity)**: values come from parent `civiccookiecontrol.settings`
  (`civiccookiecontrol_title_text`, `_intro_text`, `_stmt_descr`, `_accept_settings`,
  `_reject_settings`, `_stmt_name`, `_privacynode`).

Submodule-specific strings (`civic_govuk_cookiecontrol.settings`): `accepted_cookies`,
`rejected_cookies`, `change_cookie_settings_prefix/suffix`, `hide` — each rendered via `#plain_text`
and translated through `getTranslation()` (which consults `locale.storage` for non-English).

Links (`getPolicyLink`, `getChangeCookieSettingsLink`) are `Link::createFromRoute` on
`entity.node.canonical` using the privacy-policy node id, with GOV.UK link classes.

## Template

`templates/block--civic-govuk-cookiecontrol-banner.html.twig` renders GOV.UK-classed markup:
main banner (heading, description, statement + policy link, accept/reject buttons), plus hidden
accept/reject confirmation panels with a hide button, and a `<noscript>` fallback that posts
`cookieChoice` to `/set-cookie-message`. All interpolated values (`{{ title_banner }}`,
`{{ description }}`, `{{ stmt_descr }}`, labels) are Twig-auto-escaped; links arrive as render
arrays. Client behaviour is in `assets/js/banner.js`.
