<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `product_file` field and "Product download" formatter

## The auto-created field

When a product type is marked **Downloadable**, `_arch_downloadable_product_add_file_field()`
(`arch_downloadable_product.module`) creates, if missing:

- **Field storage** `product.product_file` — type `file`, `entity_type: product`,
  `uri_scheme: private`, `display_field: false`, `cardinality: -1` (unlimited), `translatable: false`.
- **Field instance** on the toggled bundle, label *File*.
- **Form display** — widget `file_generic`.
- **View display** (default) — formatter `arch_downloadable_product`.

Turning the toggle off calls `_arch_downloadable_product_remove_file_field()` which deletes the
instance (storage stays until the last bundle drops it). The field's delete UI is disabled (see
`RouteSubscriber` / `field_config_edit_form_alter`) so it cannot be removed by hand while in use.

## The "Product download" formatter

`ProductDownloadFormatter` (`src/Plugin/Field/FieldFormatter/ProductDownloadFormatter.php`):

```
@FieldFormatter(
  id = "arch_downloadable_product",
  label = @Translation("Product download"),
  field_types = { "file" }
)
```

- `isApplicable()` — only offered on a `file` field named **`product_file`** on the **`product`**
  entity type.
- Extends core `DescriptionAwareFileFormatterBase`, so it inherits the
  `use_description_as_link_text` setting.
- `viewElements()` iterates `getEntitiesToView()` and, **per file**, calls
  `ProductFileAccess::check($product, $file, $currentUser)`; files the viewer is not entitled to are
  skipped (no link). For entitled files it builds a `#type => link` to
  `DownloadUrlBuilder::getDownloadUrl()` (the signed `pdtok` URL), with cache tags merged from the
  file, product and user. Link text is the file label (`#markup => $file->label()`), optionally
  followed by the item description when `use_description_as_link_text` is on.

Because entitlement is re-checked at display time and again at download time, an unentitled visitor
sees no link and, even with a hand-crafted URL, is denied by `downloadAccess()`.
