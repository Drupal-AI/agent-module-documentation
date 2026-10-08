# Kiyoh rating — manual setup guide

**Kiyoh rating** (`kiyoh_rating`) displays your company's
[Kiyoh](https://www.kiyoh.com/) review score on your Drupal site as a piece of
social proof. It pulls the rating from the **Kiyoh XML feed** and renders it — a
star rating and review count — through a **block** you can place in any region of
your theme.

The module is intentionally minimal: it provides a little HTML and no styling of
its own, so the badge inherits your theme and you style it however you like. The
block always renders through the `kiyoh-rating-big` template. There is also an
**inline** variant (`kiyoh_rating_inline`) for developers who want to drop the
rating into a preprocess hook rather than place a block.

To connect the module to your Kiyoh account you supply your **Kiyoh hash** — the
identifier that tells Kiyoh which company's feed to read. It isn't a secret in the
credential sense, but it does tie the widget to your account.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (and core Block).
2. [Configuration](configuration/index.md) — place the Kiyoh rating block, enter
   your Kiyoh hash, and (optionally) use the inline variant in code.

## Where it lives in the admin menu

Kiyoh rating adds no dedicated settings page. You configure it by placing its
**block** at **Structure → Block layout** (`/admin/structure/block`) and setting
the block's options there.

## How to use it

The everyday use is the block: place it in a region (for example the footer or a
sidebar), enter your Kiyoh hash, and the review score renders for your visitors.
Developers who prefer to render the rating inline — inside a template or a
preprocess function — can use the `kiyoh_rating_inline` theme hook instead, as
described in [Configuration](configuration/index.md).
