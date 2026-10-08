# Enable the Tagify facet widget

The module provides one Facets widget plugin:

- Plugin: `Drupal\tagify_facets\Plugin\facets\widget\TagifyWidget`
- Id: `tagify` (annotation `@FacetsWidget`, label "Tagify")
- Extends `Drupal\facets\Widget\WidgetPluginBase`.

Steps:
1. Enable `tagify_facets` (with `tagify` and `facets`).
2. Go to the facet's edit form (Admin → Configuration → Search and metadata → Facets →
   *Edit*).
3. Under **Widget**, choose **Tagify**.
4. Save. Facet values now render as tag chips via `js/tagify-widget.js`.

Config schema key: `better_exposed_filters` is not involved; the widget config is stored
under the standard Facets `widget` settings. No dedicated settings form.
