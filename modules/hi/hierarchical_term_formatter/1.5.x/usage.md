<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Hierarchical Term Formatter is a field formatter for taxonomy-term reference fields that renders a term together with its ancestry, e.g. `Parent » Child`, instead of just the referenced term.

---

The module adds a single field formatter, `hierarchical_term_formatter`, available on any `entity_reference` field whose target type is `taxonomy_term` (it declares `isApplicable()` accordingly). For each referenced term it walks the taxonomy tree with `TermStorage::loadAllParents()` and renders a configurable slice of that lineage. The **Terms to display** setting chooses which part of the tree: `all` (the term and every ancestor), `grouping` (merge siblings that share a parent), `parents` (ancestors only), `root` (just the topmost term), `nonroot` (everything except the root), or `leaf` (just the selected term). Additional settings control whether each term is a **link** to its term page, the **separator** between terms (default ` » `), a **wrapper** element around each term (`none`, `span`, `div`, or `li` inside `ul`/`ol`), and **reverse** order (children first). Output goes through the `hierarchical_term_formatter` theme hook and `hierarchical-term-formatter.html.twig`. It provides no config UI page of its own — everything is set per field on the entity's *Manage display* page and stored in the `entity_view_display` config. Settings are validated by `field.formatter.settings.hierarchical_term_formatter` schema.

---

- Show a node's category as a full path like `News » Politics » Elections` instead of just the leaf term.
- Display only the ancestor terms (`parents`) as a breadcrumb-style trail above content.
- Render just the **root** term of each reference to group content by top-level section.
- Show non-root terms only (`nonroot`) to hide the vocabulary's topmost bucket.
- Link every term in the hierarchy to its taxonomy term page for navigation.
- Use a custom separator (e.g. ` > `, ` / `, or `→`) between the terms in the trail.
- Wrap each term in `<span>` or `<div>` for CSS styling of the hierarchy.
- Output the hierarchy as an ordered/unordered list (`<ul><li>…`) for structured markup.
- Reverse the order so the selected term comes first and ancestors follow.
- Group multiple referenced terms that share a common parent under that parent once.
- Present a product's category lineage on a commerce product display.
- Show a document's classification path on a knowledge-base article.
- Build a "you are here" style term path on a listing page field.
- Display the topmost region term for location-tagged content.
- Render taxonomy hierarchy on non-node entities (media, users, custom entities) that reference terms.
- Provide plain-text ancestry (no links) for print or export view modes.
- Standardise term display across view modes by configuring the formatter per mode.
- Show the parent category as context next to the specific tag.
- Replace a flat term list with a readable nested path in teasers.
- Give editors a preview of where a term sits in the vocabulary when rendered.
- Configure separator and wrapper via exported `entity_view_display` config for deployment.
- Display just the leaf term but keep the option to switch to full hierarchy later without code.
- Show ancestry for multi-valued term fields, each reference rendered as its own path.
- Emphasise site structure by surfacing top-level taxonomy on every tagged page.
