# Test Helpers — manual setup guide

**Test Helpers** (`test_helpers`) provides an API that dramatically simplifies
writing Drupal tests — chiefly unit tests, but with helpers for functional and
Nightwatch tests too. It supplies ready‑made stubs and mocks for the Drupal core
services your code depends on, so you can cover all of a function's logic without
spinning up a full Drupal kernel, a database, or any real persistent storage.

The value is in how much test code it removes. It ships stubs for the most common
Drupal services — Entity Storage, EntityQuery, the Database, the Configuration
Factory, and many more — that can emulate creating, loading, saving and deleting
entities entirely in memory. On top of that it offers utility helpers for getting
private properties and methods out of classes, loading plugin definitions from a
YAML file, and similar chores. In the project's own worked example, a unit test
that covers a controller method drops from around 100 lines with the classic
approach to about 12 lines using the Test Helpers API — often fewer lines than the
code being tested.

This is a **developer tool**, and importantly one you usually do **not enable in
Drupal at all**. Because the API is used from your test code, you can simply add it
as a dev dependency with Composer and use it there — no installation on production,
and this even works on Drupal.org's own testing infrastructure and for testing
Drupal core itself. It has no content or access role, provides no configuration,
and ships no submodules. It supports **Drupal 11.3 and 12** (`^11.3 || ^12`). It
was presented at DrupalCon 2023.

This guide is written for a **human** developer. If you want terse, token‑cheap
references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — add it as a Composer dev dependency
   (and, optionally, enable it).

## How to use it

Once it is a dev dependency of your project or contrib module, you call its API
from your test classes. For example, the `TestHelpers` facade lets you set up a
config value, create in‑memory entities, and instantiate the class under test —
then assert on the result — all without a kernel bootstrap:

- `TestHelpers::service('config.factory')->stubSetConfig(...)` to seed config,
- `TestHelpers::saveEntity('node', [...])` to create in‑memory entities,
- `TestHelpers::createClass(SomeController::class)->someMethod()` to run the code
  under test.

See the module's "Test Helpers examples" and the bundled example test classes for
complete, runnable patterns.
