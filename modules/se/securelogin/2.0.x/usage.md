Secure Login forces the user login form and other configured forms to be submitted over HTTPS, and turns any HTTPS login into an HTTPS-only secure session so authenticated cookies can never travel in cleartext.

---

On a site reachable over both HTTP and HTTPS, Secure Login guarantees that sensitive forms are always POSTed to the secure base URL, preventing passwords and session cookies from being sniffed. A `hook_form_alter()` implementation flags each configured form with `#https = TRUE`; the `securelogin.manager` service (`SecureLoginManager`) then either rewrites the form `#action` to the secure base URL or 301/308-redirects the whole page to HTTPS, depending on the "Redirect form pages to secure URL" setting. Which forms are secured is chosen on the config form at `/admin/config/people/securelogin` (route `securelogin.admin`) and stored in `securelogin.settings` (`forms`, `other_forms`, `all_forms`, `secure_forms`, `base_url`). Modules advertise their forms to the checklist via `hook_securelogin_alter()`, and Secure Login ships implementations for user, node, comment, contact and webform forms. It also re-secures the user login block, redirects insecure one-time password-reset links to HTTPS (request subscriber), and applies an optional configured secure base URL through an outbound path processor for sites whose SSL certificate only covers one hostname. Developers can opt a form in with `$form['#https'] = TRUE` or force a secure URL with `$options['https'] = TRUE`, and can call the manager's `secureForm()` / `secureRedirect()` directly.

---

- Force the `user_login_form` to always submit over HTTPS to stop password interception.
- Lock down the user login block on every page, not just `/user/login`.
- Secure the user registration form so new passwords are set over HTTPS.
- Secure the password-request (`user_pass`) and password-reset (`user_pass_reset`) forms.
- Redirect insecure one-time-login (password reset) links to the HTTPS equivalent automatically.
- Enforce HTTPS-only session cookies for all authenticated users to prevent session hijacking.
- Secure node add/edit forms so editorial content is not tampered with in transit.
- Secure comment and contact forms submitted by end users.
- Secure Webform submissions by ticking the Webform option.
- Submit *all* forms on the site over HTTPS with a single "Submit all forms to secure URL" toggle.
- Add arbitrary custom form IDs (or base form IDs) to the secured list via "Other forms to secure".
- Configure an explicit secure base URL when your TLS certificate is valid for only one hostname.
- Redirect whole form pages to HTTPS (not just the action) so users visibly land on a secure URL.
- Programmatically mark a custom form as secure with `$form['#https'] = TRUE`.
- Generate an HTTPS URL from code with `$options['https'] = TRUE` on a `Url`.
- Call `\Drupal::service('securelogin.manager')->secureForm($form)` from a custom form builder.
- Call `secureRedirect()` to bounce the current request to the secure base URL.
- Advertise a contrib module's forms to the Secure Login checklist with `hook_securelogin_alter()`.
- Keep a site working behind a reverse proxy that terminates TLS by pairing with correct `$settings['reverse_proxy']`.
- Migrate Drupal 7 Secure Login / Secure Pages settings during an upgrade.
- Ensure the login flow on a mixed HTTP/HTTPS staging site stays on HTTPS.
- Complement an HSTS header (via webserver or Security Kit) so browsers only ever connect via HTTPS.
- Prevent authenticated cookies from being emitted over plain HTTP after login.
- Guarantee the 403/login redirect lands the user back on their intended destination over HTTPS.
