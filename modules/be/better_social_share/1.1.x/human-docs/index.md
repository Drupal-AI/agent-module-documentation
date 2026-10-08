# Better Social Share — manual setup guide

**Better Social Share** (`better_social_share`) adds share buttons to your content
for a long list of platforms — Facebook, LinkedIn, WhatsApp, Pinterest, Tumblr,
and, by its own description, over a hundred others. You place the buttons as a
block and choose which platforms appear.

The important thing to understand is that these are **plain share links**, not
official platform widgets. A share link is just an ordinary anchor to something
like `https://www.facebook.com/sharer/sharer.php?u=…` or
`https://wa.me/?text=…`. It loads no third‑party script, sets no cookie, and makes
no contact with the platform until the visitor deliberately clicks it — which
means, unlike the official vendor widgets, a share row does not create a GDPR
consent requirement just by being on the page. (A module offering "100+ platforms"
is doing this, because a hundred vendor widgets on one page would be unusable.)

Two practical points are worth keeping in mind. First, **a hundred platforms is a
menu to pick two or three from, not a target to hit** — every extra button dilutes
the ones your audience actually uses, so enable only the handful that matter.
Second, **what a share produces is driven by your Open Graph metadata, not by this
module** — if a shared link shows a bare text preview with no image, that is a
metatag/Open‑Graph issue (a missing default share image), not something Better
Social Share controls.

It depends on core **Node** and **Block**, its `administer better_social_share`
permission is restricted to trusted users, and it supports Drupal 9.4, 10, and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — choose which platforms appear and
   place the share block.

## Where it lives in the admin menu

The settings form sits under **Configuration → Better Social Share**
(`/admin/config/…/better_social_share`), reachable by a user with the
**Administer better social share** permission (which is restricted). You place the
buttons themselves through **Structure → Block layout**.
