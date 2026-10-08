# Better Exposed Filters Field Gate — manual setup guide

**Better Exposed Filters Field Gate** (`better_exposed_filters_field_gate`) adds a
widget to the Better Exposed Filters (BEF) module that lets you hide some taxonomy
terms from an exposed filter. Only terms whose chosen boolean field is switched on
appear as options; the rest are left out of the filter UI.

The everyday use is a "featured categories" style filter. Say you have a large
vocabulary but only want a handful of terms to show up as filter checkboxes — add
a boolean field like *Featured* to the vocabulary, tick it on the terms you want,
and this widget curates the exposed filter down to just those terms. You get the
short, relevant filter without maintaining a separate vocabulary.

It is worth being clear about what this does **not** do. This is display‑level
curation of the options shown in the filter form only. It is not an access‑control
mechanism: the underlying Views query and normal taxonomy access still decide what
results a visitor can actually see. Non‑term options such as "- Any -" are always
kept intact.

The widget applies only to **Taxonomy term (TaxonomyIndexTid)** exposed filters
and builds on top of BEF's checkbox/radio widget. It has no admin page,
permissions, or routes of its own — you configure it entirely inside the Views
exposed‑form settings. It requires Better Exposed Filters and core Taxonomy, and
supports Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (and its BEF
   dependency) with Composer and enable it.

## How to use it

There is no separate settings page — everything happens in the Views UI:

1. Make sure the term vocabulary has a **boolean field** (for example *Featured*)
   and that it is set to on for the terms you want to keep in the filter.
2. Edit the View and open its **exposed** taxonomy‑term filter
   (a *Taxonomy term* / TaxonomyIndexTid filter).
3. In the filter's **Better Exposed Filters** settings, choose the Field Gate
   checkbox/radio widget.
4. Turn on **field gate** and select the boolean field on the term that controls
   visibility. (If you enable gating you must pick a boolean field — the form
   validates this.)
5. Save the View. When the exposed form renders, only terms whose boolean field is
   on appear as options; "- Any -" and other non‑term options remain.
