<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Per-node override

## Opt a content type in (third-party settings)

On a content type that already has Toc.js enabled (`toc_js.toc_js_active = TRUE`), the Table of
contents section gains two settings, stored as `node.type.<bundle>` third-party settings under
`toc_js_per_node`:

- `override` (bool) — "Permit to enable/disable toc per node". When TRUE the node form shows the
  per-node toggle.
- `override_default` (bool) — the default state for the per-node TOC ("Enabled" = 1 / "Disabled" =
  0).

```php
$type = \Drupal\node\Entity\NodeType::load('article');
$type->setThirdPartySetting('toc_js', 'toc_js_active', TRUE);        // Toc.js must be on
$type->setThirdPartySetting('toc_js_per_node', 'override', TRUE);
$type->setThirdPartySetting('toc_js_per_node', 'override_default', FALSE);
$type->save();
```

Read back: `drush cget node.type.article third_party_settings.toc_js_per_node`.

## The `toc_js_active` base field

`hook_entity_base_field_info()` adds a boolean base field **`toc_js_active`** to every node
(revisionable + translatable, default FALSE). `hook_entity_bundle_field_info()` overrides its default
per bundle to the content type's `override_default` when override is on.

## The node-form toggle

`hook_form_node_form_alter()`: when the node's type has both `toc_js.toc_js_active` and
`toc_js_per_node.override` TRUE, and the user has `administer toc_js per node` or `administer nodes`,
the node edit form shows a **"Display a table of contents"** checkbox (in the Table of contents
group) bound to `toc_js_active`. Without the permission the value is passed through unchanged.

## View behavior

Toc.js's `hook_node_view()` (and the per-node block) check the node's `toc_js_active` when the type
has override on, and skip rendering the TOC when it is empty/false.
