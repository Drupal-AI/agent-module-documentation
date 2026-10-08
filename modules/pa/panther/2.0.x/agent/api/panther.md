<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Writing a Panther test

There is no service to call from Drupal code — Panther is a **test harness**. You use it by
extending the base test case and calling the trait methods it mixes in. Namespace:
`Drupal\Tests\panther\FunctionalJavascript`.

## Base class

Extend `PantherTestCase` (a PHPUnit `TestCase`, **abstract** in 2.0). It:
- reads `PANTHER_DRUPAL_ROOT` / `PANTHER_DRUPAL_HOST`, boots Drupal via `DrupalDriver`;
- builds `$this->entityManager` (EntityManager) and `$this->settings` (Settings);
- runs each test **in a separate process** (`setRunTestInSeparateProcess(TRUE)`);
- in `tearDown`: screenshots on failure, quits/resets the browser client, and `cleanAll()`s
  every entity the test created.

Mixed-in traits: `PantherTrait`, `DrupalTrait`, `DrupalAssertionsTrait`,
`DomCrawlerAssertionsTrait`, `AccessibilityTrait`.

```php
use Drupal\Tests\panther\FunctionalJavascript\PantherTestCase;

class MyTest extends PantherTestCase {
  public function testHome(): void {
    $this->goToPage('/');
    self::assertPageContains('Welcome');
  }
}
```

## Navigation & browser (PantherTrait)
- `goToPage(string $path)` — GET a path in the browser.
- `maximizeWindow()`, `clickLink($text)`, `clickButton($text)`, `submitForm($button, $fields)`.
- `takeScreenshot($type, $test)` — manual PNG into `screenshots_dir`.
- `getClient()` (static) — the underlying `Symfony\Component\Panther\Client` for anything custom.

## Drupal actions (DrupalTrait)
- Auth: `loginAs($user, $pass)`, `logout()`, `loginAsUserByRole($roles, $fields = [])`,
  `loginAsUserWithPermissions(array $perms, $fields = [])`, `setUserPassword($user, $pass)`.
- Create (auto-cleaned in tearDown): `nodeCreate($array)`, `userCreate($array)`,
  `roleCreate(array $permissions)` → role name, `termCreate($array)`, `languageCreate($array)`,
  `menuCreate($array)`, `menuLinkContentCreate($menuName, $array)`, `mediaCreate($array)`,
  `fileCreate($array, $filepath, $directory = 'public://')`.
- Delete: `deleteUserByEmail($email)`, `deleteFileByUri($uri)`.
- Fields use the Behat-driver format: multi-value = comma-separated, compound properties via
  `field_name:column` keys (e.g. `'field_body:value'`, `'field_body:format'`).
- Tables/UI: `selectOperationOnTableRowWithText($text, $col, $op)`, `selectOption($label, $value)`,
  `selectCheckbox($fieldsetLabel, $checkboxLabel)`, `clickFieldCogButton($label)`,
  `clickSubmitButton()`, `expandToolbar()`, `scrollDownUntilVisible*`.
- Waiting/JS: `waitForAjaxToFinish($timeout = 1000)`, `waitOnJavascript($timeout, $condition)`,
  `waitForDomElement($selector)`, `waitForElementToBeClickable($xpath)`,
  `fetchJson($url)` (runs `fetch()` in the browser, returns decoded array).

## Assertions
DomCrawlerAssertionsTrait (static): `assertPageContains` / `assertPageNotContains`,
`assertSelectorExists` / `assertSelectorNotExists`, `assertSelectorCount`,
`assertSelectorTextContains` / `…TextSame` / `…TextNotContains` (+ `assertAnySelector*`),
`assertPageTitleSame` / `…Contains`, `assertInputValueSame` / `…NotSame`,
`assertCheckboxChecked` / `…NotChecked`, `assertFormValue` / `assertNoFormValue`, `assertEach`.

DrupalAssertionsTrait: `assertMessageContains($header, $message)`, `assertPageContainsNumTimes`,
`assertTableRowWithTextContains`, `assertElementDisabled` / `assertElementEnabled`,
`assertLoggedIn`, `assertResponseStatusCodeSame`, `assertUrlMatches`,
`assertSelectContainsOptions` / `assertSelectNotContainsOptions`,
`assertOperationsContainOnTableRowWithText` / `assertOperationsNotContainOnTableRowWithText`.

## Accessibility (AccessibilityTrait)
- `runAccessibilityTestOnPath($path, $timeout = 1000)` or `runAccessibilityTest($timeout)` —
  injects axe-core (`axe_script_url`), runs it with the configured `axe_tags`
  (+ `best-practice` when `axe_best_practices`), and asserts on violations.
- On violations: `fail_on_axe_error = true` → fails the test; otherwise `markTestIncomplete`.
- When `dump_accessibility_reports` is true, writes a scored HTML report (via
  `Axe\AccessibilityReportDumper`) to `accessibility_reports_dir`.

See the `panther_examples` submodule's `HomePageTest` for full working examples (node/recipe/user/
role/term/language/menu creation, login, screenshots, and an accessibility test).
