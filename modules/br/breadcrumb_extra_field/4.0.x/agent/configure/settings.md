# Configure Breadcrumb Extra Field

Setup is **two steps**: (1) enable the field for the entity type/bundle in the module settings,
then (2) place the "Breadcrumb" field on that bundle's *Manage display*.

## Step 1 — enable bundles (settings form / config)

Form `breadcrumb_extra_field.settings` at **`/admin/config/system/breadcrumb-extra-field`**
(permission **`administer breadcrumb extra field`**). It lists every fieldable entity type that
has a canonical link, with a checkbox per bundle. Saving writes to config
`breadcrumb_extra_field.settings:breadcrumb_extra_field_admin`, a nested map:

```yaml
breadcrumb_extra_field_admin:
  node:
    article: article      # enabled  (truthy)
    page: 0               # not enabled
  taxonomy_term:
    tags: tags
```

`hook_entity_extra_field_info()` then exposes a **display** extra field `breadcrumb`
(label "Breadcrumb", `visible: FALSE`) on each enabled bundle. Changing this config must
invalidate the `entity_field_info` cache tag — the form does it (`Cache::invalidateTags(['entity_field_info'])`);
in code call the same, or `drush cr`.

### Enable via drush/code

```php
\Drupal::configFactory()->getEditable('breadcrumb_extra_field.settings')
  ->set('breadcrumb_extra_field_admin', ['node' => ['article' => 'article']])
  ->save();
\Drupal\Core\Cache\Cache::invalidateTags(['entity_field_info']);   // or drush cr
```

```bash
drush cget breadcrumb_extra_field.settings breadcrumb_extra_field_admin
```

## Step 2 — place the field on Manage display

The extra field starts **hidden**. On the bundle's *Manage display*
(e.g. `/admin/structure/types/manage/article/display`) drag **Breadcrumb** out of *Disabled*
into the content region at the weight you want, and Save. In config that adds a `breadcrumb`
component to the `entity_view_display`:

```php
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')->load('node.article.default');
$vd->setComponent('breadcrumb', ['weight' => -50, 'region' => 'content'])->save();
// remove it again: $vd->removeComponent('breadcrumb')->save();
```

## How it renders

`hook_entity_view()` checks `$display->getComponent('breadcrumb')`; if present it sets
`$build['breadcrumb'] = \Drupal::service('breadcrumb')->build(\Drupal::routeMatch())->toRenderable();`
— i.e. the site's normal breadcrumb, now rendered inline among the entity's fields. No separate
breadcrumb configuration; it inherits the site breadcrumb builder and any module alterations.
