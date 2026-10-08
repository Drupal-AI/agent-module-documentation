<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Behat UI is a web interface for authoring and running Behat/Mink (Gherkin) functional tests against a Drupal site from inside the admin UI.

---

Behat UI wraps a project's existing Behat installation (its `behat` binary, `behat.yml`, and `.feature` files) behind an admin UI at `/admin/config/development/behat-ui`. From there a developer can run the whole configured feature suite in the background, watch a live status/report iframe, kill a running run, and author single scenarios either through a guided step-by-step form (Given/When/Then/And/But selects with step autocomplete) or as free-text Gherkin in an Ace editor, running each new scenario on demand. Reports render as an HTML report (through `webship/behat-html-formatter`) or as a plain console log, and either can be downloaded. It is a development/CI tool: it shells out to the configured Behat binary on the server and executes whatever the site's FeatureContext/Mink step definitions do, so the ability to run and create tests should be limited to trusted developers and the module is best kept out of production. All paths (binary, config dir, `behat.yml`, features dir, report/log dirs, autoload) and options (HTTP auth, tags, editing mode) are set on the Settings tab; the module ships defaults but no Behat installation of its own.

---

- Run an existing Behat feature suite from the Drupal admin UI.
- Trigger a run in the background so long suites don't block the page.
- Poll run status and see whether a test process is still running.
- Kill a stuck or long-running Behat process from the UI.
- View the latest HTML test report inline in an iframe.
- View a plain console-log report when HTML reports are disabled.
- Download the last report as HTML (`/behat-ui/download/html`).
- Download the last log as plain text (`/behat-ui/download/txt`).
- Author a new scenario with the guided step builder (Given/When/Then/And/But).
- Autocomplete Behat step definitions while typing a step.
- Browse the list of available step definitions (`behat -dl`).
- Browse step definitions with extended info (`behat -di`).
- Write raw Gherkin in the free-text Ace editor with syntax highlighting.
- Run a single just-written scenario immediately without saving the suite.
- Optionally persist user-authored test features to the features directory.
- Append a new scenario to an existing `.feature` file and download it.
- Choose which existing feature file a new scenario targets.
- Mark a scenario as needing a real (JavaScript/Selenium) browser.
- Point the module at any Behat binary and `behat.yml` location.
- Configure HTTP basic-auth credentials for the target site under test.
- Restrict HTTP basic-auth to headless (non-JavaScript) test runs only.
- Maintain a list of Behat tags (`@javascript`, `@api`, `@local`, etc.) for reference.
- Switch report format between HTML and console log per environment.
- Use in local/CI/development environments rather than production.
- Restrict the run/create/administer permissions to trusted developers.
