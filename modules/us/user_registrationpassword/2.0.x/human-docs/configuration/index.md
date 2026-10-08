# Configuration

User Registration Password does not add its own settings page — it extends
Drupal's **Account settings** form.

## Open the settings form

1. Log in as an administrator.
2. Go to **Configuration → People → Account settings**, or navigate directly to
   `/admin/config/people/accounts`.

The module's options sit among core's registration settings, so configure both
together. In particular the "with password on the form" behavior only fully takes
over when core's **Who can register accounts?** is set to allow visitors to
create accounts.

## The registration mode

The core "email verification" choice is expanded into three modes:

- **No verification** (`none`) — no verification email is sent. The user sets a
  password on the registration form and can log in straight away. (This turns off
  core's "require email verification".)
- **Verify first, set password later** (`default`) — the classic Drupal flow: a
  verification email goes out and the password is set afterwards.
- **Verify, password on the form** (`with-pass`) — the default and the reason to
  use this module. A verification email is still required, but the user picks
  their password during registration; the module then blocks the new account,
  sends its own activation email, and that email both confirms the account and
  logs the user in with the password they chose.

## Activation link expiry

Two settings control how long the activation ("first time login") link is valid:

- **Expire the activation link** — off by default. When off, the link does not
  time out.
- **Activation link lifetime** — how long, in seconds, the link stays valid once
  expiry is turned on. The default is `86400` (24 hours).

If a link expires, the user can request a fresh activation email from the normal
password-reset form — the module handles that automatically for accounts that have
never logged in.

## Post-confirmation redirect

- **Redirect after confirmation** — an optional internal path (leading `/`) to
  send the user to once they confirm their account. It may include user tokens,
  for example `/user/[user:uid]/edit`. Leave it blank for the default landing
  behavior.

## The activation email

The form includes a **"Welcome (no approval required, password is set)"** email
template with a **Subject** and **Body**. This is the message the module sends in
the `with-pass` flow. Keep the `[user:registrationpassword-url]` token somewhere
in the body — that is what builds the one-time confirmation link the user clicks.
On a multilingual site the email can be translated per language through Config
Translation.

## Save

Click **Save configuration**. A custom submit handler keeps core's user settings
in sync with the mode you picked, so you do not need to adjust core's verification
checkbox separately.

## Headless registration (optional)

The module also ships a REST resource at **`/user/registerpass`** that accepts
posted registrations following the same password-on-registration and
activation-email flow. Enable it like any REST resource (for example with the REST
UI module) if you register users from a decoupled front end.
