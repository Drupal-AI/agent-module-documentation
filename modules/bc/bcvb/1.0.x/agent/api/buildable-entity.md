<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Rendering an entity from its bundle class

## The interface
`Drupal\bcvb\Entity\BuildableEntityInterface` (`src/Entity/BuildableEntityInterface.php`):
- `build(string $viewMode): array` — return a render array for the entity.
- `shouldBuild(string $viewMode): bool` — whether this entity/view-mode should use `build()`.

A bundle class opts a bundle into custom rendering by implementing this interface. Bundles that do
not implement it, or whose `shouldBuild()` returns FALSE, render through core's normal path.

## The render swap
1. `bcvb_entity_type_alter()` sets the view-builder class to `Handler\BcvbViewBuilder` for every
   entity type listed in `bcvb.settings:entity_types`.
2. `Handler\BcvbViewBuilder` extends core `EntityViewBuilder` and mixes in
   `Drupal\bcvb\BcvbViewBuilderTrait`.
3. `BcvbViewBuilderTrait::getBuildDefaults($entity, $view_mode)`:
   - calls `parent::getBuildDefaults()` for the standard defaults;
   - returns those unchanged if `$entity` is not a `BuildableEntityInterface` **or**
     `$entity->shouldBuild($view_mode)` is FALSE;
   - otherwise captures cacheable metadata from the defaults, replaces the build with
     `$entity->build($view_mode)`, then merges the captured metadata into the new build via
     `CacheableMetadata` and returns it.

   Note it is `getBuildDefaults` that is overridden, so field/component additions the normal builder
   would layer on top of the defaults are effectively replaced by what `build()` returns — the
   bundle class is responsible for the full render array.

## Reusing the trait in a custom view builder
Some entity types ship their own view builder (e.g. `NodeViewBuilder`, `BlockContentViewBuilder`)
and won't be swapped for `BcvbViewBuilder`. For those, subclass the core builder and `use
Drupal\bcvb\BcvbViewBuilderTrait` to get the same `getBuildDefaults()` behaviour, then set your
subclass as the view-builder class yourself. The trait is the reusable unit; `BcvbViewBuilder` is
just `EntityViewBuilder` + the trait.

## Worked example (tests/modules/bcvb_example)
`Drupal\bcvb_example\Entity\BlockContent\Accordion` extends core `BlockContent`, carries a BCA
`#[Bundle(entityType: 'block_content', bundle: 'accordion')]` attribute, and implements
`BuildableEntityInterface`:
- `shouldBuild()` returns `TRUE`.
- `build($viewMode)` returns `PintoAccordion::createFromAccordionBlock($this)()` — a Pinto theme
  object (`Drupal\bcvb_example\Pinto\Accordion`, a `#[Slots]` object with `title`/`content`)
  invoked to produce the render array.
This demonstrates the intended stack: BCA discovers the bundle class, BCVB routes rendering to it,
Pinto supplies the object-oriented template. Pinto/BCA are optional — `build()` may return any
plain render array.

## Cacheability
Return proper cache metadata from `build()` (cache tags/contexts/max-age, or a Pinto object
implementing `CacheableDependencyInterface` as in the example). The trait merges the builder's
default cacheable metadata into your build, but data-specific cacheability is the bundle class's
responsibility.
