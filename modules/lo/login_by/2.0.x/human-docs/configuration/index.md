# Configuration

Login By has a single settings form where you pick the login identifier and switch
on a handful of login‑form conveniences.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → User interface → Login By**, or navigate directly to
   `/admin/config/user-interface/login_by`.

## The accepted login identifier

This is the main choice. Set whether the login form accepts:

- **Username** — the standard Drupal behaviour.
- **Email** — users sign in with their email address instead of their username.
- **Both** — either a username or an email address is accepted.

> **If you allow email login**, make sure your site enforces **unique** email
> addresses and handles them consistently (for example, case handling), so that
> each login resolves unambiguously to a single account. Login By adds no
> authentication bypass — it only widens what the identifier box accepts.

## Login‑form options

The same form offers several presentation and convenience toggles:

- **Enable placeholder** — show placeholder text inside the login fields.
- **Enable autocomplete off** — disable the browser's autocomplete on the login
  fields.
- **Enable view password** — add a "show password" control so users can reveal
  what they've typed.
- **Enable login page** — provide a dedicated login page.
- **Login page title** — change the heading shown on the login page.
- **Login button label** — change the text on the submit button.

## Save

Click **Save configuration**. The changes apply to the login form immediately —
reload the login page (or open it in a private window) to confirm the identifier
and options behave as you set them.
