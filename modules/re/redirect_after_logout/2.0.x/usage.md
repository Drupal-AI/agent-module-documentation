Redirect After Logout sends a user to a configured URL after they log out, optionally showing a one-time message. The destination and message are set once by an administrator and applied to any user holding the `redirect user after logout` permission.

---

The module has a single admin settings form at `admin/config/system/redirect_after_logout` (route `redirect_after_logout.settings`, gated by core `administer site configuration`) storing three keys in `redirect_after_logout.settings`: `destination`, `message`, and `message_type`. On logout, `hook_user_logout()` runs the destination through the token service and stashes it in a `drupal_static`, but only for accounts with the `redirect user after logout` permission (and it bails out early during a Masquerade session so unmasquerading is not hijacked). A response-event subscriber (`RedirectAfterLogoutSubscriber::checkRedirection`) then rewrites the logout `RedirectResponse` to the stored destination, resolving `<front>`, external URIs, and internal paths via `Url`. The destination accepts `<front>`, internal paths (leading slash), fully external URLs (redirecting off-site is a supported feature), and tokens such as `[current-page:url]`; the settings form validates it with `PathValidator`/`UrlHelper` and strips dangerous protocols. If a message is set and the target is local, the redirect gets a `logout-message=1` query flag; a request subscriber (`showMessage`) then renders that message (token-replaced, `Xss::filter` allowing only `<br>`) to the now-anonymous visitor. `message_type` maps to a Drupal messenger type (status/warning/error). Token help appears on the form when the Token module is enabled; Masquerade and Token are soft (dev) dependencies. There is no Drush command and no plugin system.

---

- Redirect users to the front page after they log out.
- Redirect users to a custom internal page (e.g. `/goodbye`) after logout.
- Redirect users to an external site (e.g. a corporate portal) after logout.
- Show a "You have been logged out" confirmation message after logout.
- Style the logout message as a status, warning, or error notice.
- Use a token such as `[current-page:url]` to build a dynamic logout destination.
- Limit the redirect to specific roles by granting them the `redirect user after logout` permission.
- Keep the redirect from firing for editors/admins by not granting them the permission.
- Preserve normal Masquerade unmasquerade flow (the redirect is skipped during masquerade).
- Send authenticated staff to an intranet login page after logging out of the public site.
- Provide a marketing/thank-you landing page after account logout.
- Redirect to a survey or feedback form on logout.
- Route logged-out users to a paywall or membership-signup page.
- Localize the logout message with tokens (e.g. site name).
- Give multiple roles different treatment by combining this permission with role assignment.
- Add a multi-line logout message (newlines are converted to `<br>`).
- Redirect to a documented "session ended" page for compliance.
- Point logout at a SSO/IdP logout endpoint URL.
- Configure a per-site default logout destination through config (`redirect_after_logout.settings`).
- Override the logout destination per environment via `settings.php` config overrides.
- Ensure the redirect only applies to real logouts, not admin masquerade sessions.
