CookieCuttr displays an EU "cookie law" consent notice/banner on every page by feeding Drupal-configured options into the bundled CookieCuttr jQuery plugin.

---

CookieCuttr is a thin Drupal integration for the client-side CookieCuttr jQuery plugin (originally cookiecuttr.com / github.com/cdwharton/cookieCuttr). On every page render it attaches its own asset library and pushes a single admin-managed settings object into `drupalSettings.cookieCuttr`; a small behavior then calls `$.cookieCuttr(...)` which injects a cookie-consent bar (or a discreet corner link, or a full-page overlay) into the document body. Site builders control all wording, buttons, and behavior from one settings form at `/admin/config/user-interface/cookiecuttr` (permission `administer cookiecuttr`), whose values persist in the `cookiecuttr.settings` config object. The plugin remembers the visitor's accept/decline choice in first-party cookies (`cc_cookie_accept` / `cc_cookie_decline`, via the js-cookie library from the required `js_cookie` module) and can optionally hide named page elements, blank Google Analytics `__utm*` cookies on decline, or show a dedicated message on a policy page. It ships no entities, plugin types, blocks, or Drush commands — just the config form, config schema/defaults, a permission, an admin menu link, and the JS/CSS assets. Everything the banner shows comes from site configuration, not from visitor input.

---

- Show a site-wide EU cookie-consent banner on every page without writing any JavaScript.
- Comply with the EU ePrivacy / "cookie law" by informing visitors and capturing an accept/decline choice.
- Edit the cookie-bar message and keep a `{{cookiePolicyLink}}` token that expands to your privacy-policy URL.
- Point the policy link at any internal path or external URL (`policy_link`, default `/privacy-policy/`).
- Run in simple "analytics" mode (default): show a short "we only track visits" message with no policy link.
- Add an Accept button (default on) and customize its label (`accept_button_text`, default "ACCEPT COOKIES").
- Add a Decline button that writes an opt-out cookie, with custom label (`decline_button_text`).
- Add a Reset button so visitors can clear their prior accept/decline choice (`reset_button_text`).
- Blank Google Analytics `__utma/__utmb/__utmc/__utmz` cookies when a visitor declines, by setting `domain` to your bare domain.
- Move the notification bar to the bottom of the page (`notification_location_bottom`) instead of the top.
- Render the notice as a full 100%-height overlay instead of a discreet toolbar (`overlay_enabled`).
- Show a discreet corner link ("Cookies?") in one of four positions — topleft/topright/bottomleft/bottomright (`discreet_link`, `discreet_position`).
- Display a dedicated consent message and buttons on a cookie/privacy policy page (`policy_page`, `policy_page_message`).
- Actively disable named page elements (comment widgets, embeds, etc.) until consent is given, replacing them with a warning (`CookieCutter` + `disable` selector list, plus `error_message`).
- Provide a "What are cookies?" help link and customize its text and target (`what_are_they_link`, `what_are_link_text`).
- Delegate banner administration to a specific role via the `administer cookiecuttr` permission.
- Manage all wording in one place so translations/legal copy stay consistent across the site.
- Export/import the whole banner configuration with Drupal's standard configuration management (single `cookiecuttr.settings` object).
- Set the accept/decline cookie lifetime behavior through the bundled plugin defaults (365-day expiry).
- Deploy a lightweight, dependency-light consent solution (no third-party SaaS) as an alternative to EU Cookie Compliance or Cookie Control.
- Keep the banner sticky at the top on mobile/iOS where bottom positioning is not reliable.
