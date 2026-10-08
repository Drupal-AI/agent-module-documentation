# Taxonomy Formatter — manual setup guide

**Taxonomy Formatter** (`taxonomy_formatter`) adds one field display formatter,
called **Taxonomy Formatter**, for entity-reference fields that point at taxonomy
terms (your "Tags", "Categories", and similar fields). Instead of the plain list
core gives you, it renders the referenced terms inline on one line with a
separator you choose, and optional HTML wrappers and CSS classes so you can style
them as pills, badges, a breadcrumb-like row, or any inline label set.

There is nothing to configure centrally — the module has no settings page, no
permissions, and no admin menu entry. You simply enable it and then pick
"Taxonomy Formatter" as the display format for a term-reference field on the
field's **Manage display** tab, then set the per-field options behind the gear
icon. All output is safely escaped, so term names cannot inject markup.

This guide is written for a **human** setting this up in the admin UI. If you want
a terse, token-cheap reference for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. **How to use it** — below on this page (there is no separate settings page).

## Where it lives in the admin menu

Nowhere of its own — Taxonomy Formatter has no configuration page. Its options
live on each field's display settings under **Structure → Content types →
*(your type)* → Manage display**.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to **Manage display** for the entity/bundle/view mode that shows your
   term-reference field — for example **Structure → Content types → Article →
   Manage display**.
3. In the **Format** column for the term field, choose **Taxonomy Formatter**.
4. Click the **gear icon** on the right to open the options, then set:

   - **Link to term page** — when on, each term becomes a link to its term page;
     when off, terms are plain text.
   - **Separator** — the string placed between terms. Default is `", "`. Include
     any leading/trailing spaces you want, e.g. `" | "`, `" / "`, or `" › "` for a
     breadcrumb look.
   - **Element** — an HTML tag to wrap **each** term in (for example `span` so you
     can style terms as pills, or a heading). *None* leaves the terms unwrapped.
     (Note: two options are mislabeled — the entry shown as "h6" actually outputs
     `<strong>` and the one shown as "h7" outputs `<em>`.)
   - **Element class** — a CSS class added to each per-term element for theming.
   - **Wrapper** — an HTML tag (such as `div`, `p`, or `span`) to wrap the **whole**
     list of terms in. *None* leaves it unwrapped.
   - **Wrapper class** — a CSS class added to that wrapper element.

5. Click **Update**, then **Save** the display.

The referenced terms now render inline with your chosen separator, elements, and
classes. You can set different options per view mode — for example commas in the
teaser and styled pills in the full view.
