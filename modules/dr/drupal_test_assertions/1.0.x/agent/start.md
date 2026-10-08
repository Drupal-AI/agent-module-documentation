<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drupal Test Assertions (drupal_test_assertions) — agent index

A **test-only** helper library: eight PHPUnit assertion traits under namespace
`Drupal\Tests\drupal_test_assertions\Assertions` (files in `tests/src/Assertions/`). A functional
or kernel test class `use`s the traits it needs and gains Drupal-aware `assert*` methods. Package
`Testing`. Core requirement `^8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 1.0.x.

## What it actually is

- **No runtime code**: no `.module`, routes, permissions, services, config schema, hooks, install,
  plugins or config. Only trait `.php` files under `tests/src/Assertions/`.
- **No declared module dependencies** (info.yml has no `dependencies`), but individual traits call
  core/contrib services via the static `\Drupal` locator, so the matching module
  (workflows/content_moderation, user, language, book, field) must be present for that trait.
- Normally required as a **dev** Composer dependency; it need not be enabled to `use` its traits
  from tests (enabling it in the test env is harmless).

## The eight traits (and every assertion) → [api/assertions.md](api/assertions.md)

- `FieldsTrait` — field existence, required-ness, form-display visibility, entity-reference target bundles.
- `EntityTrait` — `assertEntityExists`.
- `RolesTrait` — `assertRoleExists`, `assertRoleHasPermissions`.
- `UsersTrait` — `assertNoCreateAccountsAllowed`, `assertUnprivilegedRolesCannotPerformRiskyActions`.
- `PageTrait` — metatag / redirect / URL / status-code / page-content assertions (Mink), plus the
  `tryOrRepeat()` retry helper.
- `LanguageTrait` — `assertLanguageExists`.
- `BookTrait` — `assertBooksAllowedInOutlines`, `assertBookChildPages`.
- `ContentModerationTrait` — moderation-enabled, workflow assignment, transition present/absent.

## Use pattern

```php
use Drupal\Tests\drupal_test_assertions\Assertions\FieldsTrait;
use Drupal\Tests\drupal_test_assertions\Assertions\UsersTrait;

class MyTest extends BrowserTestBase {
  use FieldsTrait, UsersTrait;
  public function testPosture(): void {
    $this->assertFieldIsRequired('field_summary', 'node', 'article');
    $this->assertNoCreateAccountsAllowed();
  }
}
```
