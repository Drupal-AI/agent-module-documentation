# Configuration

Ajax Login Popup has a single settings form, and it controls one thing: where a
visitor is redirected after they log in through the modal.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to `/admin/config/ajax_login_popup/setting`.

## Post-login redirection

Set the destination a user should land on after a successful login through the
popup. Save the form and the redirection takes effect for subsequent logins.

## What you do *not* configure here

Authentication itself is handled by Drupal core, not by this module. The modal
extends core's `UserLoginForm`, so passwords are checked by core's `user.auth`
service and core's flood (brute-force) protection still applies. The login route
is exposed only to anonymous visitors — a logged-in user cannot reach it — and
the module sets the user's session only after core confirms the password. There
is no custom credential handling to configure, and nothing here weakens core's
login security.
