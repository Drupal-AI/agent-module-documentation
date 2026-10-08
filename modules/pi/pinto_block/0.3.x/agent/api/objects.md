<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Pinto Block developer API

## 1. Define a bundle class
Map a `block_content` bundle to a class the usual way — core alter, BCA, or Hux:

```php
function mymodule_entity_bundle_info_alter(array &$bundles): void {
  $bundles['block_content']['foobar']['class'] = \Drupal\mymodule\Entity\Foobar::class;
}
```

## 2. Create a Pinto theme object
Implement `\Drupal\pinto_block\BlockBundleObjectInterface`. Use `DrupalObjectTrait` and a `#[ThemeDefinition(...)]` describing the variables. Its `create()` receives the block, the host entity and the view mode; `__invoke()` returns the build via `pintoBuild()`:

```php
#[ThemeDefinition(definition: ['variables' => ['test' => NULL]])]
final class FoobarObject implements BlockBundleObjectInterface {
  use DrupalObjectTrait;
  private function __construct(
    private readonly BlockBundle $blockContent,
    private readonly ContentEntityInterface $entity,
    private readonly string $viewMode,
  ) {}
  public static function create(BlockContentInterface $blockContent, ContentEntityInterface $entity, string $viewMode): static {
    return new static($blockContent, $entity, $viewMode);
  }
  public function __invoke(): mixed {
    return $this->pintoBuild(fn (mixed $build): mixed => $build + [
      '#test' => ['#plain_text' => $this->blockContent->getSomething() ?? ''],
    ]);
  }
}
```

## 3. Link object to bundle class
Add the attribute to the bundle class:

```php
#[\Drupal\pinto_block\Attribute\PintoBlock(objectClassName: FoobarObject::class)]
final class Foobar extends \Drupal\block_content\Entity\BlockContent {
  public function getSomething(): ?string { return $this->something->value ?? NULL; }
}
```

At render time `LayoutBuilderEventSubscriber` detects the `#[PintoBlock]` attribute on the block's bundle class and builds the block through `FoobarObject` instead of the default block build.
