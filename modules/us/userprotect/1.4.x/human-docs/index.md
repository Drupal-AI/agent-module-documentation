# User Protect — manual setup guide

**User Protect** (`userprotect`) gives you fine-grained control over who can edit
or cancel which user accounts. You define **protection rules** that lock specific
fields or operations on a chosen account or on every user in a role — so, for
example, no other administrator can rename the `admin` account, reset someone's
password, change their roles, or delete them.

Each rule targets either **one user** or **a whole role**, and switches on a set
of protections. Seven ship out of the box: the **Username**, **Email address**,
**Password**, **Status** (active/blocked), and **Roles** fields, plus the **Edit**
operation (`user/X/edit`) and the **Cancel** operation (`user/X/cancel`).
Protected fields are disabled or hidden on the user edit form, and blocked
operations are denied outright — enforcement happens through Drupal's entity and
field access system, not just by hiding form elements.

Rules are designed to be safe and predictable: they never apply to a user editing
their **own** account (self-editing of your own email, password, and account is
governed by the module's own dedicated permissions instead), never apply to **user
1**, and never apply to anyone holding the global bypass permission. Every rule
you save also generates its own per-rule bypass permission, so you can exempt
specific roles. The protection system is a plugin type, so other modules can add
custom protections (including Role Delegation's role-change field).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — including the plugin type
and the full permission model — read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — create protection rules, understand
   the bypass and self-edit permissions, and the settings form.

## Where it lives in the admin menu

Protection rules are managed at **Configuration → People → User protect**
(`/admin/config/people/userprotect`), with a settings form at
`/admin/config/people/userprotect/settings`. Access requires the *Administer user
protection rules* (`userprotect.administer`) permission.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to **Configuration → People → User protect** and add a rule.
3. Choose whether it protects a single user or a whole role, then tick the fields
   and operations to lock.
4. Save. The protections take effect immediately for everyone except the exempt
   accounts (user 1, bypass-permission holders, and the target editing itself).

See [Configuration](configuration/index.md) for the details, including how the
bypass permissions work.
