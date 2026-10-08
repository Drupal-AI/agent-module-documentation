# Sharerich — manual setup guide

**Sharerich** (`sharerich`) gives you configurable, responsive social-sharing button
sets that you place on your site as a block. Built on the RRSSB (Ridiculously
Responsive Social Sharing Buttons) approach, it lets you assemble a named set of
share buttons — Facebook, Twitter/X, email, Tumblr, and more — decide which services
appear and in what order, and then drop the set anywhere via Drupal's block system.

Each button set is a configuration entity that stores a list of services, and each
service carries its own HTML markup with `[sharerich:*]` tokens (such as
`[sharerich:url]`, `[sharerich:title]`, `[sharerich:summary]`,
`[sharerich:twitter_user]`, and `[sharerich:fb_app_id]`). When the block renders,
those tokens are replaced using the node, term, or user from the current page, so
the buttons share the *right* URL and title in context. You can orient a set
horizontally or vertically, and make a vertical bar sticky so it floats as visitors
scroll.

Global options — a Facebook App ID, a site URL for the Facebook share dialog, and
social usernames such as the Twitter *via* user — live on a settings page, along
with an *allowed HTML* setting that limits which tags are permitted in button
markup. Sharerich depends on the **Token** and **Block** modules, and every one of
its admin routes is gated by the restricted **Administer sharerich**
(`administer sharerich`) permission, so only trusted administrators should have it.

The button markup itself is admin-authored config, gated by the restricted admin
permission, so its raw HTML is only editable by trusted users.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its dependencies.
2. [Configuration](configuration/index.md) — build button sets, set global options,
   and place the block.

## Where it lives in the admin menu

- Button sets are managed at **Structure → Sharerich**
  (`/admin/structure/sharerich`).
- Global settings live at **Configuration → Sharerich → settings**
  (`/admin/config/sharerich/settings`).
- The **Sharerich** block is placed from **Structure → Block layout**
  (`/admin/structure/block`).

All of these require the restricted `administer sharerich` permission.
