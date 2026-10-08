<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Writing a fixture generator (data_fixtures)

## Install / enable

`composer require drupal/data_fixtures` (pulls `fakerphp/faker ^1.15`), then
`drush en data_fixtures`. No config, permissions, or routes are created. Generators live in
**your own module(s)** — Data Fixtures only collects and runs them.

## The contract

Every generator implements `Drupal\data_fixtures\Interfaces\Generator`
(`src/Interfaces/Generator.php`):

- `load()` — create your fixture content.
- `unLoad()` — remove exactly what `load()` created (clean up "any mess left behind").

## Registering a generator (service tag)

Add the class as a service tagged `data_fixtures` in your module's `*.services.yml`:

```yaml
services:
  my_module.article_fixtures:
    class: Drupal\my_module\Fixtures\ArticleGenerator
    tags:
      - { name: data_fixtures, priority: 0, alias: articles }
```

`FixturesManager::addGenerator(Generator $generator, $priority = 0, $alias = NULL)` is the
`service_collector` callback (`data_fixtures.services.yml`, `call: addGenerator`). It wraps each
generator in a `FixturesGenerator` and marks the sorted list dirty.

- **priority** — integer; `sortGenerators()` does `ksort()` on priority then merges, so **lower
  priority runs first** on load. Use it to satisfy dependencies (e.g. create taxonomy before nodes).
- **alias** — optional. If empty, `FixturesGenerator::setAlias()` uses
  `(new \ReflectionClass($generator))->getShortName()` (the class name without namespace). The
  alias is what you pass to the Drush load/unload commands to target one generator.

## The collector service

`FixturesManager` (`src/FixturesManager.php`), service id **`data_fixtures`**:

- `getGenerators($reverse = FALSE)` — returns the priority-sorted `FixturesGenerator[]`, reversed
  when `$reverse` is true (used so **unload runs in the opposite order of load**).
- `addGenerator()` stores generators keyed by priority and rebuilds the sorted list lazily.
- `FixturesGenerator` (`src/FixturesGenerator.php`) exposes `getGenerator()`, `getAlias()`,
  `getClassName()`, and `prettyPrint()` (`"<alias> :: <FQCN>"`, shown by `fixtures:list`).

## Optional base class: AbstractGenerator

Extend `Drupal\data_fixtures\AbstractGenerator` (`src/AbstractGenerator.php`) for a ready Faker
instance (`$this->faker = Faker\Factory::create()`) and helpers. You still implement `load()` /
`unLoad()` yourself (the base class does **not** implement the interface for you — declare
`implements Generator`).

- `getLink($uri = NULL, $title = NULL)` — `['uri' => …, 'title' => …]` for a link field; falls back
  to `faker->url` / `faker->text(20)`.
- `getFormattedText($format, $text = NULL)` (protected) — `['value' => …, 'format' => …]`; text
  defaults to `faker->realText(400)`.
- `getRandomEntities($entity_type_id, array $conditions = [], $limit = 5)` (protected) — runs an
  `entityQuery` with **`accessCheck(FALSE)`**, statically caches results per condition-hash,
  `shuffle()`s and returns up to `$limit` loaded entities. For picking existing referenced content.
- `getMediaByName($name)` (protected) — loads all `media` entities (`accessCheck(FALSE)`), indexes
  those with `field_media_image` or `field_media_file` by the file's filename, returns the match or
  `NULL`. Pairs with the shipped `assets/images/*.jpg` and `assets/attachments/sample.pdf`.
- `unloadEntities($entity_type_id, array $conditions = NULL)` — entity-queries (`accessCheck(FALSE)`)
  and **deletes** all matching entities. Call it from `unLoad()`. Scope `$conditions` tightly:
  passing none deletes **every** entity of that type.

## Minimal example

```php
namespace Drupal\my_module\Fixtures;

use Drupal\data_fixtures\AbstractGenerator;
use Drupal\data_fixtures\Interfaces\Generator;
use Drupal\node\Entity\Node;

class ArticleGenerator extends AbstractGenerator implements Generator {
  public function load() {
    for ($i = 0; $i < 10; $i++) {
      Node::create([
        'type' => 'article',
        'title' => $this->faker->sentence(6),
        'body' => $this->getFormattedText('basic_html'),
      ])->save();
    }
  }
  public function unLoad() {
    $this->unloadEntities('node', ['type' => 'article']);
  }
}
```

Run it with the Drush commands in [../drush/commands.md](../drush/commands.md).

## Notes

- `Services\DummyGenerator` is `@deprecated`, not tagged/collected, and its `getText()` fetches a
  remote lipsum feed — **do not use it**; extend `AbstractGenerator` instead.
- Everything runs as the CLI/privileged Drush process with access checks disabled — intended for
  dev/test only, never production.
