# The yoast_seo field

Real-time SEO is driven by a Field API field of type **`yoast_seo`**
(`src/Plugin/Field/FieldType/YoastSeoItem.php`). Adding it to a bundle enables analysis there.

- **Field type** `yoast_seo` — stores focus keyword plus custom `title`/`description` columns.
  Cardinality is forced to 1 (the field storage form hides the cardinality control, see
  `yoast_seo_form_field_storage_config_edit_form_alter()`).
- **Widget** `YoastSeoWidget` — renders the focus-keyword input, live score, analysis list, and
  snippet preview on the entity **Manage form display**.
- **Formatters** `YoastSeoFormatter` / `YoastSeoEmptyFormatter` — output (or hide) the field on
  **Manage display**.

Setup (per README):
1. Add a **Real-time SEO** (`yoast_seo`) field to the content type.
2. On **Manage form display**, enable the Real-time SEO widget, plus the **Meta tags** and
   **URL alias** widgets (all three are required for analysis to work).
3. Works on entity types implementing `ContentEntityInterface` (node, media, block_content) and
   on taxonomy term pages.

The custom `title`/`description` values entered here override Metatag output — see
[../extend/integration.md](../extend/integration.md).
