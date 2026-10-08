# Generate Password — manual setup guide

**Generate Password** (`genpass`) makes the password field optional or hidden on
Drupal's "Add user" and registration forms, and generates a strong random password
whenever one isn't supplied. It can optionally display that generated password
once, at creation time, to the admin, the new user, both, or nobody. This is handy
for provisioning accounts in bulk, letting visitors register without inventing a
password, and meeting PCI DSS requirement 8.2.6 for system‑generated first‑use
passwords.

Under the hood, Genpass replaces Drupal core's password generator with a stronger
one that draws from four character classes — lowercase, uppercase, digits, and an
expanded special‑character set — and guarantees at least one character from each,
at a length you choose (5–32, default 12). It deliberately omits confusable
characters like `0`/`O` and `1`/`I`/`l`. You can keep this stronger generator or
fall back to core's while still controlling the length.

All of its settings live on the core **Account settings** form, where Genpass adds
three areas: how users may (or must, or can't) enter a password at registration,
whether admins may set passwords when creating accounts, and whether/who the
generated password is shown to. A validation guard interlocks these with core's
"Require email verification" setting so you can't save an impossible combination.
Genpass also adds a **Set new random password** bulk action on the People page for
resetting one or many users at once. It requires only core's User module and ships
an optional submodule, `genpass_batch`.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and note the optional submodule.
2. [Configuration](configuration/index.md) — the settings on the Account settings
   form, field by field, plus the bulk action.

## Where it lives in the admin menu

Genpass has no page of its own. Its settings are added to the core **Account
settings** form at **Configuration → People → Account settings**
(`/admin/config/people/accounts`).

## How to use it

Enable the module, then open **Configuration → People → Account settings** and set
the registration behavior, generation length, and display options. See
[Configuration](configuration/index.md) for the details.
