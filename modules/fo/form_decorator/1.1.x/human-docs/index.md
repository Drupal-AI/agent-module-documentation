# Form Decorator — manual setup guide

**Form Decorator** (`form_decorator`) is a developer tool that lets you modify a
Drupal form by writing a **decorator service** instead of a `hook_form_alter()`.
It gives your form changes what a plain alter hook can't: a real class, an
explicit service definition, constructor dependency injection, and a declared
order — plus the ability to unit test the change in isolation.

The problem it solves is a familiar one. `hook_form_alter()` is Drupal's oldest
extension point and its least pleasant to work with: every module's alterations to
every form pile up in one procedural function dispatched by a long chain of
`if ($form_id == …)` branches; the order between modules is governed by module
weight, which nobody enjoys reasoning about; the code can't be unit tested without
bootstrapping Drupal; and there's nowhere to inject dependencies, so you reach for
`\Drupal::service()`. A decorator replaces all of that with one class per concern.
In a decorator you can, in principle, work the way you would inside the form class
itself — overriding `buildForm()`, `validateForm()`, `submitForm()`, or an
entity form's `save()`, and calling through to the inner form with `$this->inner`.

This is **infrastructure for other modules** — it has no dependencies,
permissions, or configuration of its own. A bundled **Form Decorator Example**
submodule (`form_decorator_example`) shows the pattern in action.

Two things are worth weighing before you adopt it:

1. **It's another layer of indirection.** A developer opening the codebase who
   doesn't know the pattern will look for a `hook_form_alter` that isn't there.
   Agree on using it as a team rather than adding it silently.
2. **Decorating a form does not decorate its security.** Validation and submit
   handlers you add this way are still ordinary handlers; `#access` and route
   access still decide who can reach the form at all; and a decorator that adds a
   field must still make sure that field's value is validated on submission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and optionally enable the example submodule.

There is **no configuration page** for this module — it's a developer API. How you
use it is described in "How to use it" below.

## Where it lives in the admin menu

The module adds no admin page. You use it entirely from code, by writing decorator
classes in your own module.

## How to use it

At a high level, you create a class that extends one of the module's base classes
(for example `FormDecoratorBase`, or `ContentEntityFormDecoratorBase` for content
entity forms) and tag it with the `#[FormDecorator('…')]` attribute naming the
form‑alter target it decorates. Inside the class you override just the methods you
care about — `buildForm()`, `validateForm()`, `submitForm()`, or `save()` — and
call `$this->inner->…()` to reach the original form behaviour. Because it's a real
service, you can inject dependencies through a normal `create()`/constructor pair.

The quickest way to learn the exact shape is to enable the bundled example
submodule and read its classes:

```bash
drush en form_decorator_example -y
```

Then explore `form_decorator_example` in your codebase for working decorators
(such as adding validation to the user register form, or an editable "created
date" field on the node form).
