<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Form decorator is a developer module that lets you alter any Drupal form with a small decorator class instead of `hook_form_alter()`, keeping the form as a real object with dependency injection.

---

Install it with `composer require drupal/form_decorator` and enable it (`drush en form_decorator`); it needs only Drupal core (`^10 || ^11 || ^12`), adds no configuration screen, no permissions and no routes, so once enabled there is nothing to set up. Under the hood it swaps core's `form_builder` service for a subclass that, on every form build, wraps the form object in whichever decorator plugins apply. To use it you (a developer) create a class under your module's `src/FormDecorator/` directory that extends one of `FormDecoratorBase` (generic forms), `EntityFormDecoratorBase` (entity forms) or `ContentEntityFormDecoratorBase` (content-entity forms), and annotate it with the `#[FormDecorator('form_<FORM_ID>_alter', $weight)]` attribute to say which form and in what order it runs; the fastest way to create one is `drush generate form-decorator`, which interviews you and writes the file. In the class you override only the methods you care about — typically `buildForm()` (call `$this->inner->buildForm(...)` first, then change `$form`), `validateForm()` to add checks, or `submitForm()`/`save()` to react to submission — and everything you do not override is forwarded to the original form untouched. Because a decorator is an ordinary plugin, you inject services through a normal `create()`/constructor (`ContainerFactoryPluginInterface`) rather than reaching for `\Drupal::service()`, and you can unit-test the class directly. Multiple decorators can target the same form and are applied in `weight` order (lower first), so behaviours compose predictably. Enable the bundled **Form decorator example** submodule to see five working decorators on the login, registration and node forms, but treat it as a demo rather than something to run in production. Remember to `drush cr` after adding or changing a decorator, since definitions are cached; and note that decoration only changes a form's build/validate/submit — who is allowed to reach the form is still governed by core route access and element `#access`.

---

- Replace a `hook_form_alter()` with a dedicated class.
- Inject services into a form alteration via the constructor.
- Unit-test a form modification in isolation.
- Give competing form changes an explicit, declared order.
- Add a field or markup to a specific form by id.
- Add extra validation to the user registration form.
- Add custom submit/save behaviour to an entity form.
- Add a created-date picker to node forms and persist it.
- Organise many form tweaks as one class per concern.
- Keep a form as a real object instead of an array in a hook.
- Decorate every form on the site with a single `form_alter` decorator.
- Decorate a whole family of forms via a base form id.
- Reduce procedural code in a crowded `.module` file.
- Scaffold a new decorator quickly with `drush generate form-decorator`.
- Alter or remove another module's decorators with `hook_form_decorator_info()`.
- Modernise legacy alter code into injectable, testable classes.
- Compose several independent alterations on the same form.
- Ship reusable form behaviour as plugins from a shared module.
- Study the bundled example submodule to learn the pattern.
- Avoid `\Drupal::service()` calls inside form-alter logic.
