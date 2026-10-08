# Metatag Webform — manual setup guide

**Metatag Webform** (`metatag_webform`) lets you give each individual webform
its own meta tags — page title, meta description, Open Graph and Twitter card
tags, and so on. Core Metatag can already do this for content entities such as
nodes, but a webform is not a content entity, so its canonical page would
otherwise only ever show your site-wide defaults. This small bridge module fills
that gap.

Once enabled, every webform gains a **Metatags** tab on its *Settings* screen.
Open it and you get the full Metatag form (Basic tags, Open Graph, Twitter
cards…) — the same interface Metatag shows elsewhere, just tied to that one
webform. Whatever you fill in is written out on the webform's own page, layered
on top of your site defaults, so only the tags you set are overridden.

There is **no global settings page** for this module — configuration is always
per webform. It also has no permissions of its own: anyone who can edit a given
webform can edit its meta tags. The module cleans up after itself, too — delete a
webform and its saved meta tags go with it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside its Metatag and Webform dependencies.

## Where it lives in the admin menu

There is no dedicated admin page. The module adds a **Metatags** tab inside each
webform's settings:

1. Go to **Structure → Webforms** (`/admin/structure/webform`) and open a webform
   (click **Build** or **Settings**).
2. Open the **Settings** tab, then the **Metatags** secondary tab
   (`/admin/structure/webform/manage/<webform_id>/metatags`).
3. Fill in any meta tags you want — for example a custom **Page title** and
   **Description** under *Basic tags*, or Open Graph tags so a shared link shows a
   proper title, image, and description on social media.
4. Click **Save**. The tags now appear on that webform's page, and only there.

Because each webform stores its own values, you can give a "Contact sales" form
and a "Contact support" form completely different titles and social previews
without touching your global Metatag defaults.
