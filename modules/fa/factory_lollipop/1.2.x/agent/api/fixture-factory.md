<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# FixtureFactory — the developer API

File: `src/FixtureFactory.php` · Class: `Drupal\factory_lollipop\FixtureFactory`
Service: `factory_lollipop.fixture_factory` (constructor args: `ChainFactoryTypeResolver`,
`ChainFactoryResolver`). Get it in a kernel test with
`$this->container->get('factory_lollipop.fixture_factory')`.

It is the entry point: you register named blueprints ("definitions") and then create/persist objects
from them. Internally it holds `$definitions` (name → `['type' => ..., 'opts' => ...]`) and delegates
creation to the resolved `FactoryType` (see [factory-types.md](factory-types.md)).

## Methods

- `define(string $type, string $name, array $opts): void` — register a blueprint. `$type` is the data
  type string that selects a FactoryType (e.g. `'node'`, `'user'`); `$name` is a unique lookup key;
  `$opts` are default attributes passed to the FactoryType. Values in `$opts` that are `\Closure`
  instances are evaluated lazily at create time (see `getDefaultOptions()`).
- `create(string $name, array $opts = [])` — merge the blueprint defaults with per-call `$opts`, cast to
  an object, resolve the blueprint's type via `ChainFactoryTypeResolver::getResolvers()` (first
  `shouldApply($type)` wins) and return the created/persisted entity. Throws
  `\RuntimeException("Factories of type '{type}' are not supported.")` if no FactoryType matches.
- `association(string $name, array $opts = []): callable` — returns a closure that, when called, creates
  the named object and returns its **identifier** (via the FactoryType's `getIdentifier()`). Use it as a
  default option value so a parent factory cascades creation of a dependency (e.g. a node whose `type`
  is produced by a node-type factory). The closure runs lazily at create time.
- `getType($name): ?string` — the type string of a definition, or NULL if undefined.
- `getDefaultOptions(string $factory_name): array` — the blueprint's `opts`, with each `\Closure`
  value invoked (so sequences/associations resolve). Throws `\InvalidArgumentException` if the name is
  not defined.
- `loadAllDefinitions(array $excluded = []): void` — iterate every registered `FactoryInterface`
  resolver (tag `factory_lollipop.factory_resolver`) and call `resolve($this)` on each (skipping any
  whose `getName()` is in `$excluded`). This is how blueprint classes get registered.
- `loadDefinitions(array $factories): void` — same, but resolves only the resolvers whose `getName()`
  is in `$factories`.
- `getDefinitions(): array` / `getDefinition(string $name): ?array` — inspect registered blueprints.
- `static sequence($generator, $start = 1): callable` — returns a closure producing an incrementing
  value each call: if `$generator` is callable it is invoked with the counter; if it is a string
  containing `%d`, `%d` is replaced by the counter; otherwise the counter is appended. Use as an `opts`
  value to get unique names (e.g. usernames). Note: `sequence` is `static` — call
  `FixtureFactory::sequence(...)`.

## Typical flow (kernel test)

```php
$factory = $this->container->get('factory_lollipop.fixture_factory');
$factory->define('node type', 'article_type', ['type' => 'article', 'name' => 'Article']);
$factory->define('node', 'article', [
  'type' => $factory->association('article_type'),      // cascades node-type creation
  'title' => FixtureFactory::sequence('Article %d'),    // unique titles
]);
$node = $factory->create('article', ['status' => 1]);   // per-call override
```

Blueprints can also be packaged as `FactoryInterface` classes and bulk-registered with
`loadAllDefinitions()` — see [defining-factories.md](defining-factories.md).
