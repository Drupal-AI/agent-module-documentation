<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Writing a FormAlter plugin

A FormAlter plugin lives in your module at `src/Plugin/FormAlter/<Name>.php`, extends
`Drupal\pluginformalter\Plugin\FormAlterBase`, and is annotated `@FormAlter`. The
`plugin.manager.form_alter` manager discovers it and pluginformalter's own
`hook_form_alter()` invokes it for matching forms.

## Minimal example

```php
namespace Drupal\my_module\Plugin\FormAlter;

use Drupal\Core\Form\FormStateInterface;
use Drupal\pluginformalter\Plugin\FormAlterBase;

/**
 * @FormAlter(
 *   id = "my_article_alter",
 *   label = @Translation("Alter the article node form"),
 *   form_id = { "node_article_form", "node_article_edit_form" },
 *   weight = 0
 * )
 */
class MyArticleAlter extends FormAlterBase {

  public function formAlter(array &$form, FormStateInterface $form_state, $form_id) {
    $form['my_extra'] = ['#type' => 'markup', '#markup' => 'Hello'];
    // Add #validate / #submit handlers, defaults, #access, etc. here.
  }
}
```

## Annotation keys (`@FormAlter`)

| Key | Meaning |
|---|---|
| `id` | Plugin id (required, unique). |
| `label` | Optional translatable label. |
| `form_id` | Array of form ids to match (e.g. `{ "user_login_form" }`). |
| `base_form_id` | Array of base form ids to match instead of/as well as form ids. |
| `weight` | Integer ordering within its group (default 0; lower runs first). |

Provide **`form_id` or `base_form_id`** (either or both). Ids support `*` wildcards — the
manager builds a regex `^<id-with-*-as-.*>$` and matches the running form's id.

## Matching & ordering (how the manager selects plugins)

`FormAlterManager::getInstance($options)` returns every plugin whose `base_form_id` matches
`$options['base_form_id']` **or** whose `form_id` matches `$options['form_id']`, then sorts
by `weight`. pluginformalter's `hook_form_alter()` calls the manager **twice per form**:
first with the form's `base_form_id` (if any), then with its `form_id` — so base-form-id
plugins run before form-id plugins. Multiple plugins may alter the same form.

`formAlter()` receives the form array by reference, the `FormStateInterface`, and the string
`$form_id`, exactly like the parameters of a classic `hook_form_alter()`.

## Dependency injection

`FormAlterBase::create()` passes `(configuration, plugin_id, plugin_definition)` to the
constructor. Override `create()` to inject services (it implements
`ContainerFactoryPluginInterface`). `StringTranslationTrait` and
`DependencySerializationTrait` are already used by the base class.

## Discovery / caching note

The manager caches definitions (cache id `pluginformalter_form_alter_plugins`), but
pluginformalter calls `clearCachedDefinitions()` before invoking on each form build. After
adding a plugin, a `drush cr` ensures it is discovered.

## Deprecation (Drupal ≥ 11.2)

Every invoked plugin triggers `@trigger_error(..., E_USER_DEPRECATED)` and will **stop being
called in Drupal 12**. Use core OOP Hooks (`#[Hook('form_alter')]` / `#[Hook('form_FORM_ID_alter')]`)
for new work.
