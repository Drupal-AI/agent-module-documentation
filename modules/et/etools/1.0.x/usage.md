<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Etools is a small toolbox of developer helpers for Drupal: an entity helper service, two matching Twig functions, and four field formatters.

---

Etools bundles a handful of small, unrelated utilities for developers and site builders. The `etools.entity`
service exposes two convenience methods for working with content entities — `getFieldValue()` (read a field's
value, single or multi-valued, without hand-writing the iteration) and `getFieldDisplay()` (render a field with
an access check and cacheability applied). A companion Twig extension surfaces both as the `etools_field_value`
and `etools_field_display` Twig functions for use in templates. On top of that it ships four field formatters:
`etools_er_subset` and `etools_err_subset` render only a subset of referenced entities (limited by bundle and/or
count), `etools_entity_reference_link` renders each referenced entity's label as a link to a configurable URL
carrying the entity id as a query parameter, and `etools_text_linked` renders a string field linked to a URL
taken from a companion link field on the same entity. There are no routes, forms (beyond formatter settings),
permissions, config objects, or hooks — you enable the module and use whichever pieces you need.

---

- Read a single-valued field's value in a template with `etools_field_value(node, 'field_subtitle')`.
- Read a multi-valued field as an array with `etools_field_value(node, 'field_tags', 'target_id')`.
- Fetch a specific field property (e.g. `target_id`, `value`) without writing the property loop by hand.
- Render a field with access + cache metadata applied via `etools_field_display(node, 'body')`.
- Render a field using a specific view mode: `etools_field_display(node, 'field_image', 'teaser')`.
- Render a field with an ad-hoc display configuration array instead of a named view mode.
- Call the same helpers from PHP through `\Drupal::service('etools.entity')`.
- Display only the first referenced entity of a multi-value reference field (allowed count = 1).
- Display only referenced entities of certain bundles (e.g. show only `article` references).
- Limit a rendered entity-reference field to a maximum number of items on a given view display.
- Apply the subset limit to plain entity_reference fields with the `etools_er_subset` formatter.
- Apply the subset limit to entity_reference_revisions (e.g. Paragraphs) fields with `etools_err_subset`.
- Turn a taxonomy-term reference field into links to a listing page pre-filtered by term id.
- Link each referenced entity's label to `/my-view?tag=ENTITY_ID` for a filter-pre-applied landing page.
- Configure the destination path and query-parameter key of those links per view display.
- Render a plain text/string field as a link whose URL comes from a separate link field on the entity.
- Show a title string linked to a "read more" URL stored in a companion link field, or plain when empty.
- Keep template logic thin by moving field access/rendering into a reusable service call.
- Build component/SDC or Twig-based themes that need field values without preprocess boilerplate.
- Use `getFieldValue()` as a null-safe accessor that returns NULL when a field is absent on the entity.
- Standardise "label linked to filtered list" patterns across content types with one formatter.
- Combine the subset formatters with Paragraphs to preview only the first N components of a stack.
- Enable only the module and pick the individual formatters per field via Manage display.
