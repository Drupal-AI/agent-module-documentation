# Drush: scaffold a decorator — `drush generate form-decorator`

The module ships a Drupal Code Generator generator (not a classic Drush command), auto-discovered by
`drush generate` when the module is enabled.

```bash
drush generate plugin:form-decorator
# alias:
drush generate form-decorator
```

Generator id `plugin:form-decorator` (alias `form-decorator`), class
`Drupal\form_decorator\Drush\FormDecoratorGenerator` (`type: MODULE_COMPONENT`), template
`src/Drush/FormDecorator.php.twig`. Verified present in `drush generate` output on 1.1.0.

## Prompts (`generate()`)

1. **machine name** of the target module (`askMachineName`).
2. **class name** (`askClass`, default `MyFormDecorator`).
3. **services** to inject (`askServices(FALSE)`) — adds `ContainerFactoryPluginInterface`, a `create()`
   and a constructor for the chosen services.
4. **base class** (`choice`): `ContentEntityFormDecoratorBase` (content entity form),
   `EntityFormDecoratorBase` (entity form), or `FormDecoratorBase` (generic form).
5. **how to decide which forms are decorated** (`choice`):
   - `form_id` → asks for a Form ID (default `user_login_form`) and sets the attribute hook to
     `form_<id>_alter`.
   - `hook_form_alter` → asks for the alter function name without the `hook_` prefix and uses it verbatim
     as the attribute hook.
   - `applies` → sets **no** hook; the generated class overrides `applies()`
     (`return $this->inner instanceof ContentEntityFormInterface && parent::applies();`).

## Output

Writes one file: `src/FormDecorator/<Class>.php` into the target module, extending the chosen base
class, with a `#[FormDecorator('<hook>')]` attribute (empty when the `applies` method was chosen), a
`buildForm()` that delegates to `$this->inner` then lets you mutate `$form`, and a `validateForm()`.
Run `drush cr` afterwards so `FormDecoratorPluginManager` (cache `form_decorator_plugins`) discovers it.

See [../plugins/form-decorator.md](../plugins/form-decorator.md) for the attribute fields and base
classes the generator is choosing between.
