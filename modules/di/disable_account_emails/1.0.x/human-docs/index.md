# Disable Account Emails — manual setup guide

**Disable Account Emails** (`disable_account_emails`) gives site administrators
fine-grained control over which of the automated user-account emails Drupal sends.
Core sends a mail for each account event — a welcome message, an account-activated
notice, a blocked or cancelled notification, a password-recovery link, an
email-change confirmation, and so on — and this lightweight module lets you switch
off the specific ones you don't want while leaving the rest active.

It works by adding a **"Disable Account Emails"** fieldset to the standard user
account settings page, giving you a checkbox for each of the nine account email
types. When an account email is about to be sent, the module checks it against your
choices and quietly prevents delivery of the ones you have disabled. Nothing else
about your mail setup changes, and uninstalling the module cleanly removes its
configuration.

There is a real safety caveat to understand before you use it. **Some account
emails are security-relevant.** The password-recovery email is how a locked-out
user regains access, and the account-activation and email-change confirmation
emails are part of verifying a person's identity and their changes. Disabling those
can lock users out of recovery, or silently allow an email change with no
confirmation step. Only turn off genuine notification-style mails you truly don't
need — for example the "welcome" message on a site where admins create every
account — and **keep the password-recovery and verification emails enabled** unless
you have a deliberate alternative in place. The module plays no access-control role;
it only suppresses mail.

It requires Drupal 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — the account-email checkboxes, and
   which ones you should never disable.

## Where it lives in the admin menu

The module does not add a page of its own. Its checkboxes appear on the core
**Configuration → People → Account settings** page
(`/admin/config/people/accounts`), inside a **Disable Account Emails** fieldset near
the email settings.
