Behat javascript is a testing-only module that captures JavaScript runtime errors during Behat/Mink (Selenium2) scenarios and fails the scenario when unignored errors are found. It is a Drupal-module adaptation of `25th-floor/behat-js-errorlog`.

---

The module attaches a tiny JS library (`assets/js/window_errors.js`) to **every** page via
`hook_page_attachments`; that script installs a `window.onerror` handler that pushes each error into a
global `window.jsErrors` array. A Behat subcontext (`BehatJavascriptContext` in `behat_javascript.behat.inc`,
registered through `drupal/drupal-extension`) hooks `@BeforeScenario` to enable itself only for `@javascript`
scenarios running under the `selenium2` Mink session (skipping empty scenarios and anything tagged
`@ignore-js-error`), and `@AfterStep` to read `window.jsErrors` via `evaluateScript`, filter out
admin-configured ignore patterns, print any remaining errors with file/line context, and `throw` to fail the
step. Ignore patterns are managed on a small settings form at
`/admin/config/development/behat-javascript` (permission `administer site configuration`) and stored as the
newline-delimited string `behat_javascript.settings:ignored_errors`; each line is used as a regular
expression (`preg_match('/<line>/', $error)`). The module explicitly warns it **must not be installed in
production** — it exists purely to surface JS errors to your test suite. No permissions of its own, no Drush,
no plugin types; it does provide a config schema for the single setting.

---

- Fail a Behat `@javascript` scenario automatically when the browser logs a JavaScript error.
- Surface `window.onerror` messages (filename, message, line, column) in Behat output for debugging.
- Catch regressions where a page silently throws JS errors that functional assertions would miss.
- Ignore known/benign JS errors by adding regular-expression patterns on the settings form.
- Skip JS-error checking for a specific scenario or feature by tagging it `@ignore-js-error`.
- Limit error checking to real-browser runs by keying off the `selenium2` Mink session.
- Integrate with an existing `drupal/drupalextension` Behat setup with zero code changes.
- Collect JS errors across every visited page during a scenario via the global `window.jsErrors` array.
- Add JS-error gating to CI pipelines that already run Behat + Selenium.
- Get file/line context for the failing step to speed up triage.
- Centrally manage the ignore list per environment through Drupal config.
- Adapt the `25th-floor/behat-js-errorlog` approach to a Drupal contrib workflow.
- Verify that a JS-heavy feature (AJAX forms, sliders) throws no console errors during acceptance tests.
- Ensure third-party/embedded scripts do not introduce errors on key pages under test.
- Enable/disable checking per environment simply by enabling the module only in test/CI.
