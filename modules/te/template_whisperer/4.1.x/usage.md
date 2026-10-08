<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Template Whisperer lets editors pick a named "suggestion" from a field on an entity, and turns that choice into extra Twig theme suggestions (like `node--article--news_list.html.twig` or `page--node--news_list.html.twig`) so a theme can render that content with an alternate template.

---

A "suggestion" here is a small configuration entity with a human name and a machine name (validated to `[a-z0-9_]`); you create them at `admin/structure/template-whisperer`. You then attach the module's own **Template Whisperer** field type to a bundle — a single-value select widget (cardinality is forced to one) whose options are the declared suggestions, optionally restricted per field. When Drupal renders a node that has a chosen suggestion, `hook_theme_suggestions_alter()` appends the suggestion — but never bare: it is always **prefixed with the entity's type, bundle, id and (for entity renders) the view mode**. So for an `article` node 1 rendered in `teaser`, the entity render adds `node--article--<suggestion>`, `node--1--article--<suggestion>`, `node--article--teaser--<suggestion>` and `node--1--article--teaser--<suggestion>`; the full-page render adds `page--node--<suggestion>` and `page--node--1--<suggestion>`. A theme provides whichever of those template files it wants; **if no matching file exists the choice silently falls back to the default template** — the single commonest confusion this pattern produces. The module also ships a block visibility **Condition** ("the node has suggestion X"), full **Token** support including a chained `[suggestion:lookup:<machine>:entity:...]` that resolves to the first entity using a suggestion (handy for content-driven Pathauto patterns), a `tw_suggestion_entities()` Twig function, and a usage-tracking table surfaced on each suggestion's "Used in" page. Access: the admin UI and suggestion CRUD need `administer template whisperer suggestion entities`; editing the field on content needs `administer the template whisperer field` (or `bypass node access` / `administer content types`). Core requirement is `^11.1 || ^12` — Drupal 11.1+ only. A template choice is stored on the entity, so it exports, translates, revisions and migrates with the content, and needs a decision when a suggestion is deleted while content still references it.

---

- Let editors choose a page template per node.
- Offer a long-read layout as an option on articles.
- Add a photo-essay presentation for a content type.
- Provide a distinct landing-page template editors can select.
- Formalise theme suggestions instead of a bespoke `hook_theme_suggestions_node_alter()`.
- Make the set of available templates a listable, exportable configuration set.
- Drive an alternate `page--node--<suggestion>.html.twig` full-page layout from content.
- Drive a per-view-mode `node--<bundle>--<view_mode>--<suggestion>` template.
- Give one content type several interchangeable presentations.
- Let a campaign or seasonal page differ from the default node template.
- Support a design system's named page types (news list, contact, directory).
- Show or hide a block only when a node carries a chosen suggestion (Condition plugin).
- Build content-driven Pathauto patterns via `[suggestion:lookup:...:entity:url:path]`.
- Expose the suggestion machine name or display name through tokens.
- Look up, from Twig, which entities use a given suggestion (`tw_suggestion_entities()`).
- Track and audit where each suggestion is used across the site.
- Restrict which suggestions a given field instance may offer.
- Support a magazine's article variants without hardcoding node IDs in templates.
- Let translators keep a per-language template choice on translatable content.
- Provide editors a print-oriented or minimal template alternative.
- Support a multi-brand theme by switching templates per node.
- Replace a taxonomy-term-as-layout-proxy convention with an explicit picker.
- Keep template options discoverable and documented for the editorial team.
- Prevent hardcoding of node URLs when rendering blocks in custom templates.
