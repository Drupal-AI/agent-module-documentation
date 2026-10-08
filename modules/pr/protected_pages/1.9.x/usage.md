Protected Pages lets an administrator password-protect any page or private-file path on a Drupal site with a per-path prompt that is separate from user accounts. Visitors to a protected path are redirected to a password form; entering the correct password unlocks the page for the session.

---

Protected Pages stores a list of protected paths in its own `protected_pages` database table (via the `protected_pages.storage` service), each row holding a relative path, an admin title, and a hashed password. An event subscriber runs on every response (`KernelEvents::RESPONSE`): it resolves the current request's path and alias, matches it against the stored paths (supporting `*` wildcards through the core path matcher), and — unless the user holds the `bypass pages password protection` permission — redirects to the `/protected-page` login form with the target page id and a `destination`. The login form checks the submitted password against either the per-page password, a site-wide global password, or both, depending on the `password.per_page_or_global` mode (`per_page_password`, `per_page_or_global`, or `only_global`); a successful submit records an unlock in the PHP session. A configurable session-expire time (in minutes, `0` = unlimited) controls how long the unlock lasts before the visitor is prompted again, and IP-based flood control blocks repeated wrong guesses. Admins manage everything under **Admin → Configuration → System → Protected Pages** (`/admin/config/system/protected_pages`): a list of protected pages with add/edit/delete, a settings form for password mode, global password, session length, the prompt's title/labels/messages, and an email form that mails the protected page's URL to users using `[protected-page-url]` and `[site-name]` tokens. The module requires only core `path_alias` and defines no config entity — protected pages are plain database rows, while text/password/session settings live in the `protected_pages.settings` config object.

---

- Password-protect a single node such as `/node/5` with its own password.
- Protect a marketing landing page (e.g. `/new-events`) behind a shared password.
- Protect an entire section of the site with a wildcard path like `/new-events/*`.
- Lock down the whole site by protecting `/*`.
- Set one site-wide global password that unlocks every protected page.
- Require a distinct per-page password for each protected path.
- Allow either the per-page password or the global password to unlock a page.
- Password-protect a private-file download path.
- Customize the password prompt's title, description, field label, and submit button text.
- Customize the "incorrect password" error message shown on a failed attempt.
- Set a session expiry (in minutes) so visitors must re-enter the password after a while.
- Keep an unlock valid indefinitely for a session by leaving session expire time at 0.
- Grant trusted roles the `bypass pages password protection` permission so they skip prompts.
- Email a protected page's URL to multiple recipients from the admin UI.
- Use `[protected-page-url]` and `[site-name]` tokens in the invitation email body.
- Give an admin label/title to each protected page for internal reference only.
- Edit or delete an existing protected page from the admin list.
- Throttle brute-force password guessing with built-in IP flood control.
- Restrict who can reach the password screen with the "access protected page password screen" permission.
- Restrict who can add/edit protected pages with "administer protected pages configuration".
- Protect a page by its path alias or its internal `/node/N` path interchangeably.
- Redirect visitors back to the originally requested page after they enter the correct password.
- Deploy the module's prompt text and password mode as configuration across environments.
- Preview which pages are protected via the paginated admin list of protected pages.
- Prevent duplicate protection rules — the add form rejects a path (or its alias) already protected.
