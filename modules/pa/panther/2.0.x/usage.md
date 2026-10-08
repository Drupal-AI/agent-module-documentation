<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Panther integrates Symfony Panther, a real-browser (Chrome/Selenium via WebDriver) testing and web-scraping library, so you can write end-to-end Drupal tests in PHP that drive an actual browser.

---

Panther is a **developer/CI testing** module (not a runtime feature) that wires Symfony Panther into Drupal. Tests extend an abstract `PantherTestCase` base which boots Drupal via `drupal/drupal-driver`, opens a real Chrome session through a Selenium/WebDriver endpoint, and exposes a large set of trait methods: navigation and form helpers (`goToPage`, `submitForm`, `clickLink`, `loginAs`, `loginAsUserByRole`), entity builders that create and auto-clean nodes, users, roles, terms, languages, menus, media and files, DOM/crawler assertions (`assertPageContains`, `assertSelectorTextContains`, `assertTableRowWithTextContains`, `assertSelectContainsOptions`), AJAX/JS waiting (`waitForAjaxTofinish`, `waitOnJavascript`, `waitForDomElement`), `fetchJson`, and automatic failure screenshots. It also runs **axe-core accessibility audits** on a path and dumps an HTML report. Configuration is entirely code/env-based: environment variables select the Drupal root, host and Selenium endpoint, and an optional `panther` service-container parameter block overrides login URLs/fields, screenshot and report directories, and axe tags/behaviour. Version **2.0.0** requires `drupal/drupal-driver` 3.x and ports the entity layer to the driver's `EntityStubInterface` contract; `PantherTestCase` is now abstract. A custom PHPUnit extension prints a Panther-styled result summary and marks incomplete tests distinctly. A `panther_examples` submodule ships example tests. It is meant for dev/CI only — do not enable it on production.

---

- Write real-browser (Chrome/WebDriver) functional-javascript tests for Drupal.
- Test JavaScript-driven UI and client-side rendering that a headless HTTP client cannot exercise.
- Drive login/logout flows with configurable URLs, buttons and field names.
- Create test users with roles or permissions and log in as them in one call.
- Create and auto-clean nodes, terms, taxonomy, languages, menus, menu links, media and file entities per test.
- Assert page content, selectors, titles, input/checkbox/form values.
- Assert against admin table rows and dropbutton operations (`assertTableRowWithTextContains`, `assertOperationsContainOnTableRowWithText`).
- Select operations on a table row by text (`selectOperationOnTableRowWithText`).
- Assert select-element options are present or absent.
- Wait for AJAX to finish or for arbitrary JavaScript conditions / DOM elements.
- Fetch JSON from an endpoint via the browser (`fetchJson`).
- Run axe-core accessibility audits on a page and produce a scored HTML report.
- Fail or mark-incomplete a test on accessibility violations via config.
- Capture screenshots automatically on test failure, or on demand.
- Run each test in a separate process for isolation.
- Configure Selenium/connection/request timeouts via env vars.
- Point tests at any Drupal host + Selenium hub (e.g. a DDEV Selenium container).
- Scroll elements into view and wait for them to be clickable.
- Set a user's password, add users to roles programmatically.
- Provide a `panther_examples` submodule as a copy-paste starting point.
- Get a PHPUnit-style Panther result summary in CI output.
- Keep it as a dev dependency — off production.
