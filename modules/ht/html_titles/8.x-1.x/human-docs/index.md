# HTML Titles for Drupal — manual setup guide

**HTML Titles for Drupal** (`html_titles`) lets entity titles contain a limited set
of **HTML markup**, so a title can carry formatting that Drupal would normally escape
and show as literal text. That means richer headings — for example italics with
`<em>`, superscripts with `<sup>`, or small inline styling — in the titles of the
entity types it supports: **nodes**, **taxonomy terms**, and **blocks**.

Using it is deliberately simple: you type the HTML markup directly into the entity's
title field and save. There's no complex setup — the module changes how titles are
rendered so the allowed markup comes through as formatting instead of being escaped.

> **Important security caution — this creates a stored‑XSS surface.** Drupal escapes
> titles precisely because they're output in many places across a site. By allowing
> raw HTML in titles, whatever an editor puts in a title is **rendered** — so if
> title editing is available to a less‑trusted user, they could inject
> `<script>…</script>` that executes for other visitors (stored XSS). Only use this
> where **title editing is restricted to trusted editors**, and ideally sanitize the
> HTML you allow in titles down to a safe tag set (for example just `<em>`, `<sup>`,
> `<strong>`). The module has no access‑control features of its own — the trust
> boundary is entirely up to how you assign edit permissions on the affected
> entities.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no dedicated settings page** for this module — once enabled, you simply
enter HTML in the title fields of supported entities, as described in "How to use it"
below.

## Where it lives in the admin menu

HTML Titles adds no admin settings page. It changes how the titles of **nodes**,
**taxonomy terms**, and **blocks** are rendered so that the markup they contain is
displayed as formatting.

## How to use it

1. First make sure the entities whose titles you'll add HTML to are **only editable
   by trusted editors** — this is the key safeguard.
2. Edit a node, taxonomy term, or block.
3. In its **title** field, type the HTML markup you want — for example
   `Water is H<sub>2</sub>O` or `A <em>very</em> important update`.
4. **Save.** The title now renders with the formatting instead of showing the tags as
   plain text.
