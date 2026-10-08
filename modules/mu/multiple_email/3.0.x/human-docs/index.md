# Multiple Email Addresses — manual setup guide

**Multiple Email Addresses** (`multiple_email`) lets each user attach **more than
one email address** to their account, confirm each one by clicking a link sent to
it, and then choose which confirmed address is their **primary** email. The
primary address behaves exactly like the normal account email; the extra
addresses are mostly there so that a person can consolidate their identities and
switch which one is "the" account email without an administrator's help.

Two behaviors are worth knowing up front. First, once the module is installed the
account edit page's email field no longer changes the user's email directly — in
fact the default settings **hide that field** — because email is now managed on a
dedicated tab. The module adds an **E‑mail Addresses** item to the user edit
page linking to `/user/{user}/edit/email-addresses`, where the person adds,
confirms, resends, sets‑primary, and removes addresses. Second, any address
registered to a user is **reserved**: nobody else can create a new account with
it, even while it is only a secondary address.

Under the hood each address is a small `multiple_email` entity owned by the user.
Adding an address sends a confirmation email containing a secure, randomly
generated code (built with PHP's cryptographic `Randomizer`); the user must be
logged in to confirm, and unconfirmed addresses expire after a configurable
number of days. Every add/confirm/resend/set‑primary/remove action runs on its
own access‑checked route, so users can only act on their own addresses.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the settings form (confirmation
   emails, code expiry, the account‑form email field) and the two permissions.

## Where it lives in the admin menu

The settings form sits at **Configuration → People → Multiple E‑mail Settings**
(`/admin/config/people/multiple-email`), reachable by users with the
**Administer multiple emails** permission. End users manage their own addresses
from the **E‑mail Addresses** tab on their user edit page
(`/user/{user}/edit/email-addresses`).
