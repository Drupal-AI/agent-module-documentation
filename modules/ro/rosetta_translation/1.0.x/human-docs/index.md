# Rosetta Translation — manual setup guide

**Rosetta Translation** (`rosetta_translation`) connects your Drupal site to the
open‑source [`au5ton/rosetta`](https://www.drupal.org/project/rosetta_translation)
project to provide site‑wide, on‑the‑fly translation. Visitors pick a language
from a drop‑down you place on your page, and the Rosetta client widget translates
the applicable content live in the browser.

What sets it apart from subscription services is that **you host the translation
backend yourself**. The Drupal module is the client half: you point it at your own
Rosetta server endpoint and tell it which drop‑down element on your page drives
the translation. Because the backend is yours, you control the cost and the data —
and the module can lazy‑load translations for fast page loads and let the backend
cache results to save money.

Setting it up has two halves. First you fill in the module's settings form
(endpoint URL, the drop‑down element's id, your default language, and the list of
languages you want to offer). Then you add a matching drop‑down element — with the
same id — into one of your Twig templates, usually in the site header, so the
widget has something to attach to. It should appear only once per page.

One thing to be aware of before you go live: depending on how your backend is
configured, translating content means **sending that content to your Rosetta
server**. Since you host that server, make sure the endpoint is one you trust and
that this egress is acceptable for the content on your site.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the settings form, field by field,
   plus the Twig template step.

## Where it lives in the admin menu

The settings form sits at **Configuration → Regional and language → Rosetta
Translation** (`/admin/config/regional/rosetta-translation`).
