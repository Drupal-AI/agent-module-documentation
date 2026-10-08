# Programmatic API — services & cloning flow

The module ships no public "do this" helper functions; you consume it by (a) registering a
`@ViewsBuilder` plugin (see [plugins](../plugins/views_templates.md)) and (b) using the
builder manager / loader to instantiate a View.

## Services (`views_templates.services.yml`)

| Service id | Class | Purpose |
|---|---|---|
| `plugin.manager.views_templates.builder` | `ViewsBuilderPluginManager` | Discovers & instantiates `@ViewsBuilder` plugins |
| `views_templates.loader` | `ViewsTemplateLoader` | Loads a `*.yml` template from a module's `views_templates/` dir |
| `logger.channel.views_templates` | (logger channel) | Logs template-load failures |

## Instantiate a template and create a View in code

```php
/** @var \Drupal\views_templates\Plugin\ViewsBuilderPluginManager $manager */
$manager = \Drupal::service('plugin.manager.views_templates.builder');

// List available builders:
$definitions = $manager->getDefinitions();

// Build one (plugin id = the @ViewsBuilder id):
$builder = $manager->createInstance('view_duplicator_test');

if ($builder->templateExists()) {
  // Options become the new View's identity + any custom form values.
  $view = $builder->createView([
    'id' => 'my_new_view',
    'label' => 'My New View',
    'description' => 'Cloned from a template',
    // ...plus any keys your buildConfigurationForm() added...
  ]);
  $view->save(); // createView() returns an UNSAVED View entity
}
```

`createView()` returns `\Drupal\views\ViewEntityInterface` (unsaved) — or `NULL` for a
duplicate builder whose template file is missing — so you can adjust it before `save()`.

## The template loader — `views_templates.loader`

`ViewsTemplateLoader::load(ViewsDuplicateBuilderPluginInterface $builder)`:
- resolves `<provider module path>/views_templates/<view_template_id>.yml`,
- `Yaml::decode()`s it into an array (statically cached per template id),
- throws `Symfony\...\File\Exception\FileNotFoundException` if the file is absent.

You normally don't call it directly — `ViewsDuplicateBuilderBase::loadTemplate()` calls it,
catches the exception, logs it via `logger.channel.views_templates`, and applies replacements.

## Alter hook

`hook_views_template_builder_info_alter(array &$definitions)` — add/modify/remove builder
plugin definitions (alter name `views_template_builder_info`).
