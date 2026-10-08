# Canvas Page Metatag — manual setup guide

**Canvas Page Metatag** (`canvas_page_metatag`) brings the full **Metatag** SEO
tag set into **Canvas**, Drupal's Experience Builder page builder. Once enabled,
editors building a page in Canvas can set its meta tags — page title and
description, plus social‑sharing tags such as Open Graph, Facebook, and Twitter
Cards — right where they build the page, per page.

It is purely an SEO feature: the meta values describe the on‑page content and the
module has no content type or access‑control role of its own. It depends on both
**Canvas** and **Metatag** (along with Metatag's Open Graph, Facebook, and
Twitter Cards submodules), and it targets Drupal 10.3+ and 11.

This guide is written for a **human** clicking through the site. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (Canvas and Metatag are required).

## Where it lives in the admin menu

Canvas Page Metatag adds no settings form of its own — the meta‑tag defaults and
available tags are governed by the **Metatag** module (Configuration → Search and
metadata → Metatag). What this module adds is the ability to set those tags per
page from within the Canvas page builder.

## How to use it

While building a page in Canvas, open the meta‑tag fields the module exposes and
fill in the values you want for that page — title, description, and the social
tags (Open Graph / Facebook / Twitter Cards). Those values are then emitted in the
page's HTML head for search engines and social‑sharing previews. Site‑wide
defaults and token patterns continue to be managed through the Metatag module.
