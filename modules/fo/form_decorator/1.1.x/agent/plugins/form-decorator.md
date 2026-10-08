# `FormDecorator` plugin type

The one plugin type the module defines. A decorator is a plugin class that **wraps a form object**
(implements `FormInterface`) and re-implements only the methods it cares about, delegating everything
else to the form it decorates. It is the OOP replacement for one `hook_form_alter()` branch.

- Manager service: `plugin.manager.form_decorator` (`FormDecoratorPluginManager`, `final`, extends
  `DefaultPluginManager`). Parent service `default_plugin_manager` (see `form_decorator.services.yml`).
- Discovery dir: **`src/FormDecorator/`** inside any module (NOT `src/Plugin/...`). Subdir name is
  literally `FormDecorator`.
- Interface: `FormDecoratorInterface` (`setInner()`, `applies()`) — plus every method of
  `\Drupal\Core\Form\FormInterface`, supplied by the base class.
- Attribute (preferred): `Drupal\form_decorator\Attribute\FormDecorator`. Legacy annotation:
  `Drupal\form_decorator\Annotation\FormDecorator` (`@Annotation`).
- Alter hook: **`hook_form_decorator_info(&$definitions)`** (`alterInfo('form_decorator_info')`) — add,
  remove or reweight decorator definitions. Definitions cache: `form_decorator_plugins`.

## Attribute fields (`Attribute/FormDecorator.php`)

| Field | Type | Meaning |
|---|---|---|
| `hook` | `string` (default `''`) | The form-alter hook name **without** the `hook_` prefix, e.g. `form_user_login_form_alter`, `form_node_form_alter`, or bare `form_alter`. Drives the default `applies()`. Empty ⇒ you must override `applies()` yourself. |
| `weight` | `int` (default `0`) | Order in the decorator stack; **lower weights are applied first** (wrapped innermost), higher weights wrap them. Definitions are `uasort`ed by weight in `FormDecoratorPluginManager::findDefinitions()`. |

Plugin **id = the fully-qualified class name** — both `Attribute\FormDecorator::getId()` and
`Annotation\FormDecorator::getId()` return the class, so there is no separate `id` to invent. Runtime
example: `Drupal\form_decorator_example\FormDecorator\Bar`.

## The three base classes (extend one)

All live in `Drupal\form_decorator\`. The decorated inner object is `protected FormInterface $inner`;
`__call()` transparently forwards any method not overridden to `$inner`.

| Base class | Implements | Decorate… |
|---|---|---|
| `FormDecoratorBase` | `FormInterface`, `FormDecoratorInterface` | any plain form (config forms, `FormBase`, `user_login_form`, …) |
| `EntityFormDecoratorBase` | + `EntityFormInterface` | entity add/edit forms (adds `getEntity`, `save`, `getOperation`, `buildEntity`, …) |
| `ContentEntityFormDecoratorBase` | + `ContentEntityFormInterface` | content-entity forms (adds `getFormDisplay`, `getFormLangcode`, …) — e.g. `form_node_form_alter` |

Pick the class matching the inner form's type, otherwise the extra interface methods forwarded through
`getEntity()`/`getFormDisplay()` will hit forms that do not have them (`EntityFormDecoratorBase::getEntity()`
asserts `$this->inner instanceof EntityFormInterface`).

## `applies()` — which forms get decorated

Default (`FormDecoratorBase::applies()`, `FormDecoratorBase.php:34`):

```php
return in_array($this->getPluginDefinition()['hook'], $this->getHooks($this->inner));
```

`getHooks()` builds the same hook list core would dispatch for this form:
`['form_alter', 'form_<baseFormId>_alter' (if BaseFormIdInterface), 'form_<formId>_alter']`. So a
decorator with `hook: 'form_alter'` decorates **every** form; `hook: 'form_node_form_alter'` matches
every node form via the base form id; `hook: 'form_user_login_form_alter'` matches only that form id.
Override `applies()` (and leave `hook` empty) for arbitrary logic — e.g. the Drush template emits
`return $this->inner instanceof ContentEntityFormInterface && parent::applies();`.

## Methods to override

- **`buildForm(array $form, FormStateInterface $form_state, ...$args)`** — call
  `$form = $this->inner->buildForm($form, $form_state, ...$args);` first, then mutate `$form` and
  `return $form;` (this is the `hook_form_alter` equivalent, but you keep the object).
- **`validateForm(array &$form, FormStateInterface $form_state)`** — usually call
  `$this->inner->validateForm(...)` then add checks with `$form_state->setErrorByName(...)`.
- **`submitForm(...)` / `save(...)`** (entity forms) — same delegate-then-extend shape.
- Anything you do not override falls through `__call()` to `$inner`, so `getFormId()`,
  dependency-laden helpers, etc. keep working.

## Dependency injection

A decorator is an ordinary plugin: implement `ContainerFactoryPluginInterface` and add a `create()` +
constructor. See `form_decorator_example/src/FormDecorator/DependencyInjection.php` (injects
`entity_type.manager`). This is the main win over `hook_form_alter`, where you would reach for
`\Drupal::service()`.

## Worked examples (the `form_decorator_example` submodule)

| Class | Attribute | What it shows |
|---|---|---|
| `Foo` | `#[FormDecorator('form_user_login_form_alter')]` | appends `'Foo'` to a markup field in `buildForm`. |
| `Bar` | `#[FormDecorator('form_user_login_form_alter', 1)]` | same field, **weight 1** ⇒ runs after `Foo`; combined result is `FooBar` (proves ordering). |
| `DependencyInjection` | `#[FormDecorator('form_user_login_form_alter')]` | `ContainerFactoryPluginInterface` + injected `entity_type.manager`. |
| `NodeCreatedDate` | `#[FormDecorator('form_node_form_alter')]` | `ContentEntityFormDecoratorBase`; adds a `datetime` element in `buildForm` and writes it back in `save()` via `getEntity()`. |
| `ValidateOnly` | `#[FormDecorator('form_user_register_form_alter')]` | overrides only `validateForm` to add a username-length rule. |

## Write your own

Create `my_module/src/FormDecorator/MyDecorator.php`:

```php
namespace Drupal\my_module\FormDecorator;

use Drupal\Core\Form\FormStateInterface;
use Drupal\form_decorator\FormDecoratorBase;
use Drupal\form_decorator\Attribute\FormDecorator;

#[FormDecorator('form_user_login_form_alter', weight: 0)]
final class MyDecorator extends FormDecoratorBase {

  public function buildForm(array $form, FormStateInterface $form_state, ...$args) {
    $form = $this->inner->buildForm($form, $form_state, ...$args);
    $form['note'] = ['#markup' => 'Hello'];
    return $form;
  }

}
```

Clear caches (`drush cr`) after adding or changing the attribute — definitions are cached under
`form_decorator_plugins`. Scaffold the file with `drush generate form-decorator`
([../drush/generate.md](../drush/generate.md)).
