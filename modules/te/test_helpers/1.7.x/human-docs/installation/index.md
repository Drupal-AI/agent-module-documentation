# Installation

## Requirements

- **Drupal 11.3 or 12** (`core_version_requirement: ^11.3 || ^12`).
- No other module dependencies, and no third‑party PHP library requirements.

Test Helpers provides no permissions, routes, or configuration — it is a developer
testing API.

## Install as a Composer dev dependency (recommended)

Because you use Test Helpers from your test code, you normally add it as a **dev**
dependency and never enable it in Drupal or ship it to production. From the project
root:

```bash
composer require --dev drupal/test_helpers
```

This approach even works on Drupal.org's testing infrastructure and for testing
Drupal core features. The Composer package name (`drupal/test_helpers`) matches the
module's machine name (`test_helpers`).

> **Using DDEV?** Prefix Composer with `ddev` when you run from your host machine —
> `ddev composer require --dev drupal/test_helpers`. Inside the container
> (`ddev ssh`) run it without the prefix.

## Enabling it in Drupal (optional)

For most unit‑testing use you do **not** need to enable the module — having it
available via Composer is enough. If a particular workflow does require it enabled:

```bash
drush en test_helpers -y
```

## Verify it worked

In a test class, reference the `TestHelpers` API (for example
`TestHelpers::saveEntity('node', ['type' => 'article', 'title' => 'A1'])`) and run
your test suite. See the [main guide](../index.md) and the module's example test
classes for complete patterns.
