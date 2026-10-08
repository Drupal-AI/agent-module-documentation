# Configure the grouped term selection handler

There is no admin settings page. You enable the handler **per entity-reference field** and set its
one option there.

## Enable on a field (UI)

1. Edit a taxonomy term entity-reference field's settings (*Manage fields → your term field → Field
   settings* / the field's *Reference* section).
2. Set **Reference method** to **"Taxonomy term selection (with groups)"**.
3. (Optional) Restrict **Vocabularies** to the target vocabulary/vocabularies as usual.
4. Set **List item prefix** — a 1–5 character string prepended to each child label, repeated once
   per hierarchy depth. Default `-`.

## Config that results

The handler and its settings live on the field config (`field.field.*`), e.g.:

```yaml
settings:
  handler: 'taxonomy_container'
  handler_settings:
    target_bundles:
      tags: tags
    prefix: '-'          # schema: entity_reference_selection.taxonomy_container
    # auto_create / auto_create_bundle are force-hidden by this handler.
```

Set the same via config or code by writing `handler: taxonomy_container` and a `handler_settings`
mapping onto the field.

## Behaviour (from `TermSelection::getReferenceableEntities()`)

- Applies only when **no** `$match` string and **no** `$limit` are passed — i.e. for a plain select
  widget. With autocomplete (match/limit set) it defers to core's flat parent behaviour.
- For each target bundle it calls `loadTree($bundle, 0, NULL, TRUE)`:
  - Terms whose `parent.target_id == '0'` are **root** terms → become the optgroup label
    (`$options[$key][$parent_label]`).
  - Non-root terms are placed under their parent group, label prefixed with
    `str_repeat($prefix, $term->depth)`.
  - Once a root has at least one child, the root itself is removed as a selectable option
    (it becomes a header only).
- Only the **first** level yields optgroups; grandchildren are indented (more prefixes) but still
  live in the same top-level group.
- Term labels are escaped with `Html::escape()` and taken from the context translation.
- Access: a term failing `->access('view')` — and any term whose parent was inaccessible — is
  skipped entirely.
- When multiple bundles are selected, all groups are keyed under the first bundle so core does not
  additionally wrap them in per-bundle optgroups (see the in-code note referencing
  `EntityReferenceItem::getSettableOptions()`).

## Caveat (documented by the maintainer in-code)

`getReferenceableEntities()` intentionally returns grouped option arrays rather than a flat list of
entity labels, which technically diverges from `SelectionInterface`. This is why it only kicks in for
the non-autocomplete (plain select) path; use a select/checkboxes widget, not autocomplete, to get
the grouping.
