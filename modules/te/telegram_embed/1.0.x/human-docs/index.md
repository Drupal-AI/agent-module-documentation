# Telegram Embed — manual setup guide

**Telegram Embed** (`telegram_embed`) lets content editors drop a Telegram post
straight into rich‑text content and have it render as the live Telegram widget,
not a plain link. It adds a **Telegram Post** button to the CKEditor 5 toolbar;
click it, paste a post URL such as `https://t.me/channel/123` into the little
balloon form, and the module inserts a lightweight, escape‑safe placeholder into
the body. When the page is displayed, a text‑format filter swaps that placeholder
for the real embedded Telegram post.

The problem it solves is a familiar one: pasting a bare `t.me/...` link gives your
readers a link they have to click and leave your site to follow, and hand‑pasting
Telegram's own embed script into a body field is both fiddly and a security risk.
Telegram Embed does the embedding for you and validates everything server‑side —
the stored `data-tg-post` value must match a `channel/postid` shape or it is
discarded, which keeps the feature from becoming an XSS vector. The widget's
JavaScript is only loaded on pages that actually contain an embed, so it adds no
weight to the rest of your site.

The module does **not** work purely on‑enable: after you install it you must add
its toolbar button to a text format and switch on its filter (see below). It
depends only on Drupal core's **Filter** and **CKEditor 5** modules — there are no
contrib dependencies and no submodules.

Note that a Telegram embed loads content from Telegram's servers via a third‑party
widget in the visitor's browser, so it can set Telegram's cookies. If you operate
under consent laws (for example in the EU) treat these embeds as non‑essential
third‑party content.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add the toolbar button and enable the
   filter on a text format, which is the required post‑install step.

## How to use it

Once the module is configured on a text format (see
[Configuration](configuration/index.md)), editors work entirely inside CKEditor 5:
click the **Telegram Post** button, paste a Telegram post URL into the balloon
form, and save. The embed appears when the content is rendered on the front end.
The module has no central settings page of its own.
