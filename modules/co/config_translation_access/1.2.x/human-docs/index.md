# Configuration Translation Access — manual setup guide

**Configuration Translation Access** (`config_translation_access`) solves a small
but real permission problem. Drupal core's Configuration Translation module gates
*every* translation form behind a single, very broad permission, **Translate
configuration** — grant it, and a user can translate all configuration on the
site, whether or not they can edit the underlying items.

This module adds a more precise alternative: one permission, **Translate editable
configuration**, that lets a role translate a configuration item only when it can
already reach that item's own edit form. So a content-type manager can translate
the content types they administer, and a Views admin can translate the views they
can edit — but neither can translate configuration they have no edit rights to.
Translation access stays automatically in sync with edit access, with no separate
grant per item.

It works quietly behind the scenes by decorating core's two config-translation
access checks. It never overrides a decision core has already made — it only fills
the "neutral" gap by additionally allowing translation when the user holds the new
permission and can access the item's base edit route. There is no settings form,
no schema, and no Drush command.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

There is nothing to configure — the entire module is one permission:

1. Go to **People → Permissions** (`/admin/people/permissions`).
2. Find **Translate editable configuration** and grant it to the roles that should
   translate the configuration they can already edit.
3. Make sure those same roles hold the base edit permissions for the items you want
   them to translate (for example, *Administer content types*, or the relevant
   Views/menu/block edit permissions). Translation access follows those edit
   rights.

Do **not** also grant core's broad *Translate configuration* to those roles, or the
narrowing effect is lost.

> **Treat the permission as trusted.** It is flagged as a restricted permission
> because its effective reach depends on whatever base edit routes the holder can
> access. Pair it deliberately with the edit permissions you actually want to make
> translatable.
