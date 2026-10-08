# Designated Proxy User — manual setup guide

**Designated Proxy User** (`dpxu`) lets one trusted account create and manage a
set of other user accounts on their behalf. Think of a carer, guardian, or
coordinator who looks after several member logins — DPXU gives that person a
"user manager" role and the tools to create, edit, and support the accounts
assigned to them.

It solves a specific Drupal awkwardness: accounts created without a real email
address. Drupal allows email‑less accounts, but core and many contrib modules
misbehave without a valid address (password resets, notifications, and so on).
DPXU can generate a technically valid but undeliverable placeholder address
(`…@no-mail.invalid`) when the email field is left blank, and it can intercept
any mail sent to that placeholder and forward a cleaned copy to the designated
manager instead — stripping one‑time login links before forwarding so they can't
be misused. The manager can then pass important information on by other means.

The module defines two paired roles: **`dpxu_manager`** (the person in charge)
and **`dpxu_managed`** (the accounts they look after, linked by a
`field_dpxu_manager_uid` reference). A manager creates managed accounts at
`/user/add/managed-user` (up to a configurable per‑manager cap) and edits their
own managed users at `/user/{manager}/edit/managed-user/{user}`. Managed users
can message their manager through a contact form. Access is enforced at two
layers — route permissions *and* an ownership check in the service — so a manager
can never edit an account they do not manage. It depends only on core's **User**
module.

Because the manager role grants power over other people's accounts (including
resetting their passwords and reading their intercepted mail), grant it only to
trusted users.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the settings form (creation cap,
   email interception, placeholder generation, message templates) plus the
   permissions and roles you need to assign.

## Where it lives in the admin menu

The settings form sits at **Configuration → System → Designated Proxy User**
(`/admin/config/system/dpxu`), reachable by a user with the **Administer dpxu
configuration** permission. The day‑to‑day manager actions live on the user
account pages — creating a managed user at `/user/add/managed-user` and editing
one at `/user/{manager}/edit/managed-user/{user}`.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. On the settings form, set the per‑manager creation cap, decide whether to
   generate placeholder emails and intercept managed‑user mail, and customize the
   message templates (see [Configuration](configuration/index.md)).
3. Assign the **`dpxu_manager`** role to the trusted people who will manage
   accounts, and grant them the **Create dpxu users** and **Edit dpxu users**
   permissions.
4. A manager creates managed accounts at **`/user/add/managed-user`**; each new
   account automatically receives the `dpxu_managed` role and is linked to its
   manager. Managed users can reach their manager through the contact form.
