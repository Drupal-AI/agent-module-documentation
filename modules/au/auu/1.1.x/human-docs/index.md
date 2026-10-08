# Auto unblock users — manual setup guide

**Auto unblock users** (`auu`) is a small add‑on for the
[Login Security](https://www.drupal.org/project/login_security) module. Login
Security protects accounts against brute‑force attacks by temporarily blocking a
user after too many failed login attempts. Normally an administrator has to step
in and unblock those accounts by hand. Auto unblock users removes that chore: once
the block window Login Security enforces has elapsed, the affected account is
re‑enabled **automatically**.

The point is to keep brute‑force protection without the support burden of
permanent lockouts. Legitimate users who fat‑finger their password a few times get
freed on their own after the cooldown, instead of filing a ticket and waiting for
an admin.

The module is deliberately tiny. It has no pages, routes, or permissions of its
own — instead it **adds a few extra fields to Login Security's own settings form**,
so everything you configure lives in one place. You can optionally show a message
to the user at the moment their account is unblocked.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (Login Security is required).
2. [Configuration](configuration/index.md) — the fields it adds to the Login
   Security settings form.

## Where it lives in the admin menu

Auto unblock users does not add its own menu item. Its options appear as extra
fields on the **Login Security settings** form (`login_security.settings`) — the
same place you configure Login Security's block thresholds.
