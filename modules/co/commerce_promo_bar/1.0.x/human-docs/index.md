# Commerce Promo Bar — manual setup guide

**Commerce Promo Bar** (`commerce_promo_bar`) lets a store display promotional and
notification bars — sale banners, coupon codes, time-limited announcements, delivery
delays — at the top of (or anywhere on) its pages, without hand-editing templates.
Each bar is a **fieldable `commerce_promo_bar` content entity**, and a single block
renders whichever bars apply to the current visitor and page.

Each promo bar carries a title and a WYSIWYG message body (with token support), a
background and text colour you set in the UI, start/end dates so it appears and
expires on schedule, and an optional **countdown timer**. You can link a bar to a
**Commerce promotion** so that the promotion's coupon code and details can be
tokenised straight into the message. Bars can be marked dismissible (a visitor can
close them for the session), stacked so several show at once, or ordered by weight so
only the top one shows. Because the entity is fieldable, you can add your own fields
and surface them via tokens or a Twig template override.

Visibility is controlled per bar by **store**, **customer role**, **start/end date**,
and **path** (with show/hide semantics and `*` wildcards), so the right message
reaches the right shoppers on the right pages. Access to creating and managing bars
is governed by an "administer commerce promo bar" permission — there are no anonymous
or mutating endpoints exposed.

It depends on **Commerce Promotion** (`commerce_promotion`), core **Options**
(`options`), and the **Color Field** module (`color_field`, used for the colour
pickers). It needs Drupal **10.3 or 11**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside its dependencies.
2. [Configuration](configuration/index.md) — place the block, create and style promo
   bars, set visibility, and add fields.

## Where it lives in the admin menu

- **Manage promo bars:** **Commerce → Promo bars** (`/admin/commerce/promo-bars`) —
  the collection where you add, edit, enable/disable, duplicate, and delete bars.
- **Fields, form, and display:** the field-UI base route at
  `admin/commerce/config/promo_bar` (`entity.commerce_promo_bar.settings`).
- **Display it:** place the **Promo bar block** in a region via **Block layout**.
