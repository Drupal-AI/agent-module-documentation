Civic Cookie Control integrates the CivicUK Cookie Control consent widget into Drupal so your site can present a cookie-consent banner and comply with UK PECR and EU GDPR cookie law.

---

The module is a configuration and asset-loading layer around Civic's hosted Cookie Control JavaScript (served from `cc.cdn.civiccomputing.com`). You supply a Civic API key (a public, domain-locked site key) and licence type on the settings wizard at `/admin/config/system/cookiecontrol`, then customise the widget's text, branding, accessibility, statement, CCPA notice and — for supported licences — IAB TCF v2 vendor configuration. Optional-cookie categories, strictly-necessary cookies, excluded countries and per-language translations are managed as config entities and merged into the JSON configuration object that the module builds server-side (`CCC8Config` / `CCC9Config`) and attaches to every front-end page via `hook_page_attachments`. A client-side behaviour reads that JSON from `drupalSettings` and calls `CookieControl.load(config)`. An optional submodule, `civic_govuk_cookiecontrol`, ships a GOV.UK Design System styled banner block for public-sector (DWP) services instead of the Civic widget. All configuration screens are gated by the single `administer civiccookiecontrol` permission, and several also require a validated API key.

---

- Show a GDPR/PECR cookie-consent banner on a Drupal site without writing any JavaScript.
- Enter a Civic Cookie Control API key and select the licence tier (Community, PRO, PRO Multisite, Enterprise/Custom).
- Choose Cookie Control widget version 8 or version 9 to match the API key you obtained from Civic.
- Define optional-cookie categories (analytics, marketing, etc.) that visitors can toggle on or off.
- Attach `onAccept` / `onRevoke` JavaScript callbacks to each cookie category so scripts run only after consent.
- List strictly-necessary cookies that are always allowed and cannot be rejected by the visitor.
- Declare per-category third-party cookies and vendor entries for transparency in the widget.
- Set the widget's initial state, layout (slide-out/pop-up), position, theme (light/dark) and branding colours.
- Customise every piece of banner text: title, intro, accept/reject labels, notify text, necessary/third-party descriptions.
- Configure accessibility options such as access key, focus highlighting, overlay, outline and disabling site scrolling.
- Link the banner's privacy statement to an existing Drupal node (privacy policy page) by node ID.
- Add a separate CCPA "Do Not Sell" statement and reject-button label for US visitors.
- Enable IAB TCF v2 (CMP) mode and configure the full set of TCF panel/vendor text strings.
- Restrict or exclude specific countries from being shown the consent widget via Excluded Country entities.
- Provide alternative-language consent text through Alternative Language config entities, in browser-locale or Drupal-language mode.
- Control cookie behaviour: consent cookie expiry, same-site value, secure cookie flag, custom cookie name, sub-domain sharing.
- Log consent decisions (where the Civic licence supports server-side consent logging).
- Add an on-load JavaScript callback that runs when the widget initialises.
- Exclude the consent script from Drupal's JS aggregation so the hosted widget always loads fresh.
- Install a ready-made "Cookie Control HTML" text format/editor for rich statement descriptions.
- Deploy a GOV.UK Design System compliant cookie banner block for DWP / public-sector services via the submodule.
- Provide translated banner text per language for the GOV.UK banner using the alternative-language entities and locale strings.
