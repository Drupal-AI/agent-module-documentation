# RDF — theming & RDFa output

RDF injects RDFa attributes into existing templates rather than adding new page regions.
It works by implementing core preprocess hooks and adding attribute variables.

## Theme hook
`rdf_theme()` registers **`rdf_metadata`** (template `rdf-metadata.html.twig`,
variables `metadata` = array of attribute arrays). Preprocessor:
`template_preprocess_rdf_metadata()`. Also ships `rdf-wrapper.html.twig`. Used to output
hidden `<span>`/`<meta>`-style RDFa for values not otherwise visible in markup.

## Preprocess hooks it implements
- `rdf_preprocess_html()` — adds root namespace/prefix attributes to `<html>`.
- `rdf_preprocess_node()`, `rdf_preprocess_user()`, `rdf_preprocess_comment()`,
  `rdf_preprocess_taxonomy_term()`, `rdf_preprocess_username()`,
  `rdf_preprocess_field__node__uid()`, `rdf_preprocess_image()` — add `typeof`,
  `property`, `rel`, `about`, `content` RDFa attributes to the relevant
  `$attributes` / `$title_attributes` / `$content_attributes` / `$item_attributes`
  template variables.
- `rdf_preprocess_views_view_rss()` — enriches RSS output.
- `rdf_entity_prepare_view()` / `rdf_comment_storage_load()` — stage data used above.

## Customizing
- Override `rdf-metadata.html.twig` / `rdf-wrapper.html.twig` in your theme to change how
  hidden metadata is emitted.
- The RDFa attributes themselves come from the bundle's mapping — change output by
  editing the mapping ([../configure/rdf.md](../configure/rdf.md)), not the templates.
- Core themes are already RDFa-compatible; custom themes should preserve the
  `*_attributes` variables in their entity templates.
