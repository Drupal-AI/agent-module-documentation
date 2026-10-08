# Plugin type — `ViewsBuilder` (Views templates)

Managed by `plugin.manager.views_templates.builder`
(`Drupal\views_templates\Plugin\ViewsBuilderPluginManager`):

- Discovery directory: `Plugin/ViewsTemplateBuilder` in any module.
- Annotation: `@ViewsBuilder` (`Drupal\views_templates\Annotation\ViewsBuilder`).
- Interface: `ViewsBuilderPluginInterface`.
- Alter hook: `views_template_builder_info` (invoke `hook_views_template_builder_info_alter(&$definitions)`).
- Cache bin key: `views_template_builder`.

Annotation keys: `id`, `admin_label`, `description`, `base_table`, `derivative`
(deriver class), `module`, `view_template_id`, `replace_values` (map used for placeholder
substitution).

## Two base classes (README)

### `ViewsBuilderBase` — build a View in code
Extend it and override `createView()`. The base `createView()` returns an unsaved
`View::create()` seeded with `id`, `label`, `description` and the annotation `base_table`.
Provide `admin_label`, `description`, `base_table` in the annotation.

```php
namespace Drupal\my_module\Plugin\ViewsTemplateBuilder;

use Drupal\views_templates\Plugin\ViewsBuilderBase;

/**
 * @ViewsBuilder(
 *   id = "node_builder",
 *   admin_label = "Node View",
 *   description = "A node listing",
 *   base_table = "node_field_data",
 * )
 */
class NodeViewBuilder extends ViewsBuilderBase {
  public function createView($options = NULL) {
    $view = parent::createView($options);
    $display = $view->getDisplay('default');
    $display['fields']['title']['id'] = 'title';
    // ...configure the display...
    $view->addDisplay('page');
    return $view; // returned unsaved; the form saves it
  }
}
```

### `ViewsDuplicateBuilderBase` — clone a `*.yml` template
Extend it to build a View from a Views export file. Put the file at
`<module>/views_templates/<view_template_id>.yml` (a plain Views config export). Set
`view_template_id` (and `module`) in the annotation. The loader reads it and
`createView()` overwrites `id`/`label`/`description` from the form values.

```php
/**
 * @ViewsBuilder(
 *   id = "view_duplicator_test",
 *   view_template_id = "simple_view",
 *   module = "my_module",
 *   replace_values = {
 *     "__TITLE" = "Title Changed",
 *     "__TITLE_ID" = "title"
 *   }
 * )
 */
class ViewDuplicator extends ViewsDuplicateBuilderBase {}
```

## Replacements (placeholder substitution)
`replace_values` keys become `__` + `strtoupper(key)` placeholders. In
`alterViewTemplateAfterCreation()` the base recursively walks the loaded template
(`replaceTemplateKeyAndValues()`) and:
- replaces the placeholder anywhere it appears in a **string value** (`str_replace`),
- replaces a value that **equals** the placeholder outright,
- rewrites matching **array keys**,
- if a replacement value is `NULL`, **deletes** that key from the template.

So a template YAML using `label: '__TITLE'` and a `replace_values` of `"__TITLE" = "My View"`
yields a View labelled "My View". Override `alterViewTemplateAfterCreation(array &$view_template, ?array $options)`
to mutate the array further (e.g. `$view_template['display']['default']['display_options']['pager']['options']['items_per_page'] = $options['pager_count'];`).

## Extra form fields
Override `buildConfigurationForm(array $form, FormStateInterface $form_state)` to add fields
(default returns `[]`). Their submitted values arrive in `$options` passed to `createView()` /
`alterViewTemplateAfterCreation()`.

## Interface surface
`ViewsBuilderPluginInterface`: `getBaseTable()`, `getDescription()`, `getAdminLabel()`,
`getDefinitionValue($key)`, `createView($options)`, `buildConfigurationForm()`,
`templateExists()`. `ViewsDuplicateBuilderPluginInterface` adds `getViewTemplateId()`.
For duplicate builders `templateExists()` returns whether the YAML loads (missing file →
`FileNotFoundException`, logged, and the builder is hidden from the list).
