# Summary Word Limit — manual setup guide

**Summary Word Limit** (`summary_word_limit`) lets you set a maximum word count on
the **summary** of a *Text (formatted, long, with summary)* field — the same field
type used by the standard **Body** field — and enforces it as a real validation
rule.

Summaries are the short blurbs that show up in teasers, listings, cards and search
results, and most layouts quietly assume they will stay short. Nothing in Drupal
core enforces that, so an editor who pastes three paragraphs into the summary box
gets no warning — and the fallout usually surfaces later as a broken card in a
grid, often noticed by someone other than the person who caused it. This module
closes that gap by giving editors a clear validation error the moment a summary
runs too long.

The implementation is deliberately small and done the correct Drupal way. The limit
is stored as a **third-party setting on the field configuration**, so it lives with
the field rather than on a global settings page — which means you can set a
different limit on each content type's field. Enforcement is a **validation
constraint**, so the rule applies wherever the entity is validated: the node edit
form, yes, but also REST, JSON:API, migrations and programmatic saves. A limit that
only lived in the form would be trivially bypassed by all of those. The module has
no routes, no permissions, and no configuration page of its own; it also has no
dependencies beyond Drupal core.

Because the limit is empty by default, **enabling the module changes nothing on its
own** — it only takes effect once you set a number on a specific field.

This guide is written for a **human** setting the limit through the field UI. If you
are an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

There is no settings page to visit — you configure the limit directly on the field:

1. Go to the field you want to limit. For a content type that is **Structure →
   Content types → [your type] → Manage fields**, then edit the *Text (formatted,
   long, with summary)* field (for example the **Body** field).
2. Make sure **Summary input** is ticked so the summary box is available.
3. Enter a number in **Summary word limit count** — that is the maximum number of
   words allowed in the summary.
4. Save the field settings.

Leave **Summary word limit count** empty to turn the limit off again. From then on,
any attempt to save that entity with an over-length summary — whether from the node
form, an API write, or a migration — will fail validation with an error rather than
silently overflowing your layouts.
