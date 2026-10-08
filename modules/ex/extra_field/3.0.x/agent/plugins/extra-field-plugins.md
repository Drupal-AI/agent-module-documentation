<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Writing Extra Field plugins

## Where the class goes

| Plugin type | Directory inside your module | Interface |
|---|---|---|
| Display | `src/Plugin/ExtraField/Display/` | `Drupal\extra_field\Plugin\ExtraFieldDisplayInterface` |
| Form | `src/Plugin/ExtraField/Form/` | `Drupal\extra_field\Plugin\ExtraFieldFormInterface` |

After adding a class run `drush cr` — discovery is cached
(`extra_field_display_plugins` / `extra_field_form_plugins` in the `discovery` bin).

## Definition keys

Same set for both attribute (`#[ExtraFieldDisplay(...)]`) and annotation
(`@ExtraFieldDisplay(...)`):

| key | type | default | meaning |
|---|---|---|---|
| `id` | string | required | plugin id; pseudo-field name becomes `extra_field_<id>` |
| `label` | Translation | – | shown on *Manage display* |
| `description` | Translation | `''` | shown on *Manage display* |
| `bundles` | string[] | `[]` | `entity_type.bundle`, `entity_type.*`, or `*.*` |
| `weight` | int | `0` (annotation) / `NULL` (attribute) | default row weight |
| `visible` | bool | `false` | enabled by default on displays that have never been saved with this component |

`bundles` matching (`ExtraFieldManagerBase`):
* `node.article` → exactly that bundle.
* `node.*` → every bundle of `node` (bundles resolved via the bundle entity type storage).
* `*.*` → every **content** entity type (`ContentEntityTypeInterface`) and all their bundles.

`visible: true` matters: `EntityDisplayBase::init()` adds the component to any display that
has neither an explicit `content` nor `hidden` entry for it — so a `visible: true` plugin
appears on existing displays as soon as the module is enabled.

## Display plugin — raw output

```php
namespace Drupal\my_module\Plugin\ExtraField\Display;

use Drupal\Core\Entity\ContentEntityInterface;
use Drupal\extra_field\Plugin\ExtraFieldDisplayBase;

/**
 * @ExtraFieldDisplay(
 *   id = "my_teaser_note",
 *   label = @Translation("Teaser note"),
 *   description = @Translation("A computed note."),
 *   bundles = {"node.article"},
 *   weight = 10,
 *   visible = false
 * )
 */
class TeaserNote extends ExtraFieldDisplayBase {

  public function view(ContentEntityInterface $entity) {
    return ['#markup' => 'Node ' . $entity->id() . ' says hi'];
  }

}
```

`ExtraFieldDisplayBase` gives you `getEntity()`, `getEntityViewDisplay()`, `getViewMode()`
(set by the manager before `view()` is called). Output is inserted verbatim — **no** field
wrapper, no label.

## Display plugin — wrapped like a real field

Extend `ExtraFieldDisplayFormattedBase` and implement `viewElements()` instead of `view()`.
The base class wraps the result in a `#theme => 'field'` render array
(`field.html.twig` applies), and you can override:

| method | default | purpose |
|---|---|---|
| `getLabel()` | `''` | field label |
| `getLabelDisplay()` | `'hidden'` | `above` / `inline` / `hidden` / `visually_hidden` |
| `getFieldType()` | `'extra_field'` | `#field_type` |
| `getFieldName()` | `extra_field_<id>` | `#field_name` |
| `isTranslatable()` | `FALSE` | `#field_translatable` |
| `getLangcode()` / `setLangcode()` | `LANGCODE_NOT_SPECIFIED` | `#language` |
| `$this->isEmpty` | `FALSE` | set TRUE to skip the field wrapper entirely |

Returning multiple children from `viewElements()` sets `#is_multiple = TRUE` and each child
becomes a `#items` delta.

## Form plugin

```php
namespace Drupal\my_module\Plugin\ExtraField\Form;

use Drupal\Core\Form\FormStateInterface;
use Drupal\extra_field\Plugin\ExtraFieldFormBase;

/**
 * @ExtraFieldForm(
 *   id = "my_note",
 *   label = @Translation("Editor note"),
 *   bundles = {"node.*"},
 *   weight = 50,
 *   visible = true
 * )
 */
class EditorNote extends ExtraFieldFormBase {

  public function formElement(array &$form, FormStateInterface $form_state) {
    return [
      'note' => ['#type' => 'textfield', '#title' => $this->t('Note')],
      '#validate' => [[$this, 'validateNote']],
    ];
  }

  public function validateNote(array $form, FormStateInterface $form_state) { /* … */ }

}
```

`ExtraFieldFormBase` provides `getEntity()`, `getEntityFormDisplay()`, `getFormMode()` and
`StringTranslationTrait`. Whatever you return is assigned to `$form['extra_field_my_note']`,
so element-level `#validate` / `#submit` callbacks and `$form_state` work normally.

`extra_field_form_alter()` only acts on forms whose form object is a
`ContentEntityFormInterface` **and not** a `ConfirmFormInterface` (so delete forms are
skipped), and only when the form display actually has the component enabled.

## Dependency injection

Both plugin types are instantiated through the plugin factory, so implementing
`ContainerFactoryPluginInterface` with the usual `create()` works — see
`extra_field_example`'s `ExampleWithDependencyInjection`.

## Gotchas

* Two classes with the same `id` collide silently — the later discovery wins. The bundled
  example module does exactly that with `article_only`.
* `hook_entity_bundle_create()` clears the managers' in-memory bundle cache
  (`clearCache()`), which matters mainly in tests that create bundles on the fly.
* An extra field carries no data: nothing is stored, nothing is exported, nothing appears in
  `field.field.*` config.
