# Display variants

A page_variant's `variant` key is a core/CTools **DisplayVariant** plugin id (Page Manager does
*not* define its own plugin type — it ships plugins of the existing `Display/VariantBase` type
and consumes them). Shipped variants (`src/Plugin/DisplayVariant/`):

| Plugin id | Class | Renders |
|---|---|---|
| `block_display` | `PageBlockDisplayVariant` | Blocks placed into a selected layout, region by region. Config in `variant_settings` (blocks, layout, region assignments). |
| `http_status_code` | `HttpStatusCodeDisplayVariant` | Returns a bare HTTP status (e.g. 403/404/500) for the matched route. |
| `layout_builder` | `LayoutBuilderDisplayVariant` | Delegates to core **Layout Builder** (via `Plugin/SectionStorage/PageManagerSectionStorage`). |

The contrib **Panels** module adds a `panels_variant` with selectable layouts and drag-drop
blocks.

## Add your own
Create a plugin in `src/Plugin/DisplayVariant/` implementing
`Drupal\Core\Display\VariantInterface` (extend `VariantBase`, or
`BlockDisplayVariant` / `PageManager`'s `PageBlockDisplayVariant` to reuse block handling):

```php
#[Display\VariantAttribute(
  id: 'my_variant',
  admin_label: new TranslatableMarkup('My variant'),
)]
class MyVariant extends VariantBase {
  public function build() {
    return ['#markup' => 'Hello'];
  }
}
```

It then appears in the "Variant type" dropdown when adding a variant. Variants receive the
page's contexts (see [api/contexts.md](../api/contexts.md)) so `build()` can use route/user
context.
