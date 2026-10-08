# Taxonomy Depth Widget — manual setup guide

**Taxonomy Depth Widget** (`taxonomy_depth_widget`) lets a taxonomy
term‑reference field offer only certain *levels* of a hierarchical vocabulary,
rather than every term at every level. You choose the depth (or a range of
depths) in the field's form‑display settings, and the widget then presents only
the terms at those levels when someone creates or edits content.

The problem it solves is a familiar one. Hierarchical vocabularies are usually
built so only the leaves are meant to be chosen — a location tree of country →
region → city exists so content is tagged with a *city*, and a product taxonomy
of department → category → subcategory exists so a product is a *subcategory*.
But Drupal's stock widgets offer every term at every level, so editors tag
content with "Europe" when they meant "Lyon", and a listing filtered by city
quietly misses it. Constraining the offered depth makes the intended level the
only one available, which cuts down mis‑tagging and keeps faceted listings
accurate. Currently the constraint applies to the select‑list and
checkboxes/radio‑buttons widgets.

It supports Drupal 10 and 11 and depends only on core **Taxonomy**. There is no
site‑wide settings page — everything is configured per field on **Manage form
display**.

Two things are worth understanding before you rely on it:

- **It is a widget setting, so it constrains the form and nothing else.** A
  migration, a JSON:API write, a second form display, or an editor using a
  different widget can still store a top‑level term. If you need the restriction
  *enforced* rather than merely suggested at data entry, you need a field
  constraint; this widget is guidance for editors, not a hard rule.
- **A depth rule only works on a genuinely uniform hierarchy.** If most branches
  are three deep but a couple are two deep, a "leaves only" rule will hide the
  leaves of the shallow branches. Check the *real* vocabulary, not the intended
  one — taxonomies drift over time.

This guide is written for a **human** setting the site up through the admin UI.
If you are an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — set the depth or depth range on a
   field in the form display.

## Where it lives in the admin menu

There is no dedicated admin page. You configure the widget on a per‑field basis
at **Structure → [entity type] → Manage form display**, in the settings of a
taxonomy term‑reference field's widget.
