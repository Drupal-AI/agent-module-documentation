<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Civic Cookie Control — config entity types

Four config entity types (`src/Entity/`, config-prefix = the id, all
`admin_permission = "administer civiccookiecontrol"`). Each has an interface in `src/`, a
ListBuilder in `src/Controller/`, and add/edit/delete forms in `src/Form/`. They are loaded and
merged into the widget config by `AbstractCCCConfig` / `CCC9Config` (see `api/widget-config.md`).

## `cookiecategory` — optional cookie categories

`CookieCategory` (`CookieCategoryInterface`). `config_export`: `id`, `cookieName`, `cookieLabel`,
`cookieDescription`, `cookies`, `thirdPartyCookies`, `thirdPartyCookiesCount`, `vendors`,
`vendorsCount`, `onAcceptCallback`, `onRevokeCallback`, `recommendedState`, `lawfulBasis`.
Mapped in `AbstractCCCConfig::loadCookieCategoryList()` to a widget `optionalCookies[]` entry:
- `name`/`label`/`description`/`recommendedState`/`lawfulBasis` copied through.
- `cookies` = comma-split, trimmed list.
- `onAccept`/`onRevoke` = the stored JS wrapped as `"function(){…}"` strings (eval'd client-side).
- `thirdPartyCookies` / `vendors` parsed from a `;`-separated → `,`-joined JSON fragment via
  `Json::decode('[' . str_replace(';',',', stripslashes(...)) . ']')` when the count > 0.

These categories are what actually block/allow scripts; if none exist (and IAB2 is off) the module
shows an error message prompting you to add at least one (`civiccookiecontrol_check_cookie_categories`).

## `necessarycookie` — strictly-necessary cookies

`NecessaryCookie` (`NecessaryCookieInterface`). `loadNecessaryCookieList()` returns an array of
`getNecessaryCookieName()` values → widget `necessaryCookies[]`. These are always allowed and cannot
be rejected by the visitor.

## `excludedcountry` — excluded countries

`ExcludedCountry` (`ExcludedCountryInterface`). `loadExcludedCountryList()` returns
`getExcludedCountryIsoCode()` values → widget `excludedCountries[]`.

## `altlanguage` — alternative-language consent text

`AltLanguage` (`AltLanguageInterface`) — a large entity carrying a translated copy of every widget
text string (title, intro, accept/reject, necessary/third-party, notify, statement, CCPA, and the
full IAB TCF v2 text set). `CCC9Config::loadAltLanguages($lang)` builds the widget `locales[]`:
- **`browser` locale mode**: all altlanguage entities are emitted; the widget picks by browser locale.
- **`drupal` locale mode**: only the entity whose ISO code matches the current Drupal language is
  emitted (empty → widget uses its default language). Locale codes are lower-cased and `-`→`_`.
Each locale copies `mode`, `location`, all `text.*`, `statement.*`, `ccpaConfig.*`, and (when
IAB2 is on) `text.iabCMP.*`. Statement URLs resolve a node ID to its canonical URL.

## Add-form UX

`hook_link_alter` (`civiccookiecontrol.module`) turns the four `…/add` links into AJAX modal
dialogs (`use-ajax`, `data-dialog-type=dialog`, width 700).
