<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SendGrid Integration Simplenews Reports (sendgrid_integration_simplenews_reports) — agent index
**Per-newsletter-node SendGrid statistics tab (charts + CSV) for Simplenews issues.**

- **Version:** 2.0.x (dev checkout on branch `2.x`; nearest tag 2.0.0-alpha1 — no packaged version in info.yml)
- **Core:** ^10 || ^11 · **Depends on:** sendgrid_integration, sendgrid_integration_reports, simplenews
- **Route:** `…node_statistics` → `node/{node}/sendgrid-statistics` (`access sendgrid simplenews report` + custom `checkNodeAccess`)
- **Service:** `…reports_service` → wraps `sendgrid_integration_reports.api`

**Security:** No API key/HTTP here — SendGrid access is delegated to `sendgrid_integration_reports.api` (parent module owns credentials/TLS). Route is permission-gated AND restricted to nodes with a `simplenews_issue` field (else forbidden). CSV cells are escaped. No findings (only a stray `Drupal\shs` trait import). See [api/reports.md](api/reports.md).
