# Recipe — manual setup guide

**Recipe** (`recipe`) is for sharing **cooking recipes**. It gives your site a
ready‑made **Recipe** content type — with fields for the dish, its instructions,
cooking times and yield — plus an **Ingredient** entity type and a special
ingredient‑reference field, and custom Views displays for browsing and printing
recipes. Think of it as a solid starting point that you're expected to extend and
adjust to your own needs.

> **Name collision — read this first.** Drupal core now has a feature also called
> **"recipes"**: packaged configuration and content applied to an existing site
> (the modern replacement for installation distributions). That has **nothing to do
> with cooking** and is unrelated to this module. Whenever you say "recipe" around a
> Drupal 10.3+ site, make clear which one you mean — this module is the culinary
> one.

The clever part is the **Ingredient** field type, provided by the bundled
`ingredient` submodule, and it's the reason this module is more than a content type
you could have built by hand. A line like "200g plain flour" *looks* like prose but
is really data — a quantity, a unit, and an ingredient. Stored as plain text, a
site can't scale a recipe to six servings, convert grams to ounces, build a shopping
list from three recipes, or list everything containing tomatoes. The Ingredient
field parses the human phrasing into its parts and keeps both, which is what makes
those features possible.

Recipe is one of Drupal's oldest contrib modules — its first code was written in
2002 — but the current 8.x‑2.x branch is rebuilt on standard core field types plus
that custom ingredient field.

> **Want rich results in Google?** A recipe site's biggest SEO win is emitting
> **Recipe structured data** (JSON‑LD), so search engines can show a photo, star
> rating, cook time, and calories. Check what this module outputs and, if needed,
> add a module such as **Schema.org Metatag** (`schema_metatag`) alongside it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (with the `ingredient` submodule).

There is **no central settings page** — Recipe adds a content type and field type
you work with through the normal content and Field UI. See "How to use it" below.

## Where it lives in the admin menu

After installing, you'll find the **Recipe** content type under **Structure →
Content types**, its fields under that type's **Manage fields**, and you create
recipes from **Content → Add content → Recipe**.

## How to use it

1. Enable the module and its `ingredient` submodule
   ([Installation](installation/index.md)).
2. Go to **Content → Add content → Recipe** and create your first recipe — fill in
   the title, description, instructions, times, and yield.
3. Add ingredients using the **Ingredient** reference field: as you type quantities,
   units, and ingredient names, they're parsed and stored as structured data.
4. Treat the supplied content type as a starting point — add or adjust fields under
   **Structure → Content types → Recipe → Manage fields** to match your site.
5. Browse and print recipes through the Views displays the module provides.
