<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# bundle_form plugin API

The whole module is one plugin type plus the glue that dispatches an entity form to the matching plugins. No config, no UI.

## Install / enable

`drush en bundle_form`. Enabling it changes node and taxonomy-term form handlers immediately (see `entityTypeBuild`). Rebuild caches after adding new plugins so the plugin manager re-discovers them (`drush cr`). To try the shipped examples: `drush en bundle_form_examples`.

## The plugin type

- Manager service: `plugin.manager.bundle_form` → `Drupal\bundle_form\BundleFormPluginManager` (extends `DefaultPluginManager`).
  - Discovery subdir: `Plugin/BundleForm`. Interface: `BundleFormInterface`. Annotation: `Drupal\bundle_form\Annotation\BundleForm`.
  - Alter hook: `bundle_form_info`. Cache: `bundle_form_plugins` bin key.
  - `createInstance()` returns `NULL` on `PluginNotFoundException` instead of throwing.
  - `fetchInstances(string $entityType, string $bundle): array` — returns instances whose definition matches BOTH `entity_type` and `bundle` (definitions with empty entity_type+bundle are skipped), sorted by ascending `weight`.
- Base class: `BundleFormPluginBase` (extends `PluginBase`); provides `label()` returning the annotation label cast to string. Implement `overrideForm()` yourself.
- Interface `BundleFormInterface`: `label()` and
  `overrideForm(array &$form, FormStateInterface $form_state, ?EntityInterface $entity = NULL): void`.

## Annotation keys (`@BundleForm`)

`id` (plugin id), `title` / `label` (Translation), `entity_type` (string, e.g. `node`, `taxonomy_term`, `paragraph`), `bundle` (string machine name), `weight` (int; lower runs first).

## How dispatch happens

- **Node / taxonomy_term:** `EntityHooks::entityTypeBuild()` replaces the `default` and `edit` form classes with `Form\NodeForm` / `Form\TermForm`. Both are thin subclasses of the core forms that mix in `BundleFormTrait`. `BundleFormTrait::create()` injects the manager; `BundleFormTrait::buildForm()` calls `parent::buildForm()` first, then
  `bundleFormPluginManager->fetchInstances($this->entity->getEntityTypeId(), $this->entity->bundle())` and invokes each plugin's `overrideForm($form, $form_state, $this->entity)`.
- **Paragraph:** `FormHooks::fieldWidgetSingleElementFormAlter()` (`#[Hook('field_widget_single_element_form_alter')]`) fires for every single-element widget; it bails unless `$context['widget']` is a `ParagraphsWidget`, `$context['items']` is a `FieldItemListInterface`, and `$element['#paragraph_type']` is set. It then `fetchInstances('paragraph', $element['#paragraph_type'])`, stashes the widget `$context` via `$form_state->set('context', $context)`, and calls each plugin's `overrideForm($element, $form_state)` — here `$element` is the paragraph subform element, and `$entity` is not passed (null).

## Writing a plugin

Place the class at `src/Plugin/BundleForm/{EntityTypeStudly}/{Name}Form.php` in your module (folder is organizational only — dispatch keys off the annotation, not the path):

```php
namespace Drupal\my_module\Plugin\BundleForm\Node;

use Drupal\Core\Entity\EntityInterface;
use Drupal\Core\Form\FormStateInterface;
use Drupal\bundle_form\Annotation\BundleForm;
use Drupal\bundle_form\BundleFormPluginBase;

/**
 * @BundleForm(
 *   id = "my_module_article",
 *   entity_type = "node",
 *   bundle = "article",
 *   weight = 10,
 *   label = @Translation("Article form override"),
 * )
 */
class ArticleForm extends BundleFormPluginBase {
  public function overrideForm(array &$form, FormStateInterface $form_state, ?EntityInterface $entity = NULL): void {
    // Mutate the render array: add/remove elements, reorder, toggle #access,
    // attach $form['actions']['submit']['#submit'][] = ..., etc.
    $form['field_promo']['#weight'] = -50;
  }
}
```

- Need service injection? Since the base only extends `PluginBase`, add `ContainerFactoryPluginInterface` + a `create()` to your plugin, or inject via `\Drupal::service()` sparingly.
- Ordering: give an earlier-running plugin a lower `weight`; a later, higher-weight plugin can override the earlier one's changes on the same bundle.
- Paragraph plugins: reach the subform via `$form['subform']` and the widget context via `$form_state->get('context')`; `$entity` is null there.

## Adding a new entity type

For an entity type whose form is a normal `ContentEntityForm` subclass, create `Form\MyTypeForm extends CoreMyTypeForm { use BundleFormTrait; }` and set it as the `default`/`edit` form class in a `hook_entity_type_build` (mirror `EntityHooks::entityTypeBuild`). No change to the plugin type is needed.
