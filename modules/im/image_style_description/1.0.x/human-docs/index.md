# Image Style Description — manual setup guide

**Image Style Description** (`image_style_description`) solves a small but
familiar annoyance. Once a site has a dozen image styles — *Large (480×480)*,
*Max 1300×1300*, *Media Library thumbnail*, and so on — it's easy to forget which
style is used where, and why. This module adds a **Description** field to the
image‑style add/edit form and shows that description on the **Image styles**
admin listing, so you (or whoever inherits the site) can document what each style
is for.

The description is stored on the image style itself as a *third‑party setting*,
which means it exports and imports cleanly with `drush config:export` and
`drush config:import` like any other configuration — there's no separate table,
no extra entity, and nothing to migrate. If you ever disable the module your
image styles keep working; the descriptions simply stop appearing on the
listing, and come back when you re‑enable it.

The module depends only on core's Image module and targets Drupal 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no separate settings page**: you add descriptions directly in the core
image‑style form, described in "How to use it" below.

## Where it lives in the admin menu

Image Style Description adds no page of its own. It extends the core **Image
styles** screen at **Configuration → Media → Image styles**
(`/admin/config/media/image-styles`).

## How to use it

1. Go to **Configuration → Media → Image styles**
   (`/admin/config/media/image-styles`).
2. Edit an existing style, or add a new one.
3. Fill in the new **Description** field — something future‑you (or a colleague)
   will understand, such as "Hero banner, 16:9" or "Square thumbnail for cards".
4. Click **Save**. The description now appears in the listing, next to the style
   it belongs to.
