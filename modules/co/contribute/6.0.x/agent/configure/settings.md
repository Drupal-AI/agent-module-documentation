<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Contribute — configuration

## Config object `contribute.settings`
Schema `config/schema/contribute.settings.schema.yml`. Install defaults: `status: true`, `account_type: user`, `account_id: null`.

| Key | Type | Default | Meaning |
|---|---|---|---|
| `status` | boolean | `true` | Master switch — when false the Community Information section is not displayed. |
| `account_type` | string | `user` | Either `user` (Drupal.org individual) or `organization`. |
| `account_id` | string | `null` | Drupal.org username, or an organization's exact title. `null`/empty → generic "join us" messaging. |

Read/write from CLI: `drush cget contribute.settings`, `drush cset contribute.settings account_id jrockowitz -y`. Changing config alone does not clear cached lookups — invalidate tag `contribute` (`drush cache:rebuild`, or save via the form).

## Settings form — route `contribute.settings`
- Path `/admin/reports/status/contribute/configure`, `_form: ContributeSettingsForm`, `_title: Configure Community Information`, permission `administer site configuration`.
- Linked as a "Configure" local task under the status report's Community Information section (`contribute.links.task.yml`, parent `contribute`); opens as an AJAX modal (`data-dialog-type: modal`, width 600) via `core/drupal.ajax`.
- Fields: `account_type` radios (Individual user / Organization); `user_id` textfield (autocomplete route `contribute.autocomplete/user`); `organization_id` textfield (manual, no autocomplete); `disable` checkbox ("Do not display contribution information"). Field visibility/required is driven by `#states`.
- Three submit paths (extends `ConfigFormBase`):
  - **Save** — writes `status: true` + chosen `account_type`/`account_id`. `validateForm()` sets the account via `contribute.manager`, calls `getAccount()`, and errors on `account_id` if `status` is false ("Invalid …").
  - **Clear** (op = "Clear", `button--danger`) — sets `status: true`, `account_type: null`, `account_id: null`; message "Community information has been cleared." Skips validation.
  - **Disable** (`disable` checked) — sets `status: false`, clears type/id; message "…has been disabled." Skips validation.
- Every submit calls `Cache::invalidateTags(['contribute'])` then redirects to `system.status`. The AJAX callback `submitAjaxForm()` returns an `HtmlCommand` (re-render with errors) or a `RedirectCommand` to the status report.

## Autocomplete — route `contribute.autocomplete`
- Path `/admin/reports/status/contribute/autocomplete/{account_type}` (default `user`), `ContributeAutocompleteController::autocomplete`, permission `administer site configuration`.
- For `account_type === 'user'` only, proxies `https://www.drupal.org/index.php?q=admin/views/ajax/autocomplete/user/{q}` and returns `[{value,label}]`. Organizations have no public partial-match endpoint, so `organization_id` is typed manually and validated on submit. Returns `[]` on any exception (drupal.org unreachable).
