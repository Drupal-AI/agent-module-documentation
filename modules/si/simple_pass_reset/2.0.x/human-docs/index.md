# Simple Password Reset — manual setup guide

**Simple Password Reset** (`simple_pass_reset`) removes a confusing step from
Drupal's built-in password-reset flow. Normally, when a user clicks the one-time
login link in a reset email, they land on an intermediate page with a "Log in"
button, and only *after* clicking it do they reach a form to set a new password.
Many users find that extra step baffling. This module rewrites the flow so the reset
link takes the user straight to a **Choose a new password** form, and submitting it
both saves the password and logs them in.

Everything happens on Drupal's existing `user.reset` route — the module simply
overrides what that route shows. It keeps all of core's security checks (link expiry,
hash validation, active-user checks), strips the reset page down to just the password
field, makes that field required, and relabels the button to **Save and log in**.

The module has exactly **one setting**: where to send the user after they reset their
password and are logged in. By default that's their own profile page (`/user`), but
you can point it anywhere internal — a dashboard, the front page, and so on.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the single post-reset redirect setting.

## Where it lives in the admin menu

Once enabled, the new flow is active immediately — there is nothing you *must*
configure. Its one settings field sits at **Configuration → People → Account
settings → Simple Password Reset**
(`/admin/config/people/accounts/simple_pass_reset`), behind the **Administer simple
pass reset** permission.

## How to use it

There is nothing for editors or users to do — the improved reset experience simply
happens. When someone requests a new password and clicks the link in the email, they
now see a single "Choose a new password" form, enter a password, click **Save and log
in**, and they are signed in and sent to the page you configured. If you use the
[Guardian](https://www.drupal.org/project/guardian) module, guarded accounts keep the
standard Drupal reset flow untouched.
