# Panther — manual setup guide

**Panther** (`panther`) integrates **Symfony Panther** — a real-browser testing
tool — into Drupal, so you can write functional tests in PHP that drive an actual
browser (Chrome or Firefox via WebDriver) instead of a headless HTTP client. That
lets your tests exercise JavaScript behavior and real rendering that a plain
request-based test cannot reach. A test looks like ordinary PHPUnit code:

```php
public function testLoginPage(): void {
  $this->maximizeWindow();
  $this->goToPage('/user/login');
  self::assertPageContains('Log in');
  $this->takeScreenshot('testLoginPage', 'login');
}
```

This is **development and CI infrastructure only** — you do not enable it on
production. It drives browsers over WebDriver and has no content or access role in
a running site. It ships a **`panther_examples`** submodule with sample tests to
copy from, and supports Drupal 10 and 11. (This is the 1.0.x line; a newer 2.0.x
major adds axe-core accessibility auditing and richer helpers — see that version's
docs if you're starting fresh.)

This guide is written for a **human** setting things up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install Panther with Composer, provide
   a WebDriver/browser endpoint, and enable it for your test runs.

There is **no admin settings form** — Panther is a test harness configured through
your test environment, not through the Drupal UI.

## How to use it

1. Install Panther and make a WebDriver browser (for example a Selenium Chrome
   container) available to your test environment — see
   [Installation](installation/index.md).
2. Write test classes that use the module's base test case and helper methods
   (`goToPage`, `maximizeWindow`, `assertPageContains`, `takeScreenshot`, and so
   on), placing them where Drupal discovers functional-JavaScript tests.
3. Start from the **`panther_examples`** submodule, which contains working example
   tests you can adapt.
4. Run your tests through PHPUnit as part of local development or CI. Keep the
   module out of production.
