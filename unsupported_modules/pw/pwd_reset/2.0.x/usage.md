# pwd_reset (Custom Password Reset)

`pwd_reset` is the single module shipped by the legacy `passwordpolicy` project. It tailors the
behaviour of Drupal core's one-time-login password-reset landing page (`/user/reset/...` → the
`user_form`).

- Use it when you want the password-reset page to show explicit password guidelines and to enforce a
  fixed complexity rule without configuring the full Password Policy module.
- It targets only the reset flow (the `user_form` shown at `/user/reset/{uid}/{timestamp}/{hash}`),
  not the normal profile-edit form.
- It relabels the page title to "Reset password" and the submit button to "Login".
- After a successful reset it logs the user out and redirects to the login form.
- Core version requirement is `^8 || ^9 || ^10` (no Drupal 11 release — documented from the D10 site).

---

- Install by placing the `passwordpolicy` project in `modules/contrib` and enabling its `pwd_reset`
  submodule: `drush en pwd_reset`.
- There is nothing to configure — behaviour is hard-coded in `pwd_reset.module`.
- The module has no configuration UI, no routes, no permissions, and no dependencies.
- `hook_module_implements_alter()` moves this module's `form_alter` to run last, so its changes apply
  after other modules have altered the same form.
- To change the guideline text or the rule, edit `pwd_reset.module` (there are no settings).

---

- The complexity rule is the regex `^\S*(?=\S{8,})(?=\S*[\W])(?=\S*[a-z])(?=\S*[A-Z])(?=\S*[\d])\S*$`.
- It requires at least 8 non-whitespace characters.
- It requires at least one lowercase letter.
- It requires at least one uppercase letter.
- It requires at least one digit.
- It requires at least one non-word (punctuation) character.
- `pwd_reset_form_alter()` fires only when `$form_id == 'user_form'` AND the current path is
  `/user/reset/...` (it inspects `path.current` split on `/`).
- It appends the guideline markup as a `#suffix` on the `account.pass` password field.
- It adds custom `#validate` (`pwd_reset_validation`) and `#submit` (`pwd_reset_submit`) handlers to
  the form.
- `pwd_reset_validation()` reads the submitted `pass` value and, if non-empty, calls
  `$form_state->setErrorByName('pass', ...)` when the value fails the complexity regex.
- `pwd_reset_submit()` runs `user_logout()`, clears all status messages with `deleteAll()`, adds a
  success message, and redirects to the `user.login` route.
- The guideline copy is a static HTML list: make it 8+ chars; add lowercase, uppercase, numbers, and
  punctuation; avoid the username, dates, common words, or common sequences.
- This validation runs in addition to core's own password constraints — it does not replace them, so
  the effective rule is the stricter of the two.
- The module changes only the reset landing page; password changes made elsewhere (an admin editing
  another user, or registration) are unaffected.
- There are no external service calls, no database writes of its own, and no user-controlled sinks.
- Security review: no findings — a client-facing form alter plus a server-side validation regex, with
  no routes, access-control surface, or injection sinks.
- For configurable, role-aware password policies, prefer the maintained `password_policy` module.
