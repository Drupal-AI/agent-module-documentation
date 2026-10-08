<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The seed calculator and query mechanism

## Sort plugin

`ViewsRandomSeedRandom` (`@ViewsSort("views_random_seed_random")`, extends `SortPluginBase`).
Its `query()` builds a seeded random order:

- MySQL/MariaDB: `RAND(<seed>)`.
- PostgreSQL: runs `select setseed(<seed>)` then orders by `RANDOM()` (seed is a fraction,
  `time / 10000000000`).
- Search API views: if the query is a `SearchApiQuery`, it calls
  `addOrderBy('rand', NULL, order, '', ['seed' => …, 'formula' => …])` instead.

Cache contexts: adds the `user` context when `user_seed_type === 'diff_per_user'`.

## Service: `views_random_seed.seed_calculator`

Class `Drupal\views_random_seed\SeedCalculator`
(args: `@datetime.time`, `@keyvalue`, `@current_user`). Entry point:

```php
$seed = \Drupal::service('views_random_seed.seed_calculator')
  ->calculateSeed(array $options, string $view_name, string $display, string $db_type);
```

Behaviour:

- Seed name is `views_seed_name-<view>-<display>` (or `views_seed_name-<reuse_seed>` when
  `reuse_seed` is set).
- Storage: key-value collection **`views_random_seed`** for `same_per_user`; the PHP
  **session** (`$_SESSION[$seed_name]`) for `diff_per_user` (authenticated users, or anonymous
  when `anonymous_session` is on).
- The seed value is the request timestamp (`getRequestTime()`), used directly as the `RAND()`
  seed on MySQL.
- Reset: if `reset_seed_int !== -1`, once `seed + interval < now` a new seed is generated and
  the cache tag `views_random_seed-<view>-<display>` is invalidated. `reset_seed_int === 0`
  uses `reset_seed_custom` as the interval.

## Debugging

Set `$settings['views_random_seed_view_messages'] = TRUE;` in `settings.php` to print the
seed/reset decisions as Drupal messages while rendering.
