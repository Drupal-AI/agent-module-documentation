Cookie Script Integration injects the Cookie-Script.com consent loader (keyed by your account ID) onto every page so the service can show its consent banner and block cookie-setting scripts until visitors agree.

---

This small integration module connects a Drupal site to the commercial Cookie-Script.com consent product. You enter a single account/domain ID on an admin settings form, and the module attaches Cookie-Script's external loader script (`//cdn.cookie-script.com/s/<id>.js`) to every rendered page via a Drupal asset library. All banner appearance, cookie categorisation and script-blocking behaviour are configured in the Cookie-Script.com dashboard, not in Drupal — the module's only job is to place the loader. It ships no dependencies beyond Drupal core, no submodules, no config schema and no Drush commands; configuration is one text field storing one value (`cookie_script.settings:id`). A key compliance point for any consent integration: a banner only helps with cookie law if the scripts that actually set cookies respect consent, so the analytics/marketing/embed scripts must be blocked in the Cookie-Script service until the visitor agrees, and the third-party consent service itself should be disclosed in your privacy notice.

---

- Add a cookie-consent banner to a Drupal site via Cookie-Script.com.
- Inject the Cookie-Script loader onto every page automatically.
- Configure the integration with a single Cookie-Script account/domain ID.
- Centralise banner styling and text in the Cookie-Script dashboard.
- Block analytics scripts until the visitor consents.
- Block marketing/advertising tags until consent.
- Block third-party embeds (video, maps, social) until consent.
- Categorise cookies (necessary, analytics, marketing) in the service.
- Record and store visitor consent through Cookie-Script.
- Help meet GDPR / ePrivacy / cookie-law obligations.
- Disclose the third-party consent service in your privacy policy.
- Restrict who can change the ID via the module's admin permission.
- Change the ID quickly when rotating Cookie-Script accounts or domains.
- Turn the banner off site-wide by uninstalling or clearing the ID.
- Verify that gated scripts actually respect the recorded consent.
- Pair with analytics/tag-manager modules that honour consent state.
- Confirm the banner renders correctly against your active theme.
- Test consent behaviour on a staging site before production.
- Review the configuration after Drupal or theme upgrades.
- Keep a single, consistent consent experience across all pages.
