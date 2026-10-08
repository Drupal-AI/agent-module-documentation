<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Drupal Test Assertions is a test-only helper library that ships eight reusable PHPUnit assertion traits under `Drupal\Tests\drupal_test_assertions\Assertions`, so a Drupal functional/kernel test class can `use` a trait and get higher-level, Drupal-aware assertions instead of re-writing the same low-level checks.

---

The project contains **no runtime code** — no routes, permissions, services, config schema, hooks or `.module` file — only trait files under `tests/src/Assertions/`. Eight traits are provided: `FieldsTrait` (field existence, required/not-required, form-display visibility, entity-reference target bundles), `EntityTrait` (`assertEntityExists`), `RolesTrait` (role existence and permissions), `UsersTrait` (security-posture checks: anonymous registration off, restrict-access permissions withheld from anonymous/authenticated), `PageTrait` (metatag, redirect, URL, status-code and page-content assertions built on Mink's `getSession()`/`assertSession()`, plus a `tryOrRepeat()` retry helper), `LanguageTrait` (`assertLanguageExists`), `BookTrait` (allowed book outline types and child type), and `ContentModerationTrait` (moderation enabled, workflow assignment, and workflow transition presence/absence). A test class composes the traits it needs with `use`, then calls their `assert*` methods; each assertion delegates to a standard PHPUnit/Mink assertion (`assertTrue`, `assertEquals`, `assertMatchesRegularExpression`, `addressEquals`, etc.) with a descriptive message. The traits read Drupal configuration and state through the static `\Drupal` service locator (`entity_type.bundle.info`, `entity_display.repository`, `user.permissions`, `content_moderation.moderation_information`, config, entity storage), so they must run inside a bootstrapped Drupal test (kernel or browser) and the relevant modules (workflows/content_moderation, user, language, book, field) must be present for the trait that targets them. Because it is a testing library it is normally required as a **dev dependency** and does not need to be enabled as a module to be used from tests, although enabling it in the test environment is harmless. It imposes nothing on a production site.

---

- `use` `FieldsTrait` and assert a bundle has a field with `assertEntityTypeHasField('field_summary', 'node', 'article')`.
- Assert a field is required or not with `assertFieldIsRequired` / `assertFieldIsNotRequired`.
- Assert a field is shown or hidden on a form display with `assertFieldIsVisibleInForm` / `assertFieldIsHiddenInForm` (optionally per form mode).
- Assert an entity-reference field can target given bundles with `assertEntityReferenceTargetBundles`.
- Assert an entity-reference field targets *only* those bundles with `assertEntityReferenceTargetBundlesStrict`.
- Assert an entity type / bundle exists with `EntityTrait::assertEntityExists`.
- Assert a role exists with `RolesTrait::assertRoleExists`.
- Assert a role (or its inherited authenticated permissions) grants a set of permissions with `assertRoleHasPermissions`.
- Add a security regression check that anonymous users cannot self-register with `UsersTrait::assertNoCreateAccountsAllowed`.
- Add a security regression check that no restrict-access permission is granted to anonymous or authenticated roles with `assertUnprivilegedRolesCannotPerformRiskyActions`.
- Assert a meta tag with a given property and content is on the current page with `PageTrait::assertMetatag`.
- Assert the response was a 3XX redirect to a URL with `assertRedirectedTo`.
- Assert the current URL with `assertUrlIs`, or the HTTP status code with `assertStatusCode`.
- Assert raw page HTML contains / does not contain a string (with page dump on failure) using `assertPageContains` / `assertPageNotContains`.
- Retry a flaky callback up to five times with `PageTrait::tryOrRepeat`.
- Assert a configurable language exists with `LanguageTrait::assertLanguageExists`.
- Assert which node types are allowed in book outlines with `BookTrait::assertBooksAllowedInOutlines`.
- Assert the configured book child type with `assertBookChildPages`.
- Assert an entity type/bundle is under content moderation with `ContentModerationTrait::assertModerationEnabledForEntityType`.
- Assert which workflow moderates a bundle with `assertWorkflowForEntityType`.
- Assert a workflow has (or lacks) a transition between two states with `assertWorkflowHasTransition` / `assertWorkflowNotHasTransition`.
- Compose several traits in one test class to keep test code DRY across modules and projects.
- Require it as a dev-only Composer dependency so it never ships to production.
- Standardise a team's Drupal-aware assertions across multiple test suites and CI pipelines.
