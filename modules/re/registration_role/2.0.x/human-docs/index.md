# Registration Role — manual setup guide

**Registration Role** (`registration_role`) automatically grants one or more roles to
every newly created user account. It is a deliberately tiny module: one settings form, one
config object and one hook. Whenever a new account is created, it adds the role(s) you have
chosen — so you can, for example, give every self-registered visitor a "Member" role that
is distinct from plain authenticated users, tag a launch cohort, or hand new users a role
that unlocks a members-only section.

You also decide *whose* registrations count. In **User self registration** mode, roles are
granted only when an anonymous visitor signs up themselves. In **Both user self
registration and user creation by admin** mode, roles are also granted when a logged-in
administrator — or a Drush/CLI script — creates the account. Because the module reacts to
every new user save, that second mode also affects accounts created by migrations and
feeds, so choose it deliberately.

The module has no dependencies beyond Drupal core, ships no Drush commands, plugins or
tables, and defines a single permission (**Administer registration roles**) for its
settings form. Roles are only applied when an account is *new* — editing an existing user
never re-applies them. For anything more elaborate, such as letting users pick their own
role, the project suggests the `autoassignrole` module instead.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable it.
2. [Configuration](configuration/index.md) — pick the roles to assign and the registration
   mode.

## Where it lives in the admin menu

Once enabled, the settings form sits at **People → Registration Role**
(`/admin/people/registration-role`) — also reachable as a tab on the main *People* screen —
and is gated by the *Administer registration roles* permission.
