# Login By — manual setup guide

**Login By** (`login_by`) lets you decide which identifier the login form accepts:
**username**, **email address**, or **either one**. Out of the box Drupal expects
a username; many sites would rather let people sign in with the email they already
remember. Login By makes that a configuration choice rather than a code change,
and it adds a few related login‑form conveniences on the same settings page.

Alongside the identifier choice, the settings form offers small quality‑of‑life
options: showing placeholder text in the fields, turning off browser
autocomplete, adding a "show password" toggle, and enabling a dedicated login
page. You can also change the login page title and the text on the login button.

Login By layers on top of Drupal's normal authentication — it changes *what you
can type in the identifier box*, not how authentication is enforced, and it adds no
bypass. One thing to keep in mind if you enable email login: it relies on email
addresses being **unique** and matched consistently, so make sure your site
enforces unique emails and handles them predictably (for example, consistent case
handling) so that a login always resolves to exactly one account.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — choose the accepted identifier and
   the login‑form options.

## Where it lives in the admin menu

Login By's settings form sits at **Configuration → User interface → Login By**
(`/admin/config/user-interface/login_by`). It is gated by the core **Administer
site configuration** permission.
