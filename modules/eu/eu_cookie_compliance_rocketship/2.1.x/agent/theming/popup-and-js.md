<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Popup theming, buttons, language switcher, libraries & JS

All in `eu_cookie_compliance_rocketship.module`, `templates/eu_cookie_compliance_popup_info.html.twig`,
`eu_cookie_compliance_rocketship.libraries.yml` and the two `js/` files.

## Theme override

`hook_theme_registry_alter` repoints the `eu_cookie_compliance_popup_info` theme hook at this module's
`templates/` directory and registers four extra template variables: `lang_switcher`, `accept_minimal`,
`dynamic_accept`, `state_on`. So the module's own Twig template renders the popup body.

## Injected variables (`preprocess_eu_cookie_compliance_popup_info`)

Reads `eu_cookie_compliance_rocketship.settings` and adds:

- `lang_switcher` — only when `language_switcher` is on. Builds a `#theme => 'links'` list of the
  current route in each enabled language (skips languages hidden by the optional `disable_language`
  module), rendered to a string, wrapped in class `eu-cookie-compliance-language-switch`. Only emitted
  when more than one language link exists.
- `accept_all` / `manage_selection` / `accept_selection` / `accept_minimal` — four `Link` objects to
  `<none>` (href `#`) with labels from config and the CSS classes
  `eu-cookie-compliance-rocketship--{accept-all,manage-selection,accept-selection,accept-minimal}`
  plus `button`. `accept_all` also carries `data-all` / `data-selection` labels used by the JS to
  relabel the button when switching between "accept all" and "save selection" modes.
- `state_on` — the translated "On" label (context `enabled`).
- Sets `#cache[tags]` to the config's cache tags (the upstream template hard-codes its own tag).

## Attachments (`hook_page_attachments_alter`)

When `drupalSettings.eu_cookie_compliance` is present on the page it attaches libraries
`eu_cookie_compliance_rocketship/general` and `/reopen_link`, plus `/css_structural` and `/css_extra`
when their config flags are on, and adds cache tag `eu_cookie_compliance_rocketship:attachments`.
Additionally `hook_library_info_alter` appends `eu_cookie_compliance_rocketship/general` as a
dependency of the upstream `eu_cookie_compliance/eu_cookie_compliance` library.

## Libraries (`.libraries.yml`)

- `general` → `js/eu-cookie-compliance-rocketship.js` (deps: jQuery, once, drupalSettings).
- `reopen_link` → `js/eu-cookie-compliance-rocketship--reopen-link.js` (same deps).
- `css_structural` → `css/eu-cookie-compliance-rocketship.css`.
- `css_extra` → `css/eu-cookie-compliance-rocketship-design.css`.

## JS behaviours

`Drupal.behaviors.euccRocketship` (general): on the `eu_cookie_compliance_popup_open` event it wires
the injected buttons to the *native* EUCC controls — it does not write cookies itself:

- Accept-all button clicks the native `.agree-button.eu-cookie-compliance-default-button`.
- Manage-cookies button reveals the category list and the Save-preferences button.
- Save-preferences button clicks the native `.eu-cookie-compliance-save-preferences-button`.
- Accept-minimal button unchecks every non-`.disabled` category checkbox, then clicks
  Save-preferences (= consent to required categories only).
- `initStateLabel` toggles a `.state-label`/`aria-checked` per category checkbox.
- `initAccessibility` traps focus inside `#sliding-popup`, sets `aria-hidden` on the background,
  blocks tabbing to background links while the popup is open, and lets space toggle a category.

`Drupal.behaviors.euccRocketshipReopenLink` (reopen_link): binds `a.eucc-open`,
`a[href$="#eucc-open"]`, `button[data-eucc-open]` and the `cookieContentBlockerChangeConsent` window
event to `show_eucc_popup()`, which re-opens or re-creates the popup (respecting the mobile
breakpoint / mobile message from `drupalSettings.eu_cookie_compliance`).

## Consent cookie id (`hook_eu_cookie_compliance_cid_alter`)

Appends the current route name and its raw parameters to the consent cookie id, each part sanitised
to `[a-z0-9-]` via `preg_replace`. Effect: consent tracking varies per route/params rather than being
purely global.
