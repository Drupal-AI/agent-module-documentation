# Drupal Test Assertions — manual setup guide

**Drupal Test Assertions** (`drupal_test_assertions`) is a developer‑only library
of reusable PHPUnit assertion traits for Drupal functional and kernel tests.
Instead of re‑writing the same low‑level checks in every project, your test
classes `use` one of its traits and get higher‑level, Drupal‑aware assertions
like "this entity type has this field", "this role has these permissions", or
"anonymous users cannot register accounts".

The problem it solves is test duplication. Every team ends up writing the same
assertions about fields, roles, entities, pages, languages, books, and content
moderation. This module packages them once, as traits under
`Drupal\Tests\drupal_test_assertions\Assertions`, so you can compose several
traits into a single test class and keep your test code DRY across projects. Some
of the assertions are security‑oriented — for example checking that anonymous
registration is off, or that unprivileged roles do not hold restrict‑access
permissions — which makes them handy as regression checks in CI.

Two things are important to understand. First, it is **test‑only**: it contains no
runtime code — no routes, permissions, services, or `.module` file — just trait
files under `tests/src/Assertions/`. It imposes nothing on a production site.
Second, because it is a test helper you normally require it as a **dev
dependency** rather than a production one, and it does not even need to be
"enabled" as a module to be used from tests.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — require it as a dev dependency and use
   its traits in your tests.

There is **no configuration page** for this module — it is a developer/testing
library with no admin UI, settings, or runtime behavior.

## How to use it

In a functional or kernel test class, `use` the trait(s) you need and call their
assertions. The available traits include `UsersTrait`, `RolesTrait`,
`FieldsTrait`, `EntityTrait`, `PageTrait`, `LanguageTrait`, `BookTrait`, and
`ContentModerationTrait`. For example:

```php
use Drupal\Tests\drupal_test_assertions\Assertions\UsersTrait;
use Drupal\Tests\drupal_test_assertions\Assertions\FieldsTrait;

class MyModuleTest extends BrowserTestBase {

  use UsersTrait;
  use FieldsTrait;

  public function testSecurityPosture(): void {
    $this->assertNoCreateAccountsAllowed();
    $this->assertFieldIsRequired('node', 'article', 'field_summary');
  }

}
```

Available assertions include (among others) `assertEntityTypeHasField`,
`assertFieldIsRequired`, `assertRoleHasPermissions`,
`assertUnprivilegedRolesCannotPerformRiskyActions`, `assertNoCreateAccountsAllowed`,
`assertWorkflowTransition`, `assertStatusCode`, and `assertPageContains`.
