# Services

## `yoast_seo.manager` — `Drupal\yoast_seo\SeoManager`
Helper for which bundles/fields are SEO-enabled and score interpretation.
```php
$m = \Drupal::service('yoast_seo.manager');
$m->getEnabledBundles();            // entity types/bundles that have a yoast_seo field
$m->getSeoField($entity);           // the yoast_seo FieldItemList on an entity, or NULL
$m->getScoreStatus($score);         // label ('Good'/'Okay'/'Bad'/'Not available') for a score
$m->getScoreRules();                // configured score-threshold => label map
```

## `yoast_seo.entity_analyser` — `Drupal\yoast_seo\EntityAnalyser`
Builds a rendered preview of an entity for client-side analysis.
```php
$a = \Drupal::service('yoast_seo.entity_analyser');
$a->createEntityPreview($entity, $theme = NULL, $view_mode = 'full'); // preview data (title, body, metatags, url)
$a->renderEntity($entity, $theme = NULL, $view_mode = 'full');        // rendered HTML of the entity
```
Uses `EntityPagePreview` and Metatag's manager to assemble what rtseo.js scores.
