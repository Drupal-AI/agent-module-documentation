# Socializer — manual setup guide

**Socializer** (`socializer`) shows social-media links in a block. You configure a
set of share or follow links — pointing at your social profiles, or offering
share-this-page links — and place them in a block wherever you want them. It runs
on Drupal 8 through 11 and has no dependencies beyond core.

This is a straightforward content-display and user-engagement feature. The links
are entered by an administrator, and the module provides its own permission to
control who can manage them. It has no content model or access-control role beyond
that permission — its job is simply to render the block of links.

This guide is written for a **human** setting the block up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

Socializer surfaces its links as a placeable block:

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Place the Socializer block in the region where you want the links to appear —
   commonly a header, footer or sidebar.
3. Configure the block: enter the social links (profile/follow links, or
   share-this-page links) you want to show, and save.

Because the links are admin-configured on the block, you can update them without a
code deploy, and place more than one block if you need different link sets in
different places. Grant the module's permission only to the roles that should be
allowed to manage these links.
