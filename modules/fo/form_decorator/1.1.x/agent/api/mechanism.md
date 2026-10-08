# How decoration is wired in (services & mechanism)

The module has **no routes, no controllers, no config and no permissions**. Its entire runtime effect
is: swap core's `form_builder` service for a subclass, and have that subclass wrap every form object
in the applicable decorator plugins before the form id is resolved.

## Services

| Service id | Class | Notes |
|---|---|---|
| `plugin.manager.form_decorator` | `Drupal\form_decorator\FormDecoratorPluginManager` (`final`) | `parent: default_plugin_manager`. Discovers `FormDecorator` plugins, sorts them by `weight`. |
| `form_builder` (**overridden**) | `Drupal\form_decorator\FormDecoratorFormBuilder` | Core's form builder, subclassed. Swapped in by a service provider, not by `*.services.yml`. |

## The service-provider swap (`FormDecoratorServiceProvider.php`)

`FormDecoratorServiceProvider implements ServiceModifierInterface`. In `alter(ContainerBuilder $container)`
it checks the existing `form_builder` definition **is-a** core `FormBuilder`, then:

1. `setClass(FormDecoratorFormBuilder::class)`.
2. `array_unshift($arguments, new Reference('plugin.manager.form_decorator'))` — **prepends** the plugin
   manager to the existing argument list, so it stays compatible across core versions whose
   `FormBuilder` constructor arity differs (the subclass constructor is
   `__construct(FormDecoratorPluginManager $m, ...$args)` and calls `parent::__construct(...$args)`).

The is-a guard means if another module already replaced `form_builder` with a non-`FormBuilder` class,
this provider backs off and does nothing (the two swaps would be incompatible).

## Where forms get wrapped (`FormDecoratorFormBuilder::getFormId()`)

`FormDecoratorFormBuilder` overrides only `getFormId($form_arg, FormStateInterface &$form_state)`
(core calls it early inside `buildForm`):

```php
parent::getFormId($form_arg, $form_state);
$form_arg = $form_state->getFormObject();
foreach (array_keys($this->formDecoratorManager->getDefinitions()) as $id) {
  $instance = $this->formDecoratorManager->createInstance($id);
  $instance->setInner($form_arg);
  if ($instance->applies()) {
    $form_arg = $instance;      // wrap: the decorator becomes the new form object
  }
}
$form_state->setFormObject($form_arg);
return $form_arg->getFormId();
```

Consequences an integrator should know:

- Decorators are considered for **every** form built on the site (the loop runs each build), but only
  those whose `applies()` returns TRUE actually wrap. `applies()` is cheap (an `in_array` on hook names).
- Wrapping is **cumulative and ordered**: definitions come back weight-sorted, so a lower-weight
  decorator is wrapped first (innermost) and a higher-weight one wraps it. Two decorators on the same
  form compose (verified: `Foo` weight 0 then `Bar` weight 1 ⇒ markup `FooBar`).
- Because the decorator *becomes* `$form_state`'s form object, core continues normally — it calls
  `buildForm`/`validateForm`/`submitForm` on the outermost decorator, which delegates inward. **Core's
  form token / CSRF and `#access` handling are untouched**; decoration does not alter who may reach a
  form or bypass its token.
- `FormDecoratorBase::__call()` forwards any un-overridden method to the inner form, so entity forms
  keep their `getEntity()`, `save()`, etc. even through several layers.

## Plugin manager specifics (`FormDecoratorPluginManager`)

- Constructor: `parent::__construct('FormDecorator', $namespaces, $module_handler, FormDecoratorInterface::class, FormDecorator::class (attribute), FormDecoratorAnnotation::class)` — so the discovery subdir is `FormDecorator`, plugins must implement `FormDecoratorInterface`.
- `alterInfo('form_decorator_info')` ⇒ implement `hook_form_decorator_info(&$definitions)` to alter.
- `setCacheBackend($cache_backend, 'form_decorator_plugins')` ⇒ run `drush cr` after adding/editing a
  decorator or its attribute.
- `findDefinitions()` `uasort`s by `SortArray::sortByWeightElement` (reads each definition's `weight`).

## Calling / testing without HTTP

Nothing to call directly — decoration happens transparently whenever any form is built. To exercise a
decorator in a test, build the target form and assert on the result, e.g.
`\Drupal::formBuilder()->getForm(UserLoginForm::class)` then check the added element (see
`tests/src/Kernel/FormDecoratorKernelTest.php`, which also asserts the `FooBar` weight ordering).
