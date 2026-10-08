# Configure & run W3C Validator

## Settings form — `/admin/config/development/w3c_validator` (`w3c_validator.settings` route)

`W3cValidatorSettingsForm` edits config object `w3c_validator.settings`:

| Key | Type | Default | Meaning |
|---|---|---|---|
| `validator_url` | string (url) | `''` | W3C validator API endpoint. Empty -> library default `Validator::DEFAULT_VALIDATOR_URL` (validator.nu). Self-host `w3c_markup_validator` for volume. |
| `use_token` | bool | `TRUE` | Validate "as the current user" using a short-lived token (see token-auth doc) so restricted pages are visible; FALSE -> validate anonymously. |
| `admin_pages` | bool | `FALSE` | Include router/admin paths (non-argument, non-`<...>` patterns) in `findAllPages()`. |

`use_token` and `admin_pages` can also be set on the report's "advanced operations" form before a
re-validation run (`W3CValidatorOperationForm`), which saves them back to config.

```bash
ddev drush config:set w3c_validator.settings validator_url 'http://localhost/w3c-markup-validator' -y
ddev drush config:set w3c_validator.settings use_token 1 -y
```

## Report & validation flow

- **Report** `/admin/reports/w3c_validator` (`W3CLogController::overview`, the module's `configure`
  route): renders the "advanced operations" form on top, then a table of every page from
  `findAllPages()` with a validity status (Valid / Invalid / Outdated / Unknown, colour classes) built
  from stored results in the `w3c_validator` table; error/warning/info details expand per row.
- **Re-validate all**: the operations form redirects to the confirm form
  (`/admin/reports/w3c_validator/confirm`), which sets a batch running
  `W3CProcessor::validateAllPages()`.
- **`findAllPages()`**: front page + every row of `node_field_data`; plus router paths when
  `admin_pages` is on.
- **`validateAllPages()`**: if `use_token`, creates a token (`W3CTokenManager::createAccessToken`) and
  passes it as query `HTTP_W3C_VALIDATOR_TOKEN` so the fetch authenticates as the current admin;
  otherwise uses an `AnonymousUserSession`. Each page is access-checked with
  `AccessManager::checkNamedRoute()` for the validation identity before being sent to the validator; the
  token is revoked at the end.
- **`validatePage()`**: builds the absolute URL, calls `HtmlValidator\Validator::validateUrl()`, and
  merges the result (error/warning/info counts + serialized messages) into the `w3c_validator` table.

## Requirements

- Needs a reachable validator instance. The library default public service is discouraged for volume;
  the settings form and report both warn when a known rate-limited host (`validator.nu`,
  `validator.w3.org`) is configured.
- Depends on the `rexxars/html-validator` Composer library (installed with the module).
