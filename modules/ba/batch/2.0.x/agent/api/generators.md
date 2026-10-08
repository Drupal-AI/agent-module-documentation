<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush code generators

Files: `src/Drush/Generators/OperationGenerator.php`, `FinishGenerator.php`; templates in
`templates/generator/operation.twig` and `finish.twig`. These are DrupalCodeGenerator generators
discovered by Drush's `generate` command — not standalone Drush commands.

## batch:operation (`OperationGenerator.php`)

`#[Generator(name: 'batch:operation', type: GeneratorType::MODULE_COMPONENT)]`. Prompts for the
target module machine name, a human name, and a class (default `{machine_name|camelize}Operation`),
then writes `src/Batch/Operation/{class}.php` from `operation.twig`.

Generated class extends `EnumeratedOperationBase` with a stub `processItem()`:
```php
final class FooOperation extends EnumeratedOperationBase {
  public function processItem(mixed $item, array &$context): void {
    // @todo add operation functionality.
  }
}
```

Run: `drush generate batch:operation`.

## batch:finish (`FinishGenerator.php`)

`#[Generator(name: 'batch:finish', ...)]`. Same prompts (class default `{machine_name|camelize}Finish`),
writes `src/Batch/Finish/{class}.php` from `finish.twig`.

Generated class extends `FinishDefault`, adds a status message and calls `parent::finished()`.

Run: `drush generate batch:finish`.

> Note: the `finish.twig` stub references `RedirectResponse` without a `use` statement — add
> `use Symfony\Component\HttpFoundation\RedirectResponse;` to the generated file if you keep the
> return type hint.
