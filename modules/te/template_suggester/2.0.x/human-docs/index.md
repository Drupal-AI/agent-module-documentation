# Template Suggester — manual setup guide

**Template Suggester** (`template_suggester`) lets you extend Drupal's built‑in
entity template suggestions with your own custom ones, chosen per entity through a
field. It provides a field type named **template_suggester**: an editor picks a
custom suggestion from a list you define, and that choice makes Drupal look for an
extra Twig template — so the *same* content structure can be displayed in several
different ways.

The problem it solves is per‑item display variation without new content types or
view modes. Say you have a single "Article" type but want a handful of distinct
looks — a standard layout, a "feature" layout, a "minimal" layout. Rather than
cloning the content type, you add a Template Suggester field, define those styles
once, and let editors pick a style per article. Each style maps to a theme template
the front‑end developer provides.

Configuration is a small workflow rather than a settings page (there is no admin
config form): you declare your suggestions in a YAML file in your theme, add the
field to an entity, and create the corresponding templates. The module depends on
Drupal core's **Field** module and ships no submodules. It has no access‑control
role — the suggestion simply points at a themer‑provided template. It has been
tested with **nodes, taxonomy terms, and paragraphs**.

This guide is written for a **human** using the admin UI and working in a theme. If
you want terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — declare your suggestions in the theme,
   add the field, and create the templates.

## How to use it

Define your custom suggestions in a `template_suggester.yml` file in your active
theme, add a **Template Suggester** field to the entity, and then, when creating or
editing content, choose a suggestion. Drupal will use the matching template you
authored. See [Configuration](configuration/index.md) for the full walkthrough.
