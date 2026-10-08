# Block Access — manual setup guide

**Block Access** (`block_access`) breaks up Drupal's coarse control over content
blocks. Historically, letting someone manage custom (content) blocks meant
granting the sweeping *Administer blocks* permission — which also lets them place
and configure blocks site‑wide. Block Access adds a set of **granular, per‑block‑
type permissions** so a non‑admin role can create, edit, or delete content blocks
of specific types without that all‑powerful permission.

The permissions are generated automatically for every content block type you
have. Its lasting value in this version is the **"own"‑scoped** pair — *update own
`<type>` block content* and *delete own `<type>` block content* — which give
editors node‑style ownership over the blocks they created. A route tweak also
lets a user reach the "Add content block" form if they hold either *Administer
blocks* or that type's create permission.

The module has **no settings page, no configuration entity, and no Drush
commands**. You use it entirely by granting its permissions on the People →
Permissions page (or in exported role config). It requires only core's Block
Content module.

> **Version note:** In this 1.2.x release the *create*, *update any*, and *delete
> any* permissions are **deprecated** and are removed in 2.0.0, because recent
> Drupal core now provides its own equivalent per‑type content‑block permissions.
> The *update own* / *delete own* permissions are the unique reason to use the
> module. An update hook migrates roles onto the core permissions where an
> equivalent exists.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — the permissions it adds and how to
   grant them.

## Where it lives in the admin menu

Block Access adds no admin page. Its permissions appear on **People →
Permissions** (`/admin/people/permissions`), grouped with the other block
content permissions, one set per content block type.

## How to use it

Decide which roles should manage which block types, then tick the corresponding
Block Access permissions on the permissions page — see
[Configuration](configuration/index.md) for exactly what each one does.
