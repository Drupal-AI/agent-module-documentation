# Configure — Redirect Audit settings

Settings form `Drupal\redirect_audit\Form\RedirectAuditSettingsForm` (extends
`ConfigFormBase`), route **`redirect_audit.settings`** at
`/admin/config/search/redirect/audit/settings`, permission `administer redirect audit`.
Also linked as the module's `configure` route and reachable from the dashboard tab.

Single config object: **`redirect_audit.settings`** (schema
`config/schema/redirect_audit.schema.yml`).

| Key | Type | Default (`config/install`) | UI range | Effect |
|-----|------|-----|-----|--------|
| `autofix_enabled` | boolean | `false` | checkbox | When TRUE, the queue worker auto-fixes a detected chain immediately (loops are never auto-fixed). |
| `scan_on_change` | boolean | `true` | checkbox | When TRUE, creating/updating a redirect queues it for analysis on the next cron run; also drives install/update-hook queueing. |
| `batch_size` | integer | `50` | 1–500 | Stored setting for per-batch sizing. (Note: the dashboard batch step size is a fixed constant, 100 for scan / 25 for fix; see hooks doc.) |
| `max_chain_depth` | integer | `10` | 5–50 | How many hops the analyzer and fixer follow before stopping. Read by `RedirectAuditAnalyzer::getMaxChainDepth()` and `RedirectAuditFixer::getMaxChainDepth()`. |
| `items_per_page` | integer | `20` | 5–100 | Rows per page in the dashboard results table pager. |

## Set via drush / PHP

```bash
drush config:set redirect_audit.settings max_chain_depth 20 -y
drush config:set redirect_audit.settings autofix_enabled true -y
```

```php
\Drupal::configFactory()->getEditable('redirect_audit.settings')
  ->set('scan_on_change', TRUE)
  ->set('batch_size', 100)
  ->set('max_chain_depth', 15)
  ->set('items_per_page', 25)
  ->save();
```

## Notes

- Turning `scan_on_change` off stops new/edited redirects from being queued; existing
  queued items still process, and the dashboard **Audit** button / `drush ras` still work
  as an on-demand full scan.
- `max_chain_depth` is cached per request inside the analyzer/fixer; a `(int) ... ?: 10`
  guard means a 0/empty value falls back to 10.
- The fixer deliberately reads the same `max_chain_depth` the analyzer used, so a fix never
  gives up earlier than detection did.
