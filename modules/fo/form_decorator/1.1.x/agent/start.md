<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Form decorator (form_decorator) — agent index

A developer API that alters forms with **decorator plugin classes** instead of `hook_form_alter()`.
The module replaces core's `form_builder` service (via a `ServiceModifierInterface`) with
`FormDecoratorFormBuilder`; when any form is built, that builder loops over every `FormDecorator`
plugin, and each plugin whose `applies()` matches **wraps** the form object (the decorator implements
`FormInterface` and delegates to the form it wraps through a `protected $inner` and a `__call()`
passthrough). A decorator therefore re-implements only `buildForm()`/`validateForm()`/`submitForm()`
(or entity `save()`) it cares about, keeps the form as a real object, and can use constructor
dependency injection — the things `hook_form_alter()` gives up. Decorators declare a target with a
`#[FormDecorator(hook, weight)]` attribute and are discovered from any module's `src/FormDecorator/`
directory; the stack is applied in `weight` order (lower first, wrapped innermost).

Plugin **id is the fully-qualified class name** (no separate id string). The bundled
`form_decorator_example` submodule ships five reference decorators — `Foo` and `Bar` (weight-ordered
markup on `user_login_form`, proving `FooBar` ordering), `DependencyInjection` (injects
`entity_type.manager`), `NodeCreatedDate` (a content-entity decorator adding a created-date picker and
writing it back in `save()`), and `ValidateOnly` (adds a username-length rule to user registration).

- Depends on: nothing (core only). Optional bundled submodule `form_decorator_example` (depends on
  `form_decorator`; enable only for reference — it visibly alters the login/register/node forms).
- Core: `^10 || ^11 || ^12`. Package: `Forms`.
- **No** settings page / `configure` route, **no** permissions, **no** config schema, **no** routes,
  **no** hooks it invokes for you besides the plugin alter hook.
- Defines one plugin type: **`FormDecorator`** (manager `plugin.manager.form_decorator`).
- Provides a Drush generator: `drush generate form-decorator`.

## What you'd do → where

- **Understand how a form gets wrapped / the `form_builder` swap / services** →
  [api/mechanism.md](api/mechanism.md)
- **Write a decorator: attribute fields, `applies()`, which base class, DI, worked examples** →
  [plugins/form-decorator.md](plugins/form-decorator.md)
- **Scaffold a decorator class with Drush** → [drush/generate.md](drush/generate.md)
- **Alter/remove another module's decorators** → implement `hook_form_decorator_info(&$definitions)`
  (see [plugins/form-decorator.md](plugins/form-decorator.md))

## Key facts (real machine names)

- Service: `plugin.manager.form_decorator` (`FormDecoratorPluginManager`, `final`, parent
  `default_plugin_manager`).
- Overridden service: `form_builder` → `Drupal\form_decorator\FormDecoratorFormBuilder` (swapped by
  `FormDecoratorServiceProvider::alter()`).
- Plugin type `FormDecorator`: attribute `Drupal\form_decorator\Attribute\FormDecorator(hook, weight)`,
  legacy annotation `…\Annotation\FormDecorator`, interface
  `Drupal\form_decorator\FormDecoratorInterface` (`setInner()`, `applies()`), discovery dir
  `src/FormDecorator/`, alter hook `form_decorator_info`, definition cache `form_decorator_plugins`.
- Base classes: `FormDecoratorBase` (any form), `EntityFormDecoratorBase` (entity forms),
  `ContentEntityFormDecoratorBase` (content-entity forms).
- Attribute keys: `hook` (form-alter hook name without `hook_`; empty ⇒ override `applies()`),
  `weight` (int, lower applied first). Plugin id = class name.
- Drush generator: `plugin:form-decorator` (alias `form-decorator`),
  `Drupal\form_decorator\Drush\FormDecoratorGenerator`, template `src/Drush/FormDecorator.php.twig`.
- Submodule `form_decorator_example` decorator ids (FQCN):
  `Drupal\form_decorator_example\FormDecorator\{Foo, Bar, DependencyInjection, NodeCreatedDate, ValidateOnly}`.
