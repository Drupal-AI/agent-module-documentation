# Working with pwd_reset

`pwd_reset` (project `passwordpolicy`, version 2.0.x, core `^8 || ^9 || ^10`) is a small
form-alter-only module that customizes the core password-reset landing page.

What it does (all in `pwd_reset.module`, no src/, no routes, no config, no permissions):

- `pwd_reset_form_alter()` — only on `user_form` at path `/user/reset/...`: retitles the page to
  "Reset password", appends static password-guideline HTML under the password field, relabels the
  submit button to "Login", and registers custom validate/submit handlers.
- `pwd_reset_validation()` — enforces the regex
  `^\S*(?=\S{8,})(?=\S*[\W])(?=\S*[a-z])(?=\S*[A-Z])(?=\S*[\d])\S*$` (8+ chars, lower, upper, digit,
  punctuation) and sets a form error on `pass` if unmet.
- `pwd_reset_submit()` — after a successful reset: `user_logout()`, clears messages, and redirects to
  `user.login`.
- `pwd_reset_module_implements_alter()` — reorders its own `form_alter` to run last.

Security: no findings. Behaviour is a client-facing form alter with a server-side validation regex;
there are no routes, no user-controlled sinks, no external calls, and no access-control surface.

To adjust the guidelines or complexity rule, edit `pwd_reset.module` (there are no settings). For
configurable, role-aware policies prefer the maintained `password_policy` module instead.
