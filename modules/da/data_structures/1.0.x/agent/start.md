<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Data Structures (data_structures) — agent index

A **developer utility** module: no routes, permissions, config, schema, entities, hooks, or
services. It ships (1) two `drush generate` generators that scaffold typed value/collection
classes, and (2) a library of typed **immutable sequence** classes plus a **Set** class under
`Drupal\data_structures\DataStructure`. Package `Development`. Core `^10 || ^11`.
Requires **PHP >= 8.3** and **Drush ^13** (composer `require`, not a Drupal module dep).
License GPL-2.0-or-later. Version 1.0.4.

- **The shipped sequence & set classes (how to use / extend them)** →
  [api/collections.md](api/collections.md)
- **The two Drush generators (`data-structures:map`, `data-structures:typed-sequence`)** →
  [generators/drush-generators.md](generators/drush-generators.md)

## What it actually is

- **No `.module`, `.install`, `.routing.yml`, `.permissions.yml`, `.services.yml`, `.links.*`,
  or `config/`.** The whole module is autoloaded PHP classes under `src/`. Nothing runs on hook
  invocation; you use it by `new`-ing its classes in custom code or by invoking its generators.
- `provides_drush_commands` = true only in the sense of **DrupalCodeGenerator generators**
  (`#[Generator(...)]`) reached via `drush generate <name>` — there are no `#[CLI\Command]`
  Drush command classes.

## Shipped classes (`src/DataStructure/`)

- **Immutable typed sequences**, each `implements \IteratorAggregate, \Countable, \ArrayAccess,
  \JsonSerializable`, validating element type in a `final` constructor and throwing
  `RuntimeException` on `offsetSet`/`offsetUnset` (immutable):
  `CallableImmutableSequence`, `FloatImmutableSequence`, `IntImmutableSequence`,
  `ObjectImmutableSequence`, `StringImmutableSequence`. Common methods: `toArray()`, `isEmpty()`,
  `map()`, `reduce()`, `filter()`. String & Float variants add `filterContains()` / `filterBegins()`.
  All but `CallableImmutableSequence` accept a `bool|callable $sort` constructor arg.
- **`Set` / `SetInterface`** — unique-membership collection with `add()`, `remove()`, `has()`,
  `empty()`, `isEmpty()`, `union()`, `intersect()`, `difference()`, `symDifference()`, `map()`,
  `reduce()`, `filter()`, `toArray()`. Uniqueness uses `===` unless both members implement…
- **`EqualityInterface`** — `hash(): int|float|string` and `equalTo(EqualityInterface): bool`,
  letting objects define their own equality for `Set` membership.

## Internal helpers (`src/`, not for reuse)

- `BaseTypes` (`@internal` enum of supported scalar/base type names), `ClassTypes` (scans the
  Drupal root + vendor dir with Symfony Finder to autocomplete class names in the generators),
  `Validator\PropertyName` and `Validator\Type` (regex validators used by the generators only).

## Notes

- Sequences store an internal indexed array, so there is no memory win over arrays for sequences
  themselves — their value is the enforced element type and immutability. The value maps produced
  by the `data-structures:map` generator are where the memory savings apply.
- No security surface: no web routes, no external HTTP, no user/request input, no DB queries.
