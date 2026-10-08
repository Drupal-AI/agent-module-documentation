<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How it works (library + widget behavior)

The module is essentially one hook + one asset library. There is nothing to configure.

## The library attachment

`paragraphs_collapsible.module` implements a single hook:

```php
function paragraphs_collapsible_library_info_alter(&$libraries, $extension) {
  if ($extension == 'paragraphs' && isset($libraries['drupal.paragraphs.admin'])) {
    $libraries['drupal.paragraphs.admin']['dependencies'][] =
      'paragraphs_collapsible/paragraphs_collapsible.widget';
  }
}
```

So wherever Paragraphs attaches its `drupal.paragraphs.admin` library (the paragraphs admin
widget), this module's library loads too. The library
`paragraphs_collapsible/paragraphs_collapsible.widget` (`*.libraries.yml`) is:

- JS: `js/paragraphs_collapsible.widget.js`
- CSS: `css/paragraphs_collapsible.widget.css`
- Dependencies: `core/jquery`, `core/once`

## Which widget it targets

Only the **classic** Paragraphs table widget, whose form-element id is
`entity_reference_paragraphs` and whose wrapper class is
`.field--widget-entity-reference-paragraphs`. The behavior iterates
`.field--widget-entity-reference-paragraphs table.field-multiple-table`. It does **not** enhance
the modern `paragraphs` (stable) widget, which has its own collapse behavior. So to get the
collapsible feature on a paragraphs field, that field's form display must use the
`entity_reference_paragraphs` widget.

## What the JS adds

`Drupal.behaviors.paragraphs` (in this module's JS), using `once()`:

- Skips any widget table with **no** `.paragraph-type-title` rows.
- For each paragraph row that has a title and a `.paragraphs-subform`, appends a per-row toggle
  button `<button class="paragraph-item-toggle" …>` showing `[+]` (collapsed) or `[-]` (expanded),
  with `aria-expanded` and `aria-label` ("Expand row" / "Collapse row").
- Appends an overarching `<button class="paragraph-toggle">` to the field label reading
  **"Expand all"** / **"Collapse all"**.
- Auto-expands rows that contain a `.error` element or freshly `.ajax-new-content`.
- Clicking a row toggle folds/unfolds that row's subform; clicking the field-label button
  expands/collapses all rows in that field.

CSS classes involved: `.paragraph-toggle`, `.paragraph-item-toggle`, `.expanded`,
`data-paragraph-reference`, `data-row-reference`. To restyle, override
`css/paragraphs_collapsible.widget.css` in your theme. No render/theme hooks or templates are
provided — it is pure library + client-side behavior.
