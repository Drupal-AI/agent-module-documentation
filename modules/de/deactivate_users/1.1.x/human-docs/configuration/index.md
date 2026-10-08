# Configuration

This is where you decide how long an account can sit idle before it's blocked, how
much grace to allow, and what your users are told. Because the module blocks real
accounts, take a moment to get these values right for your policy.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → Users → Deactivate users**.

## Inactivity Limit

The number of days an account may go without logging in before the module
considers it inactive. Set this to match your organisation's policy.

## Grace Period

A buffer added on top of the inactivity limit. Its main job is to prevent a
just-unblocked account from being blocked again on the very next cron run, but it
also shifts when blocking actually happens.

**The key formula:** an account is blocked after **Inactivity Limit + Grace
Period** days of inactivity. So if your policy requires blocking at 90 days, a
common setup is an inactivity limit of **85** and a grace period of **5**
(85 + 5 = 90).

## Email templates

The module can notify users about deactivation, and you should **personalise the
email templates for your site** rather than shipping the defaults. Because the
module depends on **Token**, you can use tokens (for the user's name, the site
name, and so on) to make the messages specific and friendly. Review the wording so
it explains what happened and how a user can regain access.

## Save — and mind your service accounts

Save the form to apply your settings. Blocking then happens automatically on cron.

> **Watch out for service and system accounts.** Automated or integration accounts
> may legitimately never "log in" the way a person does, yet you almost certainly
> don't want them blocked. Before enabling this in production, make sure such
> accounts are excluded or otherwise protected, and remember that blocking is
> reversible — an administrator can unblock any account from the people admin
> screen if something is caught unintentionally.
