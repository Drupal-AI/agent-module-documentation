# Installation

Sqlite Test Cache is a test helper, so "installation" is really about making the
base class available to your test suite and pointing your tests at a SQLite
database. **You do not need to enable it as a module** — the base class just needs
to be present in the codebase.

## Requirements

- **Drupal 8, 9 or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- Your kernel tests must run against the **SQLite database driver** — the caching
  only applies to SQLite.
- No other module dependencies or PHP libraries.

## Add it to your project

Add it as a development dependency from the project root:

```bash
composer require --dev drupal/sqlite_test_cache
```

> **Using DDEV?** Prefix Composer with `ddev` when you run from your host machine —
> `ddev composer require --dev drupal/sqlite_test_cache`. Inside the container
> (`ddev ssh`) run it without the prefix.

There is **no `drush en` step** — the module has no runtime code to enable. It only
provides the `SqliteCachedKernelTestBase` class for your tests to extend.

## Point your tests at a SQLite database

Set the `SIMPLETEST_DB` environment variable to a SQLite file location. For the
fastest results, keep it in memory, for example:

```
SIMPLETEST_DB=sqlite://localhost//dev/shm/test.sqlite
```

## Verify it worked

Create a kernel test class that extends `SqliteCachedKernelTestBase`, move your
installation code into `setUpDatabase()` and your per‑test setup into
`setUpClass()` (see the [main guide](../index.md)), and run your suite. On the
second run you should see the setup skipped and the tests start noticeably faster,
with cached files named `cache-…` appearing alongside your test database.
