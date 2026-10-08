Automatic Configuration Form is a developer helper that generates a Drupal settings form automatically from a config object's typed-config schema, so you extend one base class instead of hand-writing form elements.

---

The module ships a single abstract class, `Drupal\auto_config_form\AutoConfigFormBase`, which extends core's `ConfigFormBase`. In your own module you create a `Form` subclass, implement the one required method `getSchemaKey()` to return the name of a `config_object` schema (e.g. `my_module.settings`), and the base class walks that schema's `mapping` to build a form: `string` → textfield, `boolean` → checkbox, `integer`/`float` → number, nested `mapping` → fieldset. Schema constraints are honored (`Length` → `#maxlength`, `NotBlank`/`NotNull` → `#required`, `Range` → `#min`/`#max`), each element gets a `#config_target` so core saves it, and values overridden in `settings.php` are shown with an override notice. Unimplemented schema types render a read-only placeholder pointing at the issue queue rather than a widget. The module provides no routes, permissions, services, config, or Drush commands — you add the route and access control yourself, and access is entirely whatever you set on that route (typically `administer site configuration`). It is aimed at small or low-importance modules where a bespoke settings form is not worth the effort; the maintainer now recommends the Schema form module for new feature development.

---

- Add a settings form to a small custom module without hand-writing any `buildForm()`/`submitForm()` code.
- Extend `AutoConfigFormBase` and implement `getSchemaKey()` returning your `*.settings` config object name.
- Generate a textfield from a `string`-typed config schema key.
- Generate a checkbox from a `boolean`-typed config schema key.
- Generate a number field from an `integer`- or `float`-typed config schema key.
- Group nested config into a fieldset automatically from a `mapping`-typed schema key.
- Enforce a maximum length on a field via the schema's `Length` constraint (`#maxlength`).
- Mark a field required via the schema's `NotBlank` or `NotNull` constraint.
- Constrain a number field's min/max via the schema's `Range` constraint.
- Surface config values overridden in `settings.php` to the admin with an inline override message.
- Show a read-only placeholder for a schema type the module does not yet support (e.g. sequences).
- Keep settings forms consistent in look and behavior across many small modules.
- Prototype a module's configuration UI quickly, starting only from the schema file.
- Override `buildStringElement()` / `buildBooleanElement()` / `buildNumberElement()` to customize just one widget type.
- Override `buildForm()` in your subclass to add extra elements alongside the generated ones.
- Reuse core's `ConfigFormBase` save flow (via `#config_target`) so no custom submit handler is needed.
- Provide a settings page for a module whose configuration rarely changes and does not justify a hand-built form.
- Wire the generated form into an admin route plus a menu link you define in your own module.
- Migrate an existing hand-written settings form to a schema-driven one to reduce boilerplate.
- Ensure every documented config key in your schema (via `label`/`title`/`description`) becomes a labeled, described form field.
- Use on Drupal 11 sites (use the 1.x branch instead for Drupal 10).
