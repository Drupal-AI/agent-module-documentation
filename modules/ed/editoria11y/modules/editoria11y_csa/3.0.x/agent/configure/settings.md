# Configure CSA

Settings form `Editoria11yCSASettings` at `/admin/config/content/editoria11y/csa` (route
`editoria11y_csa.settings`), config object `editoria11y_csa.settings` (schema
`config/schema/editoria11y_csa.schema.yml`). All routes require `administer editoria11y
checker`.

Key settings (`config/install/editoria11y_csa.settings.yml`):

| Key | Meaning |
|---|---|
| `roles` | Developer roles that see the developer test suite. |
| `contrast_check` | Enable the color-contrast test. |
| `contrast_ignore` | Selector(s) excluded from contrast checks (default `.sr-only`). |
| `tests_content` / `tests_off` / `tests_dev` | Override which tests show to editors, are disabled, or are developer-only. |
| `dev_check_root` / `specify_root` | Developer scan root (`automatic` or a selector). |
| `dev_domains` | Domain patterns treated as development environments. |
| `always_ignore` | Global ignore selectors. |

## Custom tests
`ed11y_custom_test` is a `@ConfigEntityType`. Manage at
`/admin/config/content/editoria11y/custom-tests` (collection route
`entity.ed11y_custom_test.collection`, plus add/edit/delete forms). Each entity defines a test
key, label, tooltip title and body — surfaced by the base checker when custom tests are enabled.

A crawler View (`ed11y_crawler`) and the Dashboard Actions form
(`/admin/reports/editoria11y/actions`) provide sweep and maintenance tooling.
