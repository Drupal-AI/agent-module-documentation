# Configuration

Panther has **no admin UI, no config entities, and no config schema**. It is
configured entirely through your **test environment**: a handful of environment
variables (read when tests run) plus an optional **`panther` service-container
parameter** block for overriding defaults. Defaults live in the module's
`src/Settings.php` and are validated so each value must be non-blank.

## Environment variables

These are read in the test base class's setup and when it builds the browser
client. A test throws a `RuntimeException` if a **required** one is missing.

| Variable | Required? | Purpose |
|----------|-----------|---------|
| `PANTHER_DRUPAL_ROOT` | **Required** | Absolute path to the Drupal root, for the driver bootstrap. |
| `PANTHER_DRUPAL_HOST` | **Required** | Base URL of the site under test, e.g. `http://web`. |
| `PANTHER_SELENIUM_HOST` | **Required** | WebDriver hub URL, e.g. `http://selenium-chrome:4444/wd/hub`. |
| `PANTHER_CONNECTION_TIMEOUT_MS` | Optional (default `5000`) | Selenium connection timeout, in milliseconds. |
| `PANTHER_REQUEST_TIMEOUT_MS` | Optional (default `5000`) | Selenium request timeout, in milliseconds. |

Set these in your test environment (for example your CI job, or a DDEV
configuration). Point `PANTHER_SELENIUM_HOST` at the Selenium/Chrome endpoint you
made available during installation.

## Service-container parameters

To change any default beyond the connection details, add a `panther:` parameter
block in a YAML file and load it from `settings.php`:

```php
// settings.php
$settings['container_yamls'][] = '/path/to/your/panther.services.yml';
```

```yaml
# panther.services.yml
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
    axe_best_practices: true
    fail_on_axe_error: false
    dump_accessibility_reports: true
```

Any key you omit uses its default. What each does:

- **`screenshots_dir`** — where failure and manual screenshots are written; created
  automatically during test setup.
- **`accessibility_reports_dir`** *(new in 2.0)* — where axe-core HTML reports are
  written; created automatically during test setup.
- **`login_url` / `logout_url`**, **`login_button` / `logout_button`**,
  **`username_field` / `password_field`** — drive the `loginAs()` helper. Defaults
  match Drupal's standard login form (`/user/login`, `Log in`, `name`, `pass`).
- **`axe_script_url`** — the CDN URL of axe-core injected into the page for
  accessibility runs.
- **`axe_tags`** — which WCAG rule sets axe checks against.
- **`axe_best_practices`** — when true, also adds axe's `best-practice` tag.
- **`fail_on_axe_error`** — `true` fails the test on accessibility violations;
  `false` marks the test *incomplete* instead.
- **`dump_accessibility_reports`** — when true, writes a scored HTML report per
  test to `accessibility_reports_dir`.

## Where these values are used

The login parameters feed the `loginAs()` helper; the axe parameters feed the
accessibility helpers (`runAccessibilityTestOnPath()` / `runAccessibilityTest()`).
For the full list of test base-class helpers and assertions, see the agent
reference at [`../agent/api/panther.md`](../agent/api/panther.md).

## Keep it out of production

All of this is test configuration. Panther is a dev/CI dependency — do not enable
the module or set these variables on a production environment.
