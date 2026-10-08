<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Defining and using factories

There are two ways to register blueprints on the `FixtureFactory` service
([fixture-factory.md](fixture-factory.md)).

## 1. Inline `define()` (quick, per-test)

Call `define($type, $name, $opts)` directly in your test, then `create()`:

```php
$factory = $this->container->get('factory_lollipop.fixture_factory');
$factory->define('node type', 'article_type', ['type' => 'article']);
$factory->define('node', 'article', [
  'type'   => $factory->association('article_type'), // cascades node-type creation, returns its id
  'status' => 1,
]);
$node = $factory->create('article', ['title' => 'Hello']); // override at create time
```

## 2. Factory blueprint classes (reusable, shared)

Package blueprints as classes implementing `Drupal\factory_lollipop\FactoryInterface`
(`src/FactoryInterface.php`):

- `getName(): string` — a unique resolver name (used by `loadDefinitions()`/`excluded`).
- `resolve(FixtureFactory $lollipop)` — call `$lollipop->define(...)` here to register one or more
  blueprints (`@internal`).

Register the class as a service tagged `factory_lollipop.factory_resolver` (with a `priority` so
dependency blueprints load before dependents), then bulk-load them:

```php
$factory->loadAllDefinitions();              // resolve every tagged FactoryInterface
$factory->loadDefinitions(['node_article']); // or just some, by getName()
$node = $factory->create('node_article');
```

Reference implementation (in the module's own tests): `NodeArticleFactory` — `getName()` returns
`'node_article'`; `resolve()` defines a `node type` blueprint `node_type_article` and a `node` blueprint
`node_article` whose `type` option is `$lollipop->association('node_type_article')`, so creating the node
first creates and binds its node type. The test module `factory_lollipop_test` registers these under the
`factory_lollipop.factory_resolver` tag with ordered priorities (node type before node, etc.) — see
`tests/modules/factory_lollipop_test/`.

## Cascading, sequences and lazy options

- **Association:** use `association($name, $opts)` as an option value to auto-create a dependency and
  substitute its identifier (e.g. a node's `type`, a term's vocabulary). It runs lazily at create time.
- **Sequence:** use `FixtureFactory::sequence('user_%d')` (static) as an option value for unique,
  incrementing values.
- **Any closure** in `opts` is evaluated at create time by `getDefaultOptions()`, so defaults can be
  computed fresh per object.

## Extending the type set

`define()`'s `$type` must be handled by a registered FactoryType. The built-ins cover the common
entities; add your own (e.g. for a custom entity) by tagging a `FactoryTypeInterface` service — see
[factory-types.md](factory-types.md). For paragraphs, enable `factory_lollipop_paragraphs` and use the
`paragraph` / `paragraph type` types.
