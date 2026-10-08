<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration — redirect_audit.settings

Settings form `Form\RedirectAuditSettingsForm` (extends `ConfigFormBase`) at route
`redirect_audit.settings` = `/admin/config/search/redirect/audit/settings`
(also linked from **Configuration → Search and metadata → Redirect → Audit**, a local
task tab and a menu link, both under `redirect.list`). Editable config name:
`redirect_audit.settings`. Gated by `administer redirect audit`.

## Config object `redirect_audit.settings`

Defaults from `config/install/redirect_audit.settings.yml`; types/labels in
`config/schema/redirect_audit.schema.yml` (type `config_object`):

| Key | Type | Install default | Form widget / range | Meaning |
|---|---|---|---|---|
| `autofix_enabled` | boolean | `false` | checkbox | When TRUE, the queue worker auto-fixes a detected chain immediately (never loops). |
| `scan_on_change` | boolean | `true` | checkbox | When TRUE, creating/editing a redirect queues it for re-analysis (see hooks). |
| `batch_size` | integer | `50` | number, 1–500 | Batch step size hint for processing. |
| `max_chain_depth` | integer | `10` | number, 5–50 | How many hops chain-following will follow before stopping. |
| `items_per_page` | integer | `20` | number, 5–100 | Rows per page in the dashboard results table. |

Notes:
- `max_chain_depth` is read (and cached) by `RedirectAuditAnalyzer::getMaxChainDepth()`
  and `RedirectAuditFixer::getMaxChainDepth()`; both fall back to `10` when unset. The
  fixer deliberately mirrors the analyzer so a fix never gives up earlier than detection.
- `items_per_page` is read by `RedirectAuditDashboardForm::buildResultsTable()` for the
  core pager; falls back to `20`.
- `autofix_enabled` is consulted only in `RedirectAuditQueueWorker::isAutofixEnabled()`
  (cron path). The dashboard **Fix** button and `drush raf` fix on demand regardless.
- `batch_size` is a stored preference; the batch driver `RedirectAuditBatch` uses its own
  step constants (`AUDIT_STEP_SIZE = 100`, `FIX_STEP_SIZE = 25`) and the analyzer uses
  `DETECT_CHAINS_BATCH_SIZE = 100` for chunk iteration.

## Drush

`drush redirect-audit:info` (`rai`) prints the current values of `autofix_enabled`,
`scan_on_change`, `max_chain_depth` and `batch_size`. Set values with core config, e.g.
`drush cset redirect_audit.settings autofix_enabled 1 -y`.

## Screenshot

![Redirect Audit settings form](../../../../../../../screenshots/redirect_audit/2.0.x/settings-form.png)
