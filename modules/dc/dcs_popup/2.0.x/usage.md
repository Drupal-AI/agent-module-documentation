Digital Climate Strike Popup embeds the third-party Digital Climate Strike participation widget (a bottom banner or full-page popup) into a Drupal 10/11 site.

---

The module is a thin wrapper around the externally-hosted Digital Climate Strike JavaScript widget (`https://assets.digitalclimatestrike.net/widget.js`). It provides a single admin settings form (`\Drupal\dcs_popup\Form\SettingsForm`) where an administrator selects one of three widget modes — `none`, `bottom` (bottom banner) or `page` (full-page popup) — stored in the `dcs_popup.settings` config object under the `widget` key. A `hook_preprocess_page()` implementation is meant to attach the `dcs_popup/dcspopup-js` library and pass the module config to the browser via `drupalSettings` when the active theme is the site's default theme (i.e. on the front-facing default theme). The remote widget then decides, client-side, whether to render based on display dates and a "closed" cookie. The module carries no dependencies beyond Drupal core, defines no permissions or config schema of its own, and the settings route is gated by the core `access administration pages` permission. Note the module is essentially a campaign/awareness banner tool tied to a specific external service and its fixed date logic.

---

- Add a site-wide "Digital Climate Strike" awareness banner during a climate campaign.
- Show a dismissible bottom banner promoting climate strike participation.
- Show a full-page popup calling site visitors to participate in a climate strike.
- Give content admins a single dropdown to turn the campaign widget on or off (None / Bottom banner / Page popup).
- Participate in a coordinated day-of-action campaign by embedding the shared official widget.
- Reuse the official Digital Climate Strike branding and copy without building a custom banner.
- Display the widget only on the default (front-facing) theme, keeping it off the admin theme.
- Localize the campaign message automatically (the remote widget auto-selects language from browser locale: en, es, de, cs, fr, nl, tr, pt).
- Let visitors dismiss the banner and remember the choice via a client-side cookie.
- Drive traffic to https://digital.globalclimatestrike.net from a participating site.
- Temporarily enable a themed advocacy popup for an environmental non-profit's site.
- Add a low-effort, no-build-step campaign banner to a marketing site.
- Toggle the campaign banner from the Configuration UI without editing code or templates.
- Store the chosen widget mode in exportable configuration for deployment across environments.
- Provide a starting point/example for embedding an external campaign widget in Drupal.
- Support a nonprofit or activism organization's coordinated climate action week.
