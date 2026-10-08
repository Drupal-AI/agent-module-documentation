Civic Cookie Control is a Drupal front end to Civic UK's commercial **Cookie Control** consent widget.
It stores the widget's configuration in Drupal (one settings object plus IAB TCF v1/v2 objects and four
config-entity types), assembles it into Civic's JSON config object, injects that as
`drupalSettings.civiccookiecontrol` on every page, and loads Civic's CDN-hosted JavaScript which renders
the consent banner. It supports GDPR and CCPA modes and IAB TCF v1/v2, and needs a Civic API/license key.

---

The module's job is configuration and embedding, not cookie blocking: the banner only makes a site
compliant if the scripts that actually set cookies are wired to the appropriate Cookie Control category's
`onAccept`/`onRevoke` callbacks so they run only after consent. Administration lives at
`/admin/config/system/cookiecontrol` behind the single `administer civiccookiecontrol` permission, as a
multi-step form (enter + validate the API key, then configure appearance, text, behaviour, privacy and
CCPA statements, custom branding and accessibility). Cookie categories, necessary cookies, excluded
countries and per-language text overrides are managed as config entities; IAB Transparency & Consent
Framework text and vendor lists have their own tabs. The GOV.UK/DWP variant is provided by the
`civic_govuk_cookiecontrol` submodule. The API/license key is a client-side widget key that Civic's
script needs in the browser, so it is emitted in the page's `drupalSettings` by design.

---

- Add an EU/UK cookie-consent banner to a Drupal site with an explicit opt-in (GDPR).
- Run the consent widget in CCPA "Do Not Sell My Personal Information" mode for US audiences.
- Gate Google Analytics / GTM so tags fire only after the visitor accepts the analytics category.
- Block marketing/advertising pixels until consent, and clear them on revoke via `onRevoke`.
- Present IAB TCF v2 (CMP) vendor consent for ad-tech partners.
- Categorise cookies (necessary vs optional) and describe each for the preferences panel.
- Declare "necessary" cookies that are always allowed and shown as such.
- Suppress the banner in specific countries via excluded-country ISO codes.
- Localise all banner text per language (alt-language entities) in browser- or Drupal-language mode.
- Link the banner's privacy statement to a Drupal node (privacy policy page).
- Add a separate CCPA privacy statement with its own node link and reject button.
- Customise widget position, layout, theme, fonts and colours (PRO/CUSTOM licenses).
- Remove Civic branding / the widget icon on paid licenses and supply your own toggle button.
- Run custom JavaScript when the widget loads via the `onLoad` hook.
- Keep the banner off admin pages, or force it on with the `drupal_admin` toggle.
- Set consent-cookie flags: secure, SameSite value, sub-domain sharing, expiry.
- Enable Civic's consent logging for an audit trail.
- Show the widget in explicit "open" state on first visit and notify-once afterwards.
- Reset the built config after edits by clearing the `civiccookiecontrol_config` cache.
- Provide a GOV.UK DWP-pattern cookie banner and details page via the submodule.
- Import/export the whole consent configuration as Drupal config (categories, languages, texts).
- Work across a subscription's multiple sites with a PRO_MULTISITE key.
- Validate a Civic license key from the settings form before going live.
