# Shortcut per Role — manual setup guide

**Shortcut per Role** (`shortcutperrole`) lets you decide which core Shortcut
set each user role sees by default. Drupal's core Shortcut module gives every
site a single "default" set of quick links in the toolbar; this module replaces
that one‑size‑fits‑all default with a per‑role mapping, so content editors,
support staff, and administrators can each land on a shortcut set tailored to
the tasks they actually do.

You map roles to sets on one small settings form: every role on your site is
listed with a drop‑down of the shortcut sets you have already created, and you
pick one per role. When a user logs in, the module looks at all the roles that
user holds and hands them the set mapped to their **highest‑weight** role — so
someone who is both an authenticated user and an administrator gets the
administrator's set. Any role you leave unmapped simply keeps Drupal's core
"default" set.

It is a thin, well‑behaved layer over core: the only thing it stores is a single
configuration object (`shortcutperrole.settings`), it adds no fields or content,
and it tidies up after itself by removing a role's mapping automatically when
that role is deleted. It depends only on core's **Shortcut** module, and the
mapping only becomes visible for users who already have permission to use the
toolbar and shortcuts.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside core's Shortcut module.
2. [Configuration](configuration/index.md) — the role‑to‑set mapping form, field
   by field, plus how the "highest‑weight role wins" rule works.

## Where it lives in the admin menu

Once enabled, the settings form sits at **Configuration → User interface →
Shortcuts → Shortcuts Per Role**
(`/admin/config/user-interface/shortcut/roles`). It is gated by the
**Administer shortcut per role** permission.

## How to use it

First create the shortcut sets you want under **Shortcuts** (core's own
shortcut‑set collection) — the module can only offer sets that already exist.
Then open the Shortcuts Per Role form, pick a set for each role, and save. From
then on, each user automatically sees the set for their highest‑weight role with
no per‑user configuration needed.
