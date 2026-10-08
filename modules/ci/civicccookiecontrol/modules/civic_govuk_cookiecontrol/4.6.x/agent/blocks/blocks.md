# GOV.UK Cookie Control blocks

Two core Block plugins (in `src/Plugin/Block/`). Place them at **Structure → Block Layout**; both require
the parent Civic Cookie Control to be configured (valid API key + at least one cookie category + a privacy
statement). They render GOV.UK/DWP-styled markup instead of Civic's default widget.

| Block id | admin_label | Theme / template | Library | Where to place |
|---|---|---|---|---|
| `govuk_cookiecontrol_banner_block` | GovUk CookieControl Banner | `civic_govuk_cookiecontrol_banner` (`templates/block--civic-govuk-cookiecontrol-banner.html.twig`) | `civic_govuk_cookiecontrol.banner` (`assets/js/banner.js` + `assets/css/style.css`) | Top of the theme (site-wide) |
| `govuk_cookiecontrol_details_block` | GovUk CookieControl Details | `civic_govuk_cookiecontrol_details` (`templates/block--civic-govuk-cookiecontrol-details.html.twig`) | `civic_govuk_cookiecontrol.details` (`assets/js/details.js`) | The cookie-policy page |

## Banner block (`CivicGovUkCookieControlBannerBlock`)

- Block-instance setting **`fixed_top`** (checkbox, `blockForm`): pin the banner to the top of the page.
- `build()` reads the current language; if an `altlanguage` config entity matches the language it uses that
  entity's text, otherwise it falls back to the parent `civiccookiecontrol.settings` values
  (`civiccookiecontrol_title_text`, `_intro_text`, `_stmt_descr`, `_accept_settings`, `_reject_settings`).
- The privacy-policy link is built from `civiccookiecontrol_privacynode` (node id) + `civiccookiecontrol_stmt_name`.
- Button/message text (`accepted_cookies`, `rejected_cookies`, hide button, "change settings" prefix/suffix/
  link) come from `civic_govuk_cookiecontrol.settings` and are passed through the locale string translation
  so `config_translation` can localise them (rendered with `#plain_text`).

## Details block (`CivicGovUkCookieControlDetailsBlock`)

- Renders the full cookie-preferences panel for the cookie-policy page: intro text plus one row per
  **`cookiecategory`** entity (name + description, Yes/No toggle) so visitors can change consent there.
- Uses the alt-language entity for the current language when present, else the parent config + category
  descriptions. `assets/js/details.js` handles the save/continue interaction.

Both blocks source their category rows from the parent module's `cookiecategory` config entities, so
categories defined in Civic Cookie Control appear automatically.
