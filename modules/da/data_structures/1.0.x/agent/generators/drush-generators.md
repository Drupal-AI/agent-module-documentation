<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush generators — data-structures:map & data-structures:typed-sequence

Two DrupalCodeGenerator generators registered with the `#[Generator(...)]` attribute and reached
through Drush 13's `drush generate` command. They are **not** `#[CLI\Command]` Drush commands, so
they appear only under `drush generate`. Requires Drush `^13` and PHP 8.3+.

## Install / enable

`composer require drupal/data_structures` then `drush en data_structures`. The generators are
discovered automatically by Drush's generate command once the module is enabled.

## data-structures:map — `MapGenerator`

`src/Drush/Generators/MapGenerator.php`. `final class MapGenerator extends BaseGenerator` using
the `ClassCompleter` trait. `type: GeneratorType::MODULE_COMPONENT`; templates in
`src/Drush/Generators/templates/`. Its `generate()` bootstraps Drupal fully
(`#[CLI\Bootstrap(level: DrupalBootLevels::FULL)]`).

Interview (prompts, in order):

1. **machine name** of the target module (`askMachineName`).
2. **class** name (default `{machine_name|camelize}ValueMap`).
3. **"Are map values allowed to change after construction?"** (`confirm`) → chooses mutable vs.
   immutable template.
4. Loop: **property name** (validated by `Validator\PropertyName` + `Required`) then **base type
   or namespaced class** (validated by `Validator\Type` + `Required`, autocompleted — see below).
   Repeats while you confirm "Add another typed property?".

Output: writes `src/DataStructure/{class}.php` into the target module, from
`map-immutable.php.twig` (default — `readonly` promoted constructor properties) or
`map-mutable.php.twig` when values may change. Namespaced-class property types are `use`-imported
and typed with a leading `\`; base types are used bare.

## data-structures:typed-sequence — `TypedSequenceGenerator`

`src/Drush/Generators/TypedSequenceGenerator.php`. `class TypedSequenceGenerator extends
BaseGenerator` using `ClassCompleter`. Interview:

1. **machine name** of the target module.
2. **base type or namespaced class of the sequence items** (`Validator\Type` + `Required`,
   autocompleted).
3. **class** name (default `{type|camelize}ImmutableSequence`).

Output: `src/DataStructure/{class}.php` from `typed-sequence.php.twig` — an immutable sequence
class shaped like the shipped ones (`IteratorAggregate/Countable/ArrayAccess/JsonSerializable`,
`bool|callable $sort`, `map/reduce/filter`). For a base type it emits the matching `is_*()` check;
for a class it emits `$value instanceof <Class>`; String uses `natsort()`, others `sort()`.

## Type autocomplete (`ClassCompleter` + `ClassTypes` + `BaseTypes`)

`ClassCompleter::getValidTypes()` (trait) builds a `StringImmutableSequence` of valid type
strings: the `BaseTypes` enum cases (`bool, int, float, string, array, object, resource, never,
void, false, true, callable` — the enum is `@internal`) **merged with** every fully-qualified
class name found by `ClassTypes`. `ClassTypes` (`src/ClassTypes.php`) uses Symfony `Finder` to
scan `$drupalFinder->getDrupalRoot()` and `getVendorDir()` for `*.php` files containing a
`namespace` and a `class` declaration, extracting `Namespace\Class` via regex. This can be slow on
large codebases (it walks the whole vendor tree) — it runs when the type question is asked.

## Validators

- `Validator\PropertyName` (`__invoke`): regex `^[a-z]+((\d)|([A-Z0-9][a-z0-9]+))*([A-Z])?$`
  (lowerCamelCase); throws `\UnexpectedValueException` otherwise.
- `Validator\Type` (`__invoke`): accepts a `BaseTypes` case, or a `\`-separated identifier whose
  every segment matches `^([A-Z][a-z0-9]+)((\d)|([A-Z0-9][a-z0-9]+))*([A-Z])?$`; else throws
  `\UnexpectedValueException`.

Both are plain invokable objects wrapped in DrupalCodeGenerator's `Chained(new Required(), ...)`.
