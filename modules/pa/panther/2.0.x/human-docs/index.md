# Panther — manual setup guide

**Panther** (`panther`) integrates **Symfony Panther** — a real-browser (Chrome or
Selenium via WebDriver) testing and web-scraping library — into Drupal, so you can
write end-to-end tests in PHP that drive an actual browser. Tests can exercise
JavaScript-driven UI and client-side rendering that a headless HTTP client simply
cannot reach. A test looks like ordinary PHPUnit code:

```php
public function testLoginPage(): void {
  $this->maximizeWindow();
  $this->goToPage('/user/login');
  self::assertPageContains('Log in');
  $this->takeScreenshot('testLoginPage', 'login');
}
```

Your tests extend a base test case that boots Drupal, opens a real browser through
a Selenium/WebDriver endpoint, and mixes in a large set of helper traits:
navigation and form helpers (`goToPage`, `submitForm`, `clickLink`,
`loginAsUserByRole`), entity builders that create and auto-clean nodes, users,
roles, terms, languages, menus, media and files, DOM/crawler assertions, AJAX/JS
waiting, `fetchJson`, and automatic failure screenshots. This 2.0.x line also runs
**axe-core accessibility audits** on a page and dumps a scored HTML report.

This is **development and CI infrastructure only** — never enable it on production.
It has no routes, permissions, config entities, plugins, or Drush commands; all of
its setup is **environment variables plus an optional service-container parameter
block**. It supports Drupal 10 and 11, requires `drupal/drupal-driver ^3` and
`symfony/panther ^2.2`, and ships a **`panther_examples`** submodule.

> **New major (2.0.0) vs 1.x:** it now requires `drupal/drupal-driver ^3.0` (the
> entity layer moved to the driver's `EntityStubInterface` contract), the base
> `PantherTestCase` is now **abstract**, it adds a PHPUnit-style Panther result
> summary that marks tests *incomplete* distinctly, and it adds accessibility
> settings (`accessibility_reports_dir`, `dump_accessibility_reports`). See the
> module's `UPGRADING.md` for the manual dependency step.

This guide is written for a **human** setting things up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install Panther and its Composer
   dependencies, and provide a WebDriver/browser endpoint.
2. [Configuration](configuration/index.md) — the environment variables and the
   optional `panther` service-parameter block that drive the tests.

## How to use it

1. Install Panther and make a WebDriver browser (for example a Selenium Chrome
   container) reachable from your test environment — see
   [Installation](installation/index.md).
2. Set the required environment variables and, if you need to change defaults, add
   a `panther` service-parameter block — see [Configuration](configuration/index.md).
3. Write test classes in the `Drupal\Tests\panther\FunctionalJavascript` namespace
   that extend `PantherTestCase` and call its trait helpers and assertions.
4. Start from the **`panther_examples`** submodule's `HomePageTest`, which shows
   entity creation, login, screenshots, and an accessibility test.
5. Run your tests through PHPUnit locally or in CI. Keep the module off production.
