# Configuration — the settings form

Automated Logout is configured entirely on one form. This page walks through
each field: turning the feature on, setting how long a session may sit idle,
how much warning the user gets, where they land after logout, and whether the
timeout applies to administrative pages. It closes with how to vary the timeout
per role or exempt certain roles entirely.

## Open the settings form

1. Go to **Configuration → People → Automated logout**
   (`/admin/config/people/autologout`).
2. You will land on the **Automated logout settings** tab.

![The Automated logout settings form](../images/settings.png)

## Turn autologout on and set the timeout

1. Tick **Enable autologout** to switch the feature on for the whole site.
2. In **Timeout value in seconds**, enter the inactivity time — in seconds —
   allowed before a user is automatically logged out. The value **must be 60
   seconds or greater**. For example, `1800` is 30 minutes. Note that this
   global value is *not* used if a per-role timeout applies to the user (see
   [Vary the timeout per role](#vary-the-timeout-per-role-or-exempt-a-role)
   below).
3. **Max timeout setting** caps how high a value users may choose if you let
   them set their own timeout. It is the maximum logout threshold a user with
   the "change own logout threshold" permission is allowed to enter.

## Give users time to respond: Timeout padding

**Timeout padding** is how many seconds a user is given to respond to the
warning dialog before their session actually ends. When the inactivity timer
runs out, the module shows a countdown dialog; the padding is the extra window
in which the user can click **Yes** to stay logged in. The screenshot uses `20`
seconds.

## Choose where users go after logout

1. In **Redirect URL at logout**, enter the internal path to send users to once
   they have been logged out — commonly `/user/login` so they land back on the
   sign-in page, or a custom notice page.
2. Tick **Include destination** if you want the page the user was on to be
   appended to the redirect, so that after logging back in they return to where
   they left off.

## Apply autologout on administrative pages

By default the inactivity timer does not run on admin pages. Enable the
**Enforce autologout on admin pages** option if you want administrators to be
logged out for inactivity while working in the admin area too — important on
sensitive sites where the admin screens are exactly what you want protected.

## Set the warning message and countdown

When a session is about to expire, the module shows a modal **warning dialog**
with a live countdown and Yes/No buttons. You can customise the message text
shown in that dialog, and the message a user sees after they have been logged
out due to inactivity, so the wording matches your site's tone and any
compliance requirements.

## Vary the timeout per role, or exempt a role

A single global timeout does not fit every site. Automated Logout lets you tune
it per role instead:

- **Role timeout** — enable per-role timeouts so each role can have its own
  inactivity threshold (for example, a short timeout for editors and a longer
  one for administrators). When a user belongs to more than one role, you can
  choose whether the **highest** or the **lowest** matching role value applies.
  A role given a timeout of `0` is never logged out, which is how you **exempt**
  a role from autologout entirely.
- **Per-user thresholds** — grant the **Change own logout threshold** permission
  to let trusted users set their own inactivity timeout (bounded by the *Max
  timeout setting* above). To forbid this and keep timeouts strictly global,
  enable **Disable user-specific logout thresholds**.

Set these role and user permissions on the standard **People → Permissions**
screen (`/admin/people/permissions`): grant **Administer autologout** to the
roles that should manage this form, and **Change own logout threshold** to any
role you want to let choose their own timeout.

## Save

Click **Save configuration** at the bottom of the form. Your changes take effect
for sessions from that point on.
