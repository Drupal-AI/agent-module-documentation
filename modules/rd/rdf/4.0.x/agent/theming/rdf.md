# RDF — theming & RDFa output

RDF injects RDFa attributes into existing templates rather than adding new page regions.
It works by implementing core preprocess hooks (as `#[Hook]` methods in
`src/Hook/RdfPreprocessHooks.php` and `src/Hook/RdfThemeHooks.php`) and adding attribute
variables.

## Theme hooks
`RdfThemeHooks::theme()` (`#[Hook('theme')]`) registers:
- **`rdf_metadata`** (template `rdf-metadata.html.twig`, variable `metadata` = array of
  attribute arrays) — outputs hidden `<span class="hidden">` RDFa for values not otherwise
  visible in markup.
- **`rdf_wrapper`** (template `rdf-wrapper.html.twig`, variables `attributes`, `content`) —
  wraps content in a `<span>` carrying RDFa attributes.

Preprocessor: `RdfThemeHooks::preprocessRdfMetadata()` (`#[Hook('preprocess_rdf_metadata')]`)
converts each metadata item into a `Drupal\Core\Template\Attribute` object.

## Preprocess hooks it implements (`RdfPreprocessHooks`)
- `preprocess_html` — adds RDF namespace `prefix` attributes to `<html>`.
- `preprocess_node`, `preprocess_user`, `preprocess_comment`,
  `preprocess_taxonomy_term`, `preprocess_username`,
  `preprocess_field__node__uid`, `preprocess_image` — add `typeof`, `property`, `rel`,
  `about`, `content` RDFa attributes to the relevant `$attributes` / `$title_attributes` /
  `$content_attributes` / `$item_attributes` template variables. `preprocess_image` tags
  images with `typeof="foaf:Image"`.
- `preprocess_views_view_rss` — adds `xmlns:*` namespaces to RSS output.

Data staging (in `RdfHooks`): `entity_prepare_view` prepares field `_attributes`, and
`comment_storage_load` caches comment date/URI data used by `preprocess_comment`.

## Customizing
- Override `rdf-metadata.html.twig` / `rdf-wrapper.html.twig` in your theme to change how
  hidden metadata is emitted.
- The RDFa attributes themselves come from the bundle's mapping — change output by
  editing the mapping ([../configure/rdf.md](../configure/rdf.md)), not the templates.
- Core themes are already RDFa-compatible; custom themes should preserve the
  `*_attributes` variables in their entity templates.
