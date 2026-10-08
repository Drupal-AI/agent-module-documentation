<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CookieCuttr — configuration & settings

## Install / enable
- Requires the `js_cookie` module (declared `dependencies: js_cookie:js_cookie` in `cookiecuttr.info.yml`) for the `js-cookie` library.
- Enable `cookiecuttr`; default config is imported from `config/install/cookiecuttr.settings.yml`.
- Configure at **`/admin/config/user-interface/cookiecuttr`** (Administration › Configuration › User interface › CookieCuttr). Menu link `cookiecuttr.settings` under `system.admin_config_ui`.

## Route & permission
- Route `cookiecuttr.settings` (`cookiecuttr.routing.yml`): `_form: \Drupal\cookiecuttr\Form\CookieCuttrForm`, `_permission: 'administer cookiecuttr'`, `options: {_admin_route: TRUE, _access_mode: ANY}`.
- Only permission: **`administer cookiecuttr`** (`cookiecuttr.permissions.yml`).
- The form is a standard `ConfigFormBase` POST form (core CSRF token applies); there are no other routes, no GET mutations, no callbacks.

## How it reaches the page
- `Drupal\cookiecuttr\Hook\CookiecuttrHooks::pageAttachmentsAlter()` (`#[Hook('page_attachments_alter')]`, service autowired in `cookiecuttr.services.yml`; legacy shim `cookiecuttr_page_attachments_alter()`):
  - `$page['#attached']['library'][] = 'cookiecuttr/cookiecuttr';`
  - `$page['#attached']['drupalSettings'] = cookiecuttr_settings();`
- `cookiecuttr_settings()` (`cookiecuttr.module`) reads the whole `cookiecuttr.settings` config and, for each entry in its map, copies it into `settings['cookieCuttr'][<pluginOption>]`. It only copies keys that are `isset()`.
- Glue `js/cookiecuttr.js` (behavior `Drupal.behaviors.cookiePolicy`) runs `$.cookieCuttr(drupalSettings.cookieCuttr)`; the bundled `js/jquery.cookiecuttr.js` builds the banner and manages the choice cookies.
- Applies to **every** page — no route/path/role targeting in the module.

## Config keys (`cookiecuttr.settings`)
Schema `config/schema/cookiecuttr.schema.yml` (`type: config_object`). Form field → config key → jQuery option (`cookieCuttr_settings()` map). Defaults from `config/install`.

| Config key | Type | Default | jQuery option | Purpose |
|---|---|---|---|---|
| `message` | text | "We use cookies … read about them here …" | `cookieMessage` | Main bar message; keep `{{cookiePolicyLink}}` token (expanded client-side to the policy link). |
| `analytics` | boolean | `true` | `cookieAnalytics` | Simple analytics mode (short message, no policy link). |
| `analytics_message` | text | "We use cookies, just to track visits…" | `cookieAnalyticsMessage` | Text shown in analytics mode. |
| `accept_button` | boolean | `true` | `cookieAcceptButton` | Show Accept button. |
| `accept_button_text` | text | "ACCEPT COOKIES" | `cookieAcceptButtonText` | Accept label. |
| `decline_button` | boolean | `false` | `cookieDeclineButton` | Show Decline button (writes opt-out cookie). |
| `decline_button_text` | text | "DECLINE COOKIES" | `cookieDeclineButtonText` | Decline label. |
| `reset_button` | boolean | `false` | `cookieResetButton` | Show Reset button (clears prior choice). |
| `reset_button_text` | text | "RESET COOKIES FOR THIS WEBSITE" | `cookieResetButtonText` | Reset label. |
| `overlay_enabled` | boolean | `false` | `cookieOverlayEnabled` | Full 100%-height overlay instead of a bar. |
| `policy_link` | uri | `/privacy-policy/` | `cookiePolicyLink` | Privacy-policy target for the `{{cookiePolicyLink}}` token. |
| `what_are_they_link` | uri | `http://www.allaboutcookies.org/` | `cookieWhatAreTheyLink` | "What are cookies?" link target. |
| `what_are_link_text` | text | "What are cookies?" | `cookieWhatAreLinkText` | "What are cookies?" link text. |
| `error_message` | text | "We're sorry, this feature places cookies…" | `cookieErrorMessage` | Replacement notice for hidden elements. |
| `notification_location_bottom` | boolean | `false` | `cookieNotificationLocationBottom` | Anchor the bar to the bottom. |
| `CookieCutter` | boolean | `false` | `cookieCutter` (`hide_parts` slot in map) | Actively hide/disable named elements until consent. |
| `hide_parts` | text | "" | `cookieCutter` | (Form "Hide elements" textfield.) |
| `disable` | text | "" | `cookieDisable` | Comma/selector list of elements to blank when `CookieCutter` is on. |
| `policy_page` | boolean | `false` | `cookiePolicyPage` | Show a dedicated message on the policy page. |
| `policy_page_message` | text | "Please read the information below…" | `cookiePolicyPageMessage` | Policy-page message. |
| `discreet_link` | boolean | `false` | `cookieDiscreetLink` | Show a discreet corner link instead of a bar. |
| `discreet_link_text` | text | "Cookies?" | `cookieDiscreetLinkText` | Discreet link text. |
| `discreet_position` | text | "topleft" | `cookieDiscreetPosition` | topleft / topright / bottomleft / bottomright. |
| `domain` | text | "" | `cookieDomain` | Bare domain; when set, GA `__utm*` cookies are blanked on decline. |

Notes:
- The form maps its "Hide elements" textfield to `hide_parts` but the disable feature is actually driven by the `CookieCutter` boolean + `disable` selector list; `hide_parts`/`CookieCutter` share the `cookieCutter` plugin option in `cookiecuttr_settings()`.
- `submitForm()` in `CookieCuttrForm` persists all keys except it does not re-save `discreet_link` / `overlay`-only artifacts beyond those listed; unlisted keys keep their config-install defaults.

## Client-side state
- Bundled plugin `jquery.cookiecuttr.js` stores the visitor decision in first-party cookies `cc_cookie_accept` / `cc_cookie_decline` (365-day expiry, `path=/`) via the `js-cookie` `Cookies` API.
- Accept/decline/reset click handlers `preventDefault()` and then `location.reload()`.
- When `domain` is set and the visitor declines, the plugin blanks `__utma`, `__utmb`, `__utmc`, `__utmz` on `.<domain>`.
