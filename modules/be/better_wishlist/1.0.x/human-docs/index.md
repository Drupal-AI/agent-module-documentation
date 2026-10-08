# Better Wishlist — manual setup guide

**Better Wishlist** (`better_wishlist`) lets users save items or entities to a
personal wishlist — useful for e-commerce stores or for letting visitors
bookmark content to return to later. It depends on the contributed Entity API
module (`entity`) and provides its own permissions.

Each wishlist ties a specific user to the items they've saved, which is
personal data: expose a user's wishlist only to that user and to
administrators. The module's permissions are how you control that, and it adds
no broad access-control role beyond them.

Note this version tracks the **1.0.x development** branch, so treat it as
in-progress software and test it before relying on it in production.

This guide is written for a **human** clicking through the admin UI. If you
want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and grant its permissions.

## How to use it

After enabling, grant the wishlist permission(s) at **People → Permissions**
(`/admin/people/permissions`) to the roles that should be able to save items.
Signed-in users can then add items/entities to their own wishlist and review
what they've saved. When placing wishlist links or blocks in your theme, keep
each user's list visible only to that user (and to admins), since it is
personal data.
