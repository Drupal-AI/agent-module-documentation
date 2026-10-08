# Shared Email — manual setup guide

**Shared Email** (`sharedemail`) lets the same email address be used on more than one
Drupal user account. Normally Drupal enforces one account per email address; this
module relaxes that rule in a controlled way — only for users you trust, and
optionally only for specific addresses — so that, for example, several staff members
can register accounts against one departmental inbox, or a family can share a single
address across memberships.

It works by replacing core's email-uniqueness check on the user `mail` field with its
own version. The replacement check allows a duplicate address **only when both** of
these are true: the person creating or editing the account has the **Create shared
email account** permission, **and** the address is on a configured allowlist (or the
allowlist is left empty, meaning any address may be shared). Everyone else still gets
the normal "email already taken" error, so self-registration stays locked down while
admins can create shared accounts. There is also an optional warning message shown
after saving a duplicate address, so users know that things like password-reset emails
will go to a shared mailbox.

The module changes behaviour the moment you enable it — it always swaps the email
constraint — but *who* can share and *which* addresses they can share is controlled by
one permission plus a small settings form. It depends only on core's **User** module,
adds three permissions, and has no Drush commands or submodules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the allowlist, the warning message, and
   the three permissions.

## Where it lives in the admin menu

The settings form is at **Configuration → People → Shared Email**
(`/admin/config/people/shared-email`), guarded by the **Administer shared email**
permission.
