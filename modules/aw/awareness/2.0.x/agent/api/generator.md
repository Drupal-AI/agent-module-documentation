<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# awareness:trait Drush generator

Class: `Drupal\awareness\Drush\Generators\AwarenessTraitGenerator` (`src/Drush/Generators/AwarenessTraitGenerator.php`), a Drupal Code Generator `BaseGenerator`. Discovered by Drush's `generate` command (no drush.services.yml needed for DCG generators).

Attribute:
```php
#[Generator(
  name: 'awareness:trait',
  description: 'Generates an awareness trait.',
  aliases: ['aware'],
  templatePath: __DIR__ . '/../../../templates/generator',
  type: GeneratorType::MODULE_COMPONENT,
)]
```

Run it:
```
drush generate awareness:trait      # or the alias: drush generate aware
```

## Interactive flow (`generate()`)

1. `askMachineName()` → target module machine name (`machine_name`).
2. Asks **Service ID** with a `Required` validator; autocomplete is populated from `\Drupal::getContainer()->getServiceIds()`. The chosen service is fetched with `->get($service_id)`.
3. Asks **Service interface/class** as a `ChoiceQuestion` built from `class_implements($service)` plus the concrete class — you pick which type the getter should return.
4. `askClass()` for the trait class, default `{service_id|camelize}AwareTrait`.
5. Asks the method name, default `get{service_id|camelize}`.
6. Derives `interface_short`, `service_namespace`, `namespace` (`Drupal\<machine_name>\...`), `dir`, and a `use` flag (true when the interface is in a different namespace).
7. Writes `src/{dir}/{class}.php` from `awareness-trait.twig`.

## Template (`templates/generator/awareness-trait.twig`)

Emits a trait in your module's namespace with an optional `use` line and a single method:
```php
protected function {{ method }}(): {{ interface_short }} {
  return \Drupal::service('{{ service_id }}');
}
```

So the generator produces the same `\Drupal::service()`-wrapping pattern as the bundled traits, but in your own module's namespace. Use it to add awareness traits for services not covered by the shipped set (including contrib/custom services). It runs interactively at the CLI only and generates code into your module source tree.
