<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Factory Lollipop - Paragraphs (factory_lollipop_paragraphs) — agent index

Submodule of **Factory Lollipop** that adds Paragraphs support to the factory pattern: two extra
FactoryTypes so `FixtureFactory` can build valid `paragraphs_type` bundles and `paragraph` entities in
tests. Package `Development`. License GPL-2.0-or-later. Installed version **1.2.5** (version dir
`1.2.x`). Core `^10.5 || ^11`.

## Dependencies

- `factory_lollipop:factory_lollipop` — the parent library (FixtureFactory, resolvers, traits).
- `paragraphs:paragraphs` — provides the `paragraph` / `paragraphs_type` entities.

## What it provides (from source)

Two services in `factory_lollipop_paragraphs.services.yml`, each tagged
`factory_lollipop.factory_type_resolver` (priority 245) and calling
`setEntityTypeManager(@entity_type.manager)`:

- **`paragraph type` → `ParagraphTypeFactoryType`** (`src/FactoryType/ParagraphTypeFactoryType.php`) —
  creates or loads a `paragraphs_type`; defaults `id` (random lowercase machine name) and `label`
  (random string) when not supplied. Uses `RandomGeneratorTrait`.
- **`paragraph` → `ParagraphFactoryType`** (`src/FactoryType/ParagraphFactoryType.php`) — requires a
  `type` attribute that must be an existing paragraph type (else `\InvalidArgumentException`); creates and
  saves a `paragraph` entity. `getIdentifier()` returns the paragraph id.

Both implement `Drupal\factory_lollipop\FactoryType\FactoryTypeInterface` and load entity storage lazily
inside `create()`. → [api/paragraph-factory-types.md](api/paragraph-factory-types.md)

## What it does NOT provide

No routes, controllers, forms, permissions, config, config schema, entities, hooks, libraries or Drush.
`configure` is null. Test/developer-only; no HTTP surface, no access-control role.

## Install / operate

1. Ensure `drupal/paragraphs` is installed.
2. `drush en factory_lollipop_paragraphs -y` (enables `factory_lollipop` too).
3. Use `paragraph type` / `paragraph` as the `type` in `FixtureFactory::define()`, then `create()`.
   See the parent's [../../../1.2.x/agent/api/defining-factories.md](../../../1.2.x/agent/api/defining-factories.md).
