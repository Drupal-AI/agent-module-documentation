<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions Analyzer (permissions_analyzer) — agent index
**Audits roles/permissions, computing risk scores and flagging dangerous or unused roles in an admin report.**

- **Version:** 1.0.x  **Core:** ^10 || ^11
- **Routes (perm `administer permissions`):** `/admin/reports/permissions-analyzer`, `/admin/reports/permissions-analyzer/export`.
- **Services:** `permissions_analyzer.analyzer` (`PermissionAnalyzer`), `.risk_score_calculator`, `.dangerous_permission_analyzer`.
- **Security:** read-only audit; both the report and export are gated by the core `administer permissions` permission, so the site's security posture is not disclosed to lesser users. No mutation, no anonymous access. Sound.
