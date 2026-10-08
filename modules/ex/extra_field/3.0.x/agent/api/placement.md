<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Placing, reading and rendering an extra field

## Where it lives in config

An extra field is just a component of an entity display, named
`extra_field_<plugin_id>`:

```yaml
# core.entity_view_display.node.article.default
content:
  extra_field_my_teaser_note:
    weight: 10
    region: content
# …or, when disabled:
hidden:
  extra_field_my_teaser_note: true
```

Form plugins use `core.entity_form_display.<entity>.<bundle>.<mode>` with the same key
shape. There is no `settings` / `type` — extra fields have neither formatter nor widget.

## Place it with Drush

```php
drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("extra_field_my_teaser_note", ["weight" => 10, "region" => "content"])->save();

  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("extra_field_my_note", ["weight" => 50, "region" => "content"])->save();
'
```

Remove it (writes `hidden: true`, which also stops `visible: true` plugins from being
re-added by `EntityDisplayBase::init()`):

```php
drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->removeComponent("extra_field_my_teaser_note")->save();
'
```

## Read what is available / what is placed

```bash
# every pseudo-field (core + contrib) for a bundle
drush php:eval '$e = \Drupal::service("entity_field.manager")->getExtraFields("node","article");
  print implode(", ", array_keys($e["display"] ?? [])) . "\n";
  print implode(", ", array_keys($e["form"] ?? [])) . "\n";'

# just this module's plugins
drush php:eval 'print implode(", ", array_keys(\Drupal::service("plugin.manager.extra_field_display")->getDefinitions())) . "\n";'
drush php:eval 'print implode(", ", array_keys(\Drupal::service("plugin.manager.extra_field_form")->getDefinitions())) . "\n";'

# what is actually placed
drush cget core.entity_view_display.node.article.default content
drush cget core.entity_form_display.node.article.default content
```

## In the UI

*Structure → Content types → Article → Manage display* (or *Manage form display*). Extra
fields appear as ordinary rows with a label and description but **no** formatter/widget
select and no cog. Drag between *Content* and *Disabled* to enable/disable.

## Rendering in Twig

The render array is placed under `content.extra_field_<plugin_id>`:

```twig
{# node--article.html.twig #}
{{ content.extra_field_my_teaser_note }}
```

## The two manager APIs

`plugin.manager.extra_field_display` (`ExtraFieldDisplayManagerInterface`):

| method | purpose |
|---|---|
| `fieldInfo()` | `[entity][bundle]['display'][extra_field_<id>] = ['label','description','weight','visible']` — fed into `hook_entity_extra_field_info()` |
| `entityView(array &$build, ContentEntityInterface $entity, EntityViewDisplayInterface $display, string $viewMode)` | instantiates matching plugins whose component is enabled and writes `$build[extra_field_<id>]` |
| `clearCache()` | clears the in-memory entity-bundle cache |

`plugin.manager.extra_field_form` (`ExtraFieldFormManagerInterface`) mirrors it with
`fieldInfo()` (context `'form'`) and
`entityFormAlter(array &$form, FormStateInterface $formState)`.

Both extend `DefaultPluginManager`, so `getDefinitions()`, `hasDefinition()`,
`createInstance()` are available as usual.

## Module hook implementations

| hook | what it does |
|---|---|
| `hook_entity_extra_field_info()` | merges both managers' `fieldInfo()` |
| `hook_entity_view()` | delegates to the display manager's `entityView()` |
| `hook_form_alter()` | delegates to the form manager's `entityFormAlter()` |
| `hook_entity_bundle_create()` | `clearCache()` on both managers |
