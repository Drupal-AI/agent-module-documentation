# Block In Page 403 — manual setup guide

**Block In Page 403** (`block_in_page_403`) lets you place a block on the **403
"access denied" page**. Instead of the bare default response a visitor sees when
they're not allowed to view something, you can show helpful content — a login
prompt, an explanation, a contact link, or any other block — right on the denial
page.

Drupal's block layout lets you show blocks on the 404 (page not found) response,
but not on the 403. This module fills that gap so the access-denied page can be
as informative as the rest of your site. It depends only on core's Block module
and works across Drupal 8, 9, 10, and 11.

Note that this only enriches the *look* of the denial. The 403 still denies
access to the requested resource, and any block you place there still honours its
own visibility and access rules — the module gives you no way to bypass access
control, and adds no permissions of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

The module adds no page of its own. It makes the 403 page available as a
placement context in **Structure → Block layout**
(`/admin/structure/block`).

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to **Structure → Block layout** and place the block you want visitors to
   see on the access-denied page (for example a login block, a menu, or a custom
   block with a help message).
3. Use the placement's visibility settings to target the 403 context, then save.
4. Test by visiting a URL your current user isn't allowed to see — the block
   should now appear on the 403 page.
