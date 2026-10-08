# Sqlite Test Cache — manual setup guide

**Sqlite Test Cache** (`sqlite_test_cache`) is a developer aid that speeds up
PHPUnit **kernel tests**. Test suites are slow largely because every test method
rebuilds its environment from scratch in `setUp()` — installing config, schemas
and entity schemas over and over. In a large project those setup methods run
thousands of times. This module caches the *results* of that setup when you use
SQLite as the test database, so subsequent runs skip the expensive rebuild.

It works by giving you a base class, `SqliteCachedKernelTestBase`, that your own
kernel test classes extend instead of Drupal's `KernelTestBase`. There is **no
runtime code** — no routes, permissions, services or configuration. The module
ships only that one test base class, so it is purely a developer/CI tool with
nothing to expose and no security posture to manage. It targets Drupal 8, 9 and
10, and note it is in "no further development" status.

Because it is a test helper, you don't even need to enable it as a module — the
base class just needs to be present in your codebase (typically via
`require-dev`). The real work is in how you write your tests: extend the provided
base class and move your setup into two specific methods it defines.

This guide is written for a **human** developer. If you want terse, token‑cheap
references for an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — add the module to your dev/test
   environment and point `SIMPLETEST_DB` at a SQLite file.

## How to use it

Extend `SqliteCachedKernelTestBase` in your kernel test classes and follow its two
conventions:

- **`setUpDatabase()`** — put all your installation code here (`installConfig`,
  `installSchema`, `installEntitySchema`, and so on). This runs **once** for the
  whole test suite and its result is cached. Do **not** assign values to class
  properties here — they will not be present when the test runs.
- **`setUpClass()`** — put per‑test class setup here (for example
  `$this->entityTypeManager = $this->container->get('entity_type.manager');`).
  This runs before every test, like the usual `setUp()`.

Do **not** override `setUp()`, and do **not** call `parent::setUpDatabase()` or
`parent::setUpClass()` yourself — the base class calls them for you.

**When you change your setup:** after editing any `setUpDatabase()` code, delete
the cached files (their names start with `cache-`). If you run tests in Docker with
`SIMPLETEST_DB` under `/dev/shm`, simply restarting the container clears them.

**Known quirk:** occasionally the first test in a class fails with an unrelated
error caused by core's static caching. Adding an empty test method at the start of
the class forces a reload with the cached database and lets the remaining tests
run normally.
