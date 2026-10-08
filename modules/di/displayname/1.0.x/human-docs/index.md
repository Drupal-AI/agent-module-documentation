# Display Name — manual setup guide

**Display Name** (`displayname`) provides a set of user *display‑name* field types
so your site can show a friendly, human‑chosen name — a first/last name, a
nickname, a full name — instead of the raw login username wherever a person's name
is rendered. You add one of its fields to the User entity, let people fill it in,
and then render it in place of (or alongside) the account name.

It's important to understand what this does and does *not* change. Display Name
affects the **displayed** name only; it does not touch the account's login
username or its identity. The values people enter are ordinary user‑supplied
content, output through Drupal's normal field escaping, and the module has no
access‑control role of its own beyond the permissions it defines. It depends on
core's **Field** and **User** modules and on the contributed **Token** module.

There is no central settings screen. You configure it the way you configure any
field: add a Display Name field to the User account settings, then arrange it on
the user *Manage form display* and *Manage display* tabs.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and pull in its Token dependency.

There is **no dedicated configuration page** — you set the module up entirely
through the User entity's field, form‑display and display tabs, described in "How
to use it" below.

## Where it lives in the admin menu

Display Name adds no settings page of its own. You work with it under
**Configuration → People → Account settings → Manage fields / Manage form display
/ Manage display** (`/admin/config/people/accounts/fields`).

## How to use it

1. Go to **Configuration → People → Account settings → Manage fields** and add a
   new field, choosing one of the Display Name field types.
2. On **Manage form display**, position the field so users (or administrators) can
   enter a display name when editing an account.
3. On **Manage display**, place the field where you want the friendly name to
   appear on the user profile.
4. To use the value elsewhere — in a view, a template, or another field — the
   module registers tokens (via the Token dependency) you can reference.

Remember the value is a display convenience: the underlying account name and login
credentials are unchanged.
