# ShareThis — manual setup guide

**ShareThis** (`sharethis`) adds social-sharing buttons — Facebook, X/Twitter,
LinkedIn, email, Pinterest and more — to your content, so visitors can share a
page in one click. The buttons are powered by the hosted ShareThis widget service,
so the actual sharing markup and counters are loaded from `sharethis.com`.

You control everything from one settings form. The most important choice is
*where* the buttons appear. In **content** mode they render as an extra field on
the content types you pick; in **links** mode they render per view mode (say, only
on the full node, not the teaser); or you can skip node rendering entirely and drop
the **Sharethis** block into any region with Drupal's Block layout. There is also a
**Sharethis Widget** block for sharing a fixed URL, and a Views field so you can add
a share column to a listing. Beyond placement, the form lets you choose which
services show, the button style, and behaviours like on-hover menus, URL
shortening, and a Twitter handle appended to tweets.

The module works as soon as it is enabled, with sensible defaults (buttons on
Article and Page content), but you will normally visit the settings form to tune
which content types and services you want. It has no other module dependencies and
no submodules. It adds one permission, *Administer Sharethis*, that gates the
settings form.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the settings form, field by field:
   button placement, content types, services, blocks, and Twitter options.

## Where it lives in the admin menu

The settings form sits under **Configuration → Web services → ShareThis**
(`/admin/config/services/sharethis`), gated by the *Administer Sharethis*
permission. The two blocks are placed from **Structure → Block layout**, and the
Views field is added inside the Views UI.
