<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Assertion traits reference

All traits live in `tests/src/Assertions/`, namespace
`Drupal\Tests\drupal_test_assertions\Assertions`. Each method is a thin wrapper around a standard
PHPUnit / Mink assertion with a descriptive message. `use` a trait in a test class extending
`BrowserTestBase`/`KernelTestBase` (PageTrait needs a Mink session, so a browser/functional test).

## Install & enable

```bash
composer require --dev drupal/drupal_test_assertions
```

No dependencies, no permissions, no Drush, no config. Enabling as a module (`drush en
drupal_test_assertions -y`) is optional — traits are usable once the package autoloads.

## FieldsTrait.php — Field module

| Method | Signature | Asserts |
|---|---|---|
| `assertEntityTypeHasField` | `($field_name, $entity_type, $bundle)` | `field_config` entity `$entity_type.$bundle.$field_name` loads (field exists on bundle). |
| `assertFieldIsHiddenInForm` | `($field_name, $entity_type, $bundle, $form_mode='default')` | form display's `getComponent($field_name)` is NULL. |
| `assertFieldIsVisibleInForm` | `($field_name, $entity_type, $bundle, $form_mode='default')` | form display's `getComponent($field_name)` is not NULL. |
| `assertFieldIsRequired` | `($field_name, $entity_type, $bundle)` | field_config `required` is TRUE. |
| `assertFieldIsNotRequired` | `($field_name, $entity_type, $bundle)` | field_config `required` is FALSE. |
| `assertEntityReferenceTargetBundles` | `(array $expected_bundles, $field_name, $entity_type, $bundle)` | each expected bundle is in `settings.handler_settings.target_bundles`. |
| `assertEntityReferenceTargetBundlesStrict` | `(array $expected_bundles, $field_name, $entity_type, $bundle)` | as above AND no other bundle is targeted (two-way containment). |

Uses `\Drupal::entityTypeManager()->getStorage('field_config')` and
`\Drupal::service('entity_display.repository')->getFormDisplay(...)`.

## EntityTrait.php

- `assertEntityExists($entity_type, $bundle = NULL)` — bundle info from
  `entity_type.bundle.info`; asserts `$bundle` (defaults to `$entity_type`) is a non-empty entry.

## RolesTrait.php — user roles

- `assertRoleExists($role_name)` — `Role::load($role_name)` returns an object.
- `assertRoleHasPermissions($role_name, array $permissions)` — for each permission, the role
  **or the authenticated role** has it (inherited perms count).

## UsersTrait.php — security posture

- `assertNoCreateAccountsAllowed()` — `user.settings:register` equals
  `UserInterface::REGISTER_ADMINISTRATORS_ONLY` (anonymous self-registration is off).
- `assertUnprivilegedRolesCannotPerformRiskyActions()` — for every permission flagged
  `restrict access` (from `user.permissions` service), asserts neither `anonymous` nor
  `authenticated` role holds it.

## PageTrait.php — page / response (Mink)

- `assertMetatag($id, $value)` — regex-matches `<meta ... property="$id" ... content="$value" ... />`
  against `getSession()->getPage()->getHtml()`. (Note: `$id`/`$value` are interpolated raw into the
  regex — pass literal-safe values.)
- `assertRedirectedTo($url)` — status code is 3XX and `assertSession()->addressEquals($url)`.
- `assertUrlIs($url)` — `assertSession()->addressEquals($url)`.
- `assertStatusCode($code, $message='')` — `assertEquals($code, intval(getStatusCode()))`.
- `assertPageContains($text)` / `assertPageNotContains($text)` — string (not) in page HTML;
  like the core text helpers but dumps page HTML on failure.
- `tryOrRepeat(callable $callback, $args = [])` — retry helper (not an assertion): runs the
  callback, catching exceptions and re-trying after `sleep(2)` up to 5 times before re-throwing.

## LanguageTrait.php

- `assertLanguageExists($language_name)` — `ConfigurableLanguage::load($language_name)` is an object.

## BookTrait.php — Book module config

- `assertBooksAllowedInOutlines(array $node_types)` — `book.settings:allowed_types` equals the array.
- `assertBookChildPages($node_type)` — `book.settings:child_type` equals the value.

## ContentModerationTrait.php — content_moderation / workflows

- `assertModerationEnabledForEntityType(EntityTypeInterface $entity_type, $bundle)` — via
  `content_moderation.moderation_information` `shouldModerateEntitiesOfBundle()`.
- `assertWorkflowForEntityType(EntityTypeInterface $entity_type, $bundle, $workflow_name='default')`
  — the workflow returned by `getWorkflowForEntityTypeAndBundle()` has id `$workflow_name`.
- `assertWorkflowHasTransition($workflow_name, $from, $to)` — `Workflow::load()` +
  type-plugin `hasTransitionFromStateToState($from, $to)` is TRUE.
- `assertWorkflowNotHasTransition($workflow_name, $from, $to)` — same check is FALSE.
