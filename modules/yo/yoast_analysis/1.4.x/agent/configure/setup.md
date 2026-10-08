# Set up Yoast Analysis on an entity

There is no settings form. Analysis is enabled entirely by whether a **`yoast_analysis` view
mode** exists (and is enabled) for a bundle.

## Steps

1. Enable the module (`drush en yoast_analysis -y`). This is already done on this site.
2. The module registers a view mode key `yoast_analysis`. Enable it for the bundle you want to
   analyse: *Structure → Display modes → View modes* has (or add) a `yoast_analysis` view mode,
   then on the bundle's **Manage display** turn on the "Yoast analysis" custom display and choose
   which fields (and their order) feed the analysed HTML. Only the fields shown in this view mode
   are sent to the analyzer.
3. Edit or view an entity of that bundle. An **SEO Analysis** local task tab appears next to
   *View/Edit* (and as an entity operation in content lists). It is visible only to users with
   `update` access to that entity.

Enable the view mode with Drush:

```php
// drush php:eval — enable the yoast_analysis view mode display for node.article.
$vm = \Drupal::entityTypeManager()->getStorage('entity_view_display')->load('node.article.yoast_analysis')
  ?? \Drupal::entityTypeManager()->getStorage('entity_view_display')->create([
       'targetEntityType' => 'node', 'bundle' => 'article', 'mode' => 'yoast_analysis', 'status' => TRUE,
     ]);
$vm->setStatus(TRUE)->save();
```

(If the `yoast_analysis` view mode entity itself doesn't exist yet, create it under
*Structure → Display modes → View modes → Add view mode* for the target entity type first.)

## Route & access model

- Route name `entity.<entity_type>.yoast_analysis_analyse`, path
  `/yoast_analysis/{entity_type}/{id}` — added at runtime by `RouteSubscriber::alterRoutes()` for
  every entity type whose definition has a `yoast-analysis-analyse` link template.
- `EntityTypeInfo::entityTypeAlter()` gives that link template to **every entity type with a
  `canonical` link**, so the analyse route potentially exists for nodes, terms, users, media, etc.
- Two access requirements must both pass:
  - `_entity_access: <entity_type>.update` — the current user must be able to edit the entity.
  - `_yoast_analysis_access: TRUE` → `AnalysisAccessCheck` — allowed **only** if the entity's
    bundle has a `yoast_analysis` view mode. No view mode = the tab/route is forbidden (this is
    the on/off switch).
- The route is flagged `_admin_route: TRUE`.

## Dependencies

- Core only for the analysis itself. **Metatag** is optional: if present, `TextExtractor`
  reads the route's `title` and `description` meta tags for the snippet preview; otherwise title
  falls back to the entity label and description is empty.
