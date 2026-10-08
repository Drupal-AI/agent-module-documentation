# Taxonomy Container — manual setup guide

**Taxonomy Container** (`taxonomy_container`) changes how a taxonomy term
reference field is picked in a form. Instead of a flat dropdown or an autocomplete
box, it renders the field as a single `<select>` where each **top‑level (parent)
term becomes an `<optgroup>` heading** and its child terms appear as the
selectable, indented options underneath. The result is a compact dropdown that
shows your vocabulary's structure at a glance — for example a "Section → Topic"
hierarchy where the sections act as non‑selectable group headers and the topics
are what editors actually choose.

It ships as a single **entity‑reference selection handler**. You turn it on per
field by changing the field's **Reference method** to "Taxonomy term selection
(with groups)" — there is no global settings page and no permissions. Once
enabled, it walks each target vocabulary, turns every root term into a group
heading, nests the children beneath it, and prefixes each child label with a
character you choose (a dash by default), repeated once per level of depth so
deeper terms are indented further.

A few practical notes: only the **first** level of the hierarchy produces group
headings — grandchildren are still shown (indented further) but live inside their
top‑level group. Term labels are escaped and access‑checked, so users never see a
term they aren't allowed to view. And because grouped options don't work with
autocomplete, the module deliberately hides the core "create new terms" option and
falls back to normal flat behaviour if the field is used as an autocomplete. Use a
**select** (or checkboxes) widget to get the grouping. It depends only on core's
**Taxonomy** module and runs on Drupal 9, 10, and 11 (PHP 7.4+).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — enable the grouped selection handler
   on a field and set its prefix character.

## Where it lives in the admin menu

There is no admin settings page. You enable and configure the handler per field
under **Structure → [your entity type] → Manage fields**, in the term reference
field's settings.

## How to use it

At a glance: make sure your vocabulary is hierarchical (parent terms with
children), then edit the term reference field and set its **Reference method** to
**"Taxonomy term selection (with groups)"**, optionally adjust the indentation
prefix, and use a select or checkboxes widget on the form. Editors then see a
grouped dropdown. The step‑by‑step is in [Configuration](configuration/index.md).
