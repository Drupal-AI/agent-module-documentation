# Behat javascript — manual setup guide

**Behat javascript** (`behat_javascript`) is a testing‑only helper that makes your
Behat/Mink acceptance tests fail when a page logs a JavaScript error. It's a
Drupal‑module adaptation of the `25th-floor/behat-js-errorlog` approach: it
installs a tiny `window.onerror` handler on every page that collects browser JS
errors into a global array, and it provides a Behat subcontext that reads that
array after every test step and throws — failing the scenario — if any unignored
error is found.

This catches a whole class of regressions that ordinary functional assertions
miss: a page can render and pass all your content checks while silently throwing a
JavaScript error that breaks an AJAX form, a slider, or an embedded script. With
this module enabled during tests, those errors turn a green build red, complete
with the file, message, and line number of the failing step.

Only `@javascript` scenarios running under the real‑browser `selenium2` driver are
checked (headless sessions can't run JS, so they're skipped), and you can exclude
any scenario or feature by tagging it `@ignore-js-error`. Because it attaches its
error‑capturing script to *every* page, the module is explicitly meant for test
and CI environments only.

> **Do not install this in production.** It exists purely to surface JavaScript
> errors to your test suite; enable it only in your test/CI environment.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (in test/CI only).

## Where it lives in the admin menu

The module's one setting sits at **Configuration → Development → Behat Javascript**
(`/admin/config/development/behat-javascript`), reachable by users with the
**Administer site configuration** permission. Everything else the module does
happens automatically inside your Behat runs — there's no other UI.

## How to use it

**1. Wire it into Behat.** The module ships a Behat subcontext
(`BehatJavascriptContext`) that is discovered automatically by
`drupal/drupal-extension`. As long as you already have DrupalExtension configured
in your `behat.yml`, there's nothing to add — the subcontext registers itself.

**2. Write JavaScript scenarios normally.** Tag the scenarios you want checked
`@javascript` and run them under the `selenium2` Mink session (a real browser).
After every step, the module reads the collected JS errors; the first step that
sees an unignored error fails the scenario there, printing the feature file, the
step line, a count, and each error message with its file/line/column.

**3. Skip specific scenarios.** Tag a scenario or feature `@ignore-js-error` to
turn off JS‑error checking for it.

**4. Ignore known‑benign errors globally.** Open the settings form at
**Configuration → Development → Behat Javascript** and fill in **Error messages to
ignore** — one entry per line. Each line is treated as a **regular expression**
(the module matches it with `preg_match('/<your line>/', $error)`), so mind
unescaped slashes and regex metacharacters. Matching errors are suppressed and
won't fail a scenario. The default is empty, meaning *any* JS error fails the
step. You can also set it from the command line:

```bash
ddev drush cset behat_javascript.settings ignored_errors "ResizeObserver loop limit exceeded
Script error\." -y
```

That single **ignored_errors** value (stored as
`behat_javascript.settings:ignored_errors`) is the module's only configuration —
otherwise, enabling it in your test environment is all that's needed.
