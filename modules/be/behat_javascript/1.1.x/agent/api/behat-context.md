# The Behat subcontext (JS error capture)

Source: `behat_javascript.behat.inc` (`BehatJavascriptContext extends DrupalSubContextBase`) +
`assets/js/window_errors.js`. Discovered automatically by `drupal/drupal-extension` as a Drupal
subcontext — no wiring needed beyond having DrupalExtension configured in `behat.yml`.

## How error capture works

1. `hook_page_attachments` attaches library `behat_javascript/errors` to **every** page. Its script sets:
   ```js
   window.jsErrors = [];
   window.onerror = function (msg, filename, lineno, colno, error) {
     window.jsErrors.push(error instanceof Error
       ? 'Filename: '+filename+' ; Error: '+msg+' ; Lineno: '+lineno+' ; Colno: '+colno
       : msg);
   };
   ```
2. `@BeforeScenario` (`prepare()`) enables checking only when ALL hold: a Mink session exists, the default
   session is `selenium2`, the scenario has steps (or the feature has a background), and neither the
   scenario nor feature carries the ignore tag. It records `scenarioData` = `<feature-file>.<scenario-line>`.
3. `@AfterStep` (`lookForJavascriptErrors()`) — if enabled and the session is started — runs
   `evaluateScript("return window.jsErrors")`, filters out entries matching any configured ignore regex
   (`behat_javascript.settings:ignored_errors`, one pattern per line), and if any remain: prints the
   feature file + step line, a count, and each error, then `throw new \Exception(...)` to **fail the step**.

## Tags & session requirements

- Only `@javascript` scenarios run under the `selenium2` driver are checked (headless/Goutte sessions are
  skipped because they cannot run JS).
- Tag a scenario or feature `@ignore-js-error` (constant `IGNORE_TAG`) to skip JS-error checking for it.

## Notes for authors

- Errors accumulate in `window.jsErrors` across the pages visited in a scenario until a new page load
  resets the array; the `@AfterStep` hook drains/reads them after every step.
- `setMink()` / `getMink()` are overridden only because the parent's `$mink` property is private.
- The check is per-step, so the first step that observes an unignored error fails the scenario there.
