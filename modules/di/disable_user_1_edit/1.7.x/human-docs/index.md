# Disable user 1 edit — manual setup guide

**Disable user 1 edit** (`disable_user_1_edit`) locks down Drupal's user 1 — the
original superuser account — so that nobody can edit it through the admin UI, even
accounts that hold the powerful *Administer users* permission. On sites where more
than one person can administer users, that closes a real privilege‑escalation
path: without this module, anyone with *Administer users* could change user 1's
password or email and effectively take over the site.

The module is a single, focused access check. It hooks into Drupal's entity access
system and, while its protection is active, forbids access to the user 1 entity
outright. Because the check doesn't distinguish between operations, the protection
covers not just editing but also deleting — and viewing — user 1 through the entity
access system.

Protection is **on by default** the moment you install the module (it ships that
way). A single settings form gives you one checkbox to temporarily lift the
protection when you genuinely need to change user 1 — after which you re‑tick it to
re‑lock the account. That "make it editable again" toggle is deliberately gated
behind its own restricted permission, so not just any administrator can turn the
protection off.

It has **no dependencies** and works on Drupal 8 through 11. It pairs well with a
policy of never using user 1 for day‑to‑day work — a break‑glass account you keep
locked and only touch via configuration or the command line.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (protection is on immediately).
2. [Configuration](configuration/index.md) — the single settings form, its one
   checkbox, and the slightly counter‑intuitive wording to watch for.

## Where it lives in the admin menu

The settings form sits at **Configuration → People → Disable user 1 edit**
(`/admin/config/people/disable_user_1_edit`). Reaching it requires the module's
own restricted permission, **Administer disable user 1 edit**.
