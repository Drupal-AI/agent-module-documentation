# Configuration

All of Super Login's behaviour is controlled from one settings form. The module
starts working the moment you enable it — this page is about tailoring the login,
registration, and password-reset pages to your site.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → People → Super Login Settings**, or navigate directly
   to `/admin/config/people/super_login/settings`.

Settings are stored in the exportable config object `super_login.settings`, so
your choices can be deployed with the rest of your configuration.

## Login Type — how people sign in

This is the module's key setting. It controls what a visitor may type in the
username field of the login form:

- **Username or e-mail address** *(default, value `0`)* — either works. If what
  the visitor typed matches an active account's email, Super Login quietly swaps
  in that account's username before Drupal authenticates.
- **Username only** *(value `1`)* — standard Drupal behaviour; the email lookup is
  skipped.
- **E-mail only** *(value `2`)* — visitors must sign in with their email address;
  a bare username will not be accepted.

Whichever you choose, remember to relabel the username field (below) to match — for
example "Username or e-mail address" or "E-mail address" — so the form reads
correctly.

## Text and labels

Every visible string on the login pages can be rewritten here:

- **Login field title** (`login_text`, default *Log In*) — the label on the
  username/email field of the login form.
- **Login title** (`login_title`, default *Username or e-mail address*) — a
  heading shown above the login form.
- **Forgot password text** (`forgot_pw_text`, default *Forgot password?*) — the
  anchor text of the "forgot password" link added under the form (links to the
  password-reset page).
- **New account text** (`new_account_text`, default *Create new account*) — the
  text of the "create account" link beside the login button. It only appears if
  the site actually allows visitors to register.
- **Password reset title** (`password_reset_title`, default *Password Reset*) —
  the heading above the password-reset form.
- **Back link text** (`back_link`, default *Go back to the login page.*) — the
  text of the "return to login" link added on the registration and reset pages.
- **Caps Lock message** (`capslock_msg`, default *Caps Lock is on*) — the warning
  shown while a user is typing their password with Caps Lock on.
- **Login/Password placeholders** (`login_placeholder`, `pass_placeholder`) —
  placeholder text shown inside the empty username and password fields. These are
  only applied when the **Placeholder** toggle (below) is on.
- **Login/Registration button text** (`login_button_text`, `reg_button_text`) —
  custom labels for the two submit buttons. Leave blank to keep Drupal's default
  button labels.

## Toggles

- **Caps Lock warning** (`capslock`, default *on*) — show the "Caps Lock is on"
  message while typing the password.
- **Attach CSS** (`css`, default *on*) — load the module's own stylesheet for the
  login pages. Turn this off if you would rather style the login page entirely
  from your theme.
- **Move messages** (`messages`, default *on*) — move Drupal's status/error
  messages outside the form for a cleaner layout.
- **Placeholder** (`placeholder`, default *on*) — apply the placeholder strings
  above to the username and password fields.
- **Autofocus** (`autofocus`, default *off*) — put the cursor in the username
  field automatically when the page loads, so visitors can start typing right
  away.

## Save

Click **Save configuration**. The changes apply immediately — reload `/user/login`
(or the registration or password-reset page) to see them.

## Setting values from the command line

Every option maps to a key on the `super_login.settings` object, nested under a
`super_login.` prefix. For example, to switch to email-only login or turn the
caps-lock warning off:

```bash
drush cset super_login.settings super_login.login_type 2 -y
drush cset super_login.settings super_login.capslock 0 -y
```

Read a value back with `drush cget super_login.settings super_login.login_type`.
The full key list is in the [`agent/`](../agent/start.md) docs.
