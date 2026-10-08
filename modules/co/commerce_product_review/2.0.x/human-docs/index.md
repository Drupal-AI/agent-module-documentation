# Commerce Product Review — manual setup guide

**Commerce Product Review** (`commerce_product_review`) adds customer reviews and
star ratings to Drupal Commerce products. Logged-in customers write a review — a
title, body, a rating, plus any extra fields you add — and each product shows its
average rating and a list of reviews. Every customer is limited to **one review per
product**, and the product's overall rating is recalculated automatically whenever a
review is added, edited, or deleted.

Reviews are proper content entities with configurable **review types** (bundles) you
can scope to specific product types, so a "Books" review type can differ from a
"Software" one. Each review type carries a notification email address, and you can
add your own fields (customer photos, pros/cons, video) through Field UI. Ratings
can be displayed as plain numbers or as stars — the star widgets and formatters use
the external **rateit.js** JavaScript library, which you install separately (see
[Installation](installation/index.md)).

Out of the box, new reviews stay **unpublished until an administrator approves
them**; you can grant a "publish" permission to trusted roles so their reviews go
live immediately. Anonymous visitors who try to review are sent to log in first
(guest reviews are not supported, because one-review-per-user needs an account).
Administrators get a full review-management view with sorting, filtering, and bulk
publish / unpublish / delete actions.

It depends on **Commerce Product** (`commerce_product`) and **Commerce Price**
(`commerce_price`), and needs Drupal **10.3 or 11**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, add the rateit.js
   library, and enable the module.
2. [Configuration](configuration/index.md) — set up review types, permissions, and
   the overall-rating display, field by field.

## Where it lives in the admin menu

- **Review types (bundles):** **Commerce → Configuration → Product review types**
  (`/admin/commerce/config/product-review-types`).
- **All reviews (admin list):** **Commerce → Product reviews**
  (`/admin/commerce/product-reviews`), with bulk publish/unpublish/delete.
- **Customer-facing:** each product gets a reviews page and an "add review" page; a
  customer sees their own reviews at `/user/{id}/reviews`.

## How to use it

1. Install the module and the rateit.js library (see
   [Installation](installation/index.md)).
2. Configure the **default** review type (or create your own), choosing which product
   types it applies to and an optional notification email (see
   [Configuration](configuration/index.md)).
3. Enable the **"Overall rating"** field on the product display so the average shows
   on product pages.
4. Set the review permissions for your roles, and decide whether reviews auto-publish
   or wait for approval.
