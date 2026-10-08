<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Tap Payment — configuration & operation

## Enable & configure
1. `drush en tap_payment`.
2. **Configuration → Web services → Tap Payment** (`/admin/config/services/tap-payment`).
3. Choose environment and paste the matching secret key — Tap has no separate sandbox host; the environment is decided by which key you use. Keys are write-only (never rendered back).
4. No webhook URL to register in Tap: the module sends its own webhook and return URLs with every charge.

Keep keys out of exported config by setting them in `settings.php`:
```php
$config['tap_payment.settings']['live_secret_key'] = getenv('TAP_LIVE_SECRET_KEY');
```

## Permissions
- `administer tap payment` — configure credentials/environment.
- `view tap payment transactions` — read the ledger.

## Routes
| Route | Path | Access |
|-------|------|--------|
| tap_payment.settings | /admin/config/services/tap-payment | administer tap payment |
| tap_payment.transactions | .../transactions | view tap payment transactions (+admin) |
| tap_payment.webhook | POST /tap-payment/webhook | `_access: TRUE` — HMAC-authenticated, flood-limited |
| tap_payment.return | /tap-payment/return/{uuid} | `_access: TRUE` — UUID-addressed, flood-limited |

## Operational parameters (override in services.yml)
Timeouts (`http_timeout` 30s, `http_connect_timeout` 10s), retries (`http_max_retries` 2), webhook freshness window (30 days), flood limits (`webhook_flood_limit`, `return_flood_limit`, `pay_flood_*`), idempotency lifetime (900s), reconciliation grace/age/batch. These are protocol/operational facts, not merchant settings.

## Reconciliation
`tap_payment.reconciler` queues quiet/abandoned checkouts on cron (older than the grace window, younger than max age) to re-verify them against Tap.

## Requirements report
`hook_requirements` / `TapPaymentRequirements` warns on the status report when keys are missing or misconfigured.
