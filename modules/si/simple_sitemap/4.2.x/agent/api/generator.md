# Generate sitemaps & set settings in code

Service `simple_sitemap.generator` (`Drupal\simple_sitemap\Manager\Generator`).

```php
/** @var \Drupal\simple_sitemap\Manager\Generator $g */
$g = \Drupal::service('simple_sitemap.generator');

// Global settings.
$g->getSetting('max_links', 2000);
$g->saveSetting('cron_generate', TRUE);

// Rebuild the queue then generate (or run either alone).
$g->rebuildQueue()->generate();      // $from: 'form' | 'cron' | 'drush' | 'backend'

// Read produced XML of the default sitemap.
$xml = $g->getContent();             // ?string; $g->getDefaultSitemap() for the entity
```

## Per-entity-type / bundle settings — `entityManager()`
```php
$em = $g->entityManager();           // Drupal\simple_sitemap\Manager\EntityManager
$em->enableEntityType('node');
$em->setBundleSettings('node', 'article', [
  'index' => TRUE, 'priority' => 0.5, 'changefreq' => 'weekly',
]);
$em->getBundleSettings('node', 'article');   // array
$em->setEntityInstanceSettings('node', 1, ['index' => FALSE]);  // single entity override
$em->bundleIsIndexed('node', 'article');     // bool
```

## Custom links — `customLinkManager()`
```php
$g->customLinkManager()->add('/my/path', ['priority' => 0.6, 'changefreq' => 'daily']);
```

- All manager methods are chainable (return `$this`).
- `generate()` processes the queue in batches; prefer cron/drush for large sites.
- Settings target the default variant unless you scope via `setVariants()` on the managers.
