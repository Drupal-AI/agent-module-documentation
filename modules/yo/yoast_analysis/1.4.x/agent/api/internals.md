# Yoast Analysis internals (for custom code)

All classes are in `Drupal\yoast_analysis`. Services are declared in `yoast_analysis.services.yml`.

## Services

| Service id | Class | Role |
|---|---|---|
| `yoast_analysis.text_extractor` | `TextExtractor` | Renders an entity in a view mode to HTML and reads Metatag title/description. |
| `yoast_analysis.route_subscriber` | `Routing\RouteSubscriber` | Adds the `entity.<type>.yoast_analysis_analyse` route for entity types with the link template. |
| `yoast_analysis.access_check` | `Access\AnalysisAccessCheck` | `_yoast_analysis_access` — allows only when a `yoast_analysis` view mode exists for the bundle. |

## Data flow

`Controller\AnalysisController::entityAnalyse()` builds a render array:

```php
['#type' => 'yoast_analysis', '#analysis_data' => AnalysisData::fromEntity($entity)]
```

- `AnalysisData::fromEntity($entity)` uses `TextExtractor`:
  - `getEntityHtml($entity, 'yoast_analysis')` — view-builds the entity in the `yoast_analysis`
    view mode and renders it to a string (this is the analysed text).
  - `getEntityMetatags($entity)` — title = entity label, description = '' by default; if the
    `metatag` module is installed, overrides them from `metatag_get_tags_from_route()`.
  - plus `$entity->toUrl()` and `$entity->language()`.
- `AnalysisData::toArray()` returns `['title','description','base_url','path','text','locale']`.
  `base_url`/`path` come from `Url` (wraps PHP `parse_url` on the absolute entity URL);
  `locale` comes from `Locale::mapLocale()` (maps a Drupal langcode like `en`→`en_US`,
  `nl`→`nl_NL`, …; unknown → `xyz`).

## The `yoast_analysis` render element

`Element\YoastAnalysis` (`@RenderElement("yoast_analysis")`) pre-renders a container holding:
a **keyword** textfield, an **Analyse** button, a snippet-preview sub-render
(`#theme => 'yoast_analysis_snippet_preview'`), and empty `output` / `content_output`
containers. It attaches the `yoast_analysis/analysis` library and sets:

```php
$element['#attached']['drupalSettings']['yoast_analysis']['container_settings'][$id] =
  (object) ['analysis_data' => $element['#analysis_data']->toArray()];
```

The compiled `dist/drupal.js` (YoastSEO.js) reads `drupalSettings.yoast_analysis.container_settings`
and runs the analysis in the browser — nothing is sent server-side or to a third party.

## Theming

`yoast_analysis.module` `hook_theme` defines `yoast_analysis`
(template `templates/yoast-analysis.html.twig`, render element `elements`) and
`yoast_analysis_snippet_preview` (`templates/yoast-analysis-snippet-preview.html.twig`).
`template_preprocess_yoast_analysis_snippet_preview()` generates unique DOM ids
(`Html::getUniqueId`) for the preview containers the JS binds to.

## Extending

- To analyse custom text (not a full entity), construct `AnalysisData` directly:
  `new AnalysisData($title, $metaDescription, $text, $url, $language)` and render a
  `['#type' => 'yoast_analysis', '#analysis_data' => $data]` element.
- To add analysis to a custom entity type, ensure it has a `canonical` link template
  (`EntityTypeInfo` then adds the analyse link) and create/enable a `yoast_analysis` view mode
  for its bundles so `AnalysisAccessCheck` permits the route.
- To add locales, extend `Locale::mapLocale()`'s mapping (langcode → YoastSEO locale).
