# Token — manual setup guide

**Token** (`token`) gives Drupal's Token API a friendly face. *Tokens* are small
placeholder strings — things like `[node:title]`, `[site:name]`, or
`[user:mail]` — that Drupal swaps out for real values when content is rendered.
Drupal core ships the engine that does the swapping, but it gives you no way to
*see* which tokens exist. Token fills that gap: it adds the familiar
"Browse available tokens" tree you meet all over the admin UI, and it registers a
whole set of extra tokens that core leaves out (for entities, individual fields,
menu links, book hierarchy, arrays, and more).

The problem it solves is discoverability and coverage. Instead of digging through
code to find out whether `[node:field_subtitle]` is a valid placeholder, a site
builder can click a link and browse the live token tree for the content type in
front of them. That is why Token is one of the most widely installed contrib
modules on the planet — Pathauto, Metatag, Webform, Rules, and countless others
lean on it.

Token works the moment you enable it. There is nothing you *must* configure — it
has no settings page and no permissions of its own. It is pure infrastructure: the
value shows up inside *other* modules' forms as the token browser and as a richer
set of available placeholders. It depends only on Drupal core and ships no
submodules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

Token has no configuration screen, so you will not find it in the admin menu as a
settings page. Instead it surfaces in two ways:

- **The token browser.** On many forms across Drupal and contrib — for example
  Pathauto's URL alias patterns, Metatag's meta tag patterns, or a Webform email
  template — you will see a **"Browse available tokens"** link (or an inline token
  tree table). Click it and a dialog opens listing every token that applies to
  that form, grouped by type, each with an example value. Copy the one you want,
  such as `[node:title]`, and paste it into the field.

- **A richer set of tokens everywhere.** Any place that already accepts tokens
  gains the extra placeholders Token registers — including tokens for entity field
  values, menu links, and book pages — without you doing anything beyond enabling
  the module.

You can browse the live token tree directly at `/token/tree` to explore what is
available on your site. Under the hood, replacement itself is a core function
(`\Drupal::token()->replace('[node:title]', ['node' => $node])`); Token is the
layer that makes those tokens visible and complete. If you are building your own
form and want to embed the token browser in it, that is a developer task — see the
sibling [`agent/`](../agent/start.md) docs.
