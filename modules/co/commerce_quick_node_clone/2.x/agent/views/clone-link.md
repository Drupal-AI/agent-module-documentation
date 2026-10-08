<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views field: `commerce_quick_node_clone_link`

A Views field handler that renders a per-row "Clone product" link, for building custom product
admin listings.

- Class `CloneLink` (`src/Plugin/views/field/CloneLink.php`), annotation
  `@ViewsField("commerce_quick_node_clone_link")`, extends `FieldPluginBase`. Injects the
  `renderer` service. `query()` is a no-op (it renders from the row entity, adds no SQL).
- **Option:** `text` — the link label. `defineOptions()`/`buildOptionsForm()` expose a "Text to
  display" textfield; default is `Clone product` (`getDefaultLabel()`).
- **`render(ResultRow $values)`:**
  - Gets the row entity via `getEntity($values)`; returns `''` if none.
  - Builds a URL to `commerce_quick_node_clone.node.quick_clone` with `['node' => $entity->id()]`
    and a `\Drupal::destination()` query.
  - Calls `$url->access()` and returns `''` when the current user is denied — so the link only
    shows to users who pass `QuickNodeCloneNodeAccess::cloneNode` (i.e. hold
    `clone <type> content` + create access). No link leaks to users who cannot clone.
  - Renders a `#type => 'link'` element with the configured (or default) title.

## Usage

Add the field to a View whose base is Commerce products (or that exposes the product entity in
the row): edit the View → Add field → "Commerce Quick Node Clone: Clone link" (the
`commerce_quick_node_clone_link` handler) → optionally set the label. Each row then shows a clone
link to authorized users. This is an alternative to the built-in `quick_clone` entity operation
and the `Clone` local task when you maintain a bespoke product listing View.
