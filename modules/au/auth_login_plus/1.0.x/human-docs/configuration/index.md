# Configuration

Authenticator Login Plus has one settings form plus a set of user-facing and
admin-facing flows. This page walks through each.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → People → Authenticator Login Plus**, or navigate directly
   to `/admin/config/people/auth_login_plus/settings`.

### What the settings control

| Setting | What it does |
|---------|--------------|
| **Enabled** | Master switch that turns 2FA on for login. |
| **Enforce redirect** | Forces users to complete 2FA enrollment on protected/admin routes — they cannot skip setup. |
| **Allow email reset** | Lets users reset their authenticator through a self-service emailed link. |
| **Post-verification redirect** | Where the user lands after a successful challenge — the front page, their original destination, or their user page. |
| **Issuer** | The issuer name shown next to the account inside the authenticator app. |
| **Setup UI enabled** | Whether the self-service setup UI is available to users. |
| **Redirect message** | The message shown when a user is redirected to complete enrollment. |

Click **Save configuration** when done.

## Permissions

Set these at **People → Permissions** (`/admin/people/permissions`). Both are marked
as security-sensitive:

- **`manage user 2fa`** — lets helpdesk/admin staff view 2FA status and reset, disable,
  or enable another user's 2FA from the admin overview. Grant this to trusted support
  roles.
- **`auth_login_plus bypass enforced redirect`** — lets selected roles skip the
  enforced-enrollment redirect. Grant sparingly.

## The user login flow

1. The user signs in with username and password as usual.
2. Instead of finalizing the session, the module diverts them to the **OTP challenge**
   at `/2fa/login` (or to enrollment at `/user/{user}/2fa-plus` if they have not set up
   2FA yet). No Drupal session exists yet at this point.
3. The user enters the six-digit code from their authenticator app (or a backup code).
4. On success the session is finalized and they are sent to the configured
   post-verification destination.

## Enrolling a user

Enrollment happens at `/user/{user}/2fa-plus`:

1. The user scans the displayed **QR code** with an authenticator app.
2. They confirm a code to prove the app is set up correctly.
3. The secret is stored **encrypted**, and the user is issued a set of one-time
   **backup codes** to keep somewhere safe for when their device is unavailable.

Users can regenerate a fresh set of backup codes later, and — depending on settings —
disable 2FA without discarding the stored secret, or re-enable it using the existing
secret.

## Admin / helpdesk management

Users with **`manage user 2fa`** can go to **People → Authenticator Login Plus**
(`/admin/people/auth_login_plus`) to see every account's 2FA status and run
**reset**, **disable**, or **enable** on an account through a confirmation form. This
is the tool for helping a user who has lost their device.

## Self-service reset

If **Allow email reset** is on, a user can request a reset at `/2fa/reset`. The module
emails them a link to `/2fa/reset/confirm/{uid}/{token}`. That token is **single-use,
hashed, and expires after one hour** — a safe, core-style one-time link.

## REST / JSON login

For sites that log in over REST, the login controller requires an **`mfa_token`** in
the credentials body for any 2FA-enabled account, so API logins are held to the same
2FA requirement as the browser flow.

## Drush

The module ships Drush commands for managing enrollment, useful for scripted or
bulk 2FA administration.

## Theming

The 2FA setup and challenge pages can be themed to match your site.
