# String Overrides — manual setup guide

**String Overrides** (`stringoverrides`) lets you replace almost any piece of
interface text on your site with your own wording — per language — from a single
admin form. Rename "Log in" to "Sign in", change "Comments" to "Reviews", relabel
"Add to cart", or fix a typo in a contrib module's text, all without editing code,
templates, or wrestling with the full translation import workflow.

It works by hooking into Drupal's normal translation system: whenever a string
passes through `t()` (which is how core and contrib produce interface text), the
module checks your list of overrides and returns your replacement if the original
matches. Because of that, it can override strings you don't control — a module's
hard-coded English label, a core message — as long as the text is a translatable
interface string. It does **not** rewrite raw HTML, field values, or page
content.

Overrides are stored as configuration, so you can export them and deploy the same
wording across environments. You can keep a library of prepared overrides and
toggle each one on or off without retyping, and use a "context" to disambiguate
tricky strings (like "May" the month versus "May" the verb). It works on both
monolingual and multilingual sites, needs no other modules, and is gated by its
own permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the overrides form field by field,
   per-language behaviour, enabling/disabling rows, and the permission.

## Where it lives in the admin menu

The overrides form is at **Configuration → Regional and language → String
Overrides** (`/admin/config/regional/stringoverrides`). Opening it redirects to
your default language's form; on a multilingual site you can switch to another
language's overrides from there.
