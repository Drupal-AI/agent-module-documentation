# Ajax Login Popup — manual setup guide

**Ajax Login Popup** (`ajax_login_popup`) shows Drupal's core user login form in
an AJAX modal dialog instead of sending visitors to the full `/user/login` page.
Clicking a login link opens the form in a popup, and after a successful login the
visitor is redirected to a destination you configure.

It is a login/theming enhancement built directly on top of core. The modal
extends core's `UserLoginForm`, so authentication still goes through core's
`user.auth` service and flood (brute-force) protection — the module adds no
custom password handling and no authentication bypass. The login route is served
only to anonymous (logged-out) visitors.

The one thing you configure is the **post-login redirection** — where a user
lands after signing in — on the module's settings form, which is protected by the
*Administer site configuration* permission.

This guide is written for a **human** setting the module up through the admin
UI. If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — set where users are redirected
   after they log in.

## Where it lives in the admin menu

The settings form is at `/admin/config/ajax_login_popup/setting` and requires
the **Administer site configuration** permission. See
[Configuration](configuration/index.md) for what it controls.
