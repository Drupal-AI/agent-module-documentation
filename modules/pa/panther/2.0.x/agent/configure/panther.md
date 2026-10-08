<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Panther

No admin UI, no config entities, no config schema. Configuration is **environment variables**
(read at test run) plus an optional **`panther` service-container parameter** block. Defaults
live in `src/Settings.php` (resolved via Symfony OptionsResolver; each string is validated
`NotBlank`).

## Environment variables (required + optional)

Read in `PantherTestCase::setUp()` and `PantherTrait::getClient()`; a test throws
`RuntimeException` if the required ones are missing.

- `PANTHER_DRUPAL_ROOT` (required) — absolute path to the Drupal root, for the driver bootstrap.
- `PANTHER_DRUPAL_HOST` (required) — base URL of the site under test, e.g. `http://web`.
- `PANTHER_SELENIUM_HOST` (required) — WebDriver hub URL, e.g. `http://selenium-chrome:4444/wd/hub`.
- `PANTHER_CONNECTION_TIMEOUT_MS` (optional, default `5000`) — Selenium connection timeout (ms).
- `PANTHER_REQUEST_TIMEOUT_MS` (optional, default `5000`) — Selenium request timeout (ms).

## Service-container parameters

Put a `panther:` parameter block in a YAML file loaded via
`$settings['container_yamls'][] = …;` in `settings.php`. Any omitted key uses the default below.

```yaml
parameters:
  panther:
    screenshots_dir: '/var/www/html/web/sites/default/files/panther_screenshots'
    accessibility_reports_dir: '/var/www/html/web/sites/default/files/panther_accessibility_reports'
    login_url: '/user/login'
    logout_url: '/user/logout'
    login_button: 'Log in'
    logout_button: 'Log out'
    username_field: 'name'
    password_field: 'pass'
    axe_script_url: 'https://cdnjs.cloudflare.com/ajax/libs/axe-core/4.10.3/axe.min.js'
    axe_tags: ['wcag2a', 'wcag2aa', 'wcag21a', 'wcag21aa']
    axe_best_practices: true      # adds the 'best-practice' axe tag
    fail_on_axe_error: false      # true = fail on violations; false = markTestIncomplete
    dump_accessibility_reports: true  # write scored HTML report per test
```

Key notes (defaults in parentheses):
- `screenshots_dir` — where failure/manual screenshots are written; auto-created in setUp.
- `accessibility_reports_dir` — where axe HTML reports are written; auto-created in setUp. **(new in 2.0)**
- `login_url` / `logout_url` (`/user/login`, `/user/logout`), `login_button` / `logout_button`
  (`Log in`, `Log out`), `username_field` / `password_field` (`name`, `pass`) — drive `loginAs()`.
- `axe_script_url` — CDN URL of axe-core injected into the page for accessibility runs.
- `axe_tags`, `axe_best_practices`, `fail_on_axe_error`, `dump_accessibility_reports` — control the
  accessibility audit (see `runAccessibilityTestOnPath()` in [api/panther.md](../api/panther.md)).
