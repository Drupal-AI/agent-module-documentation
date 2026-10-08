# Taxonomy Class — manual setup guide

**Taxonomy Class** (`taxonomy_class`) adds a per‑term CSS class to Drupal's
taxonomy system so editors can style individual terms without touching templates
or stylesheets. It defines a single "CSS class(es)" base field on every taxonomy
term, and whatever an editor types there is output as a class on the rendered
term — so a *News* category could carry `cat-news`, a *Featured* tag could carry
`is-featured`, and your theme's CSS takes it from there.

The module solves a common annoyance: you want one term to look different from its
siblings, but the only levers Drupal gives you are template overrides or brittle
term‑ID selectors. Taxonomy Class puts an editable class right on the term edit
form instead, keeping presentation data on the term itself (so it travels with your
content) and letting non‑developers manage it.

It works the moment you enable it — there is no configuration form. The one thing
to know is that the class field is only shown to users who hold the **Administer
taxonomy classes** permission; everyone else edits terms as usual and never sees
it. The module depends only on core's Taxonomy module, ships no submodules, and
adds no config UI or config schema (the class values live on each term entity).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Taxonomy Class has no settings page of its own. Everything happens on the normal
term forms under **Structure → Taxonomy** (`/admin/structure/taxonomy`) and in the
**People → Permissions** screen where you grant the *Administer taxonomy classes*
permission.

## How to use it

1. Grant the **Administer taxonomy classes** permission to the roles that should
   manage term styling — go to **People → Permissions**
   (`/admin/people/permissions`), find *Administer taxonomy classes*, tick the
   boxes, and save. Without this permission the class field stays hidden.
2. Edit any taxonomy term (**Structure → Taxonomy → [your vocabulary] → Edit** on a
   term). In the advanced sidebar you'll find a collapsed **Taxonomy Class
   settings** group. Open it and type a class name — for example `cat-news` or
   `is-featured`.
3. Save the term. When that term is rendered, the class you entered is appended to
   the term template's wrapper element, so you can target it from your theme's CSS
   (`.cat-news { … }`) or JavaScript.

A few honest limits worth knowing: only the **first** value of the field is
applied, so treat it as a single class slot (you can still put a space‑separated
list in that one string if your theme expects several). The class is rendered
through Drupal core's attribute handling, which escapes it on output.
