# Tagify — manual setup guide

**Tagify** (`tagify`) makes Drupal's entity‑reference fields far friendlier to use.
Out of the box, referencing taxonomy terms, users, or other entities relies on a
plain comma‑separated autocomplete textfield that is easy to get wrong. Tagify
swaps that for the [Tagify](https://yaireo.github.io/tagify/) JavaScript library,
turning each reference into a visual "chip" with an **x** to remove it, drag‑to‑
reorder support, and a rich dropdown of matching suggestions.

The module provides two field widgets: an **entity‑reference autocomplete widget**
(chips plus type‑ahead) and a Tagify‑styled **select widget** for fixed option
lists. Each one is configurable per field — the match operator (contains vs.
starts‑with), how many suggestions to show, placeholder text, whether to expose
the entity ID inside a chip, an optional token‑driven "info label" beside each
suggestion (for example a term description), and whether parent terms may be
selected in a hierarchical vocabulary. A small global settings form can also make
Tagify the default widget for *every* entity‑reference field on the site.

Tagify plays well with the wider ecosystem: it integrates with Better Exposed
Filters so a Views exposed filter can use the same tag UI, and it ships four
optional submodules — Facets integration, a UI Icons picker, an Iconify icon
picker, and a user‑list widget that shows avatars. For developers there is a
`hook_tagify_autocomplete_match_alter()` hook, reusable `entity_autocomplete_tagify`
and `select_tagify` render elements, an autocomplete matcher service, and a
hierarchical‑term manager service. Styling adapts automatically to the Claro and
Gin admin themes. It depends on core's **Taxonomy** module and requires Drupal
10.3 or newer.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and pick the submodules you need.
2. [Configuration](configuration/index.md) — the global settings form and the
   per‑field widget options, field by field.

## Where it lives in the admin menu

Tagify's global settings form sits at **Configuration → Tagify → Settings**
(`/admin/config/tagify/settings`). The options that matter most, though, are set
per field on each field's **Manage form display** tab, where you choose the Tagify
widget and adjust its behavior.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to **Structure → Content types → (your type) → Manage form display** (or the
   equivalent for a taxonomy, user, or media field).
3. For your entity‑reference field, change the **Widget** to *Tagify
   autocomplete* (or the *Tagify select* widget for a fixed option list).
4. Click the widget's gear icon to set its per‑field options — match operator,
   number of suggestions, placeholder, info label, and so on. See
   [Configuration](configuration/index.md).
5. Optionally, visit the global settings form to make Tagify the default widget
   for all entity‑reference fields at once.
