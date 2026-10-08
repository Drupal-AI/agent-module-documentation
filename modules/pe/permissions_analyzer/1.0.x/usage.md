<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Permissions Analyzer audits a site's roles and permissions, computing a security risk score per role and a global score, and flagging dangerous or unused roles from an admin report.

---

It helps administrators spot over-privileged roles: `DangerousPermissionAnalyzer` categorises sensitive permissions, `RiskScoreCalculator` assigns per-role and site-wide scores, and `PermissionAnalyzer` assembles the report with user counts per role and detection of roles nobody holds. The report lives at `/admin/reports/permissions-analyzer` and a machine-readable export at `/admin/reports/permissions-analyzer/export`; both are gated by the core `administer permissions` permission, so the site's weak spots are not exposed to non-privileged users. It reads role/permission configuration only and performs no mutation.

Set up by enabling the module and visiting Administration → Reports → Permissions Analyzer; use the export to snapshot posture over time or feed a review.

---
- Audit every role's permission set from one report.
- Get a per-role security risk score.
- See a global site security score.
- Detect roles holding dangerous/sensitive permissions.
- Categorize permissions by risk level.
- Count how many users hold each role.
- Flag unused roles (assigned to nobody).
- Jump straight to a role's edit page from the report.
- Export the analysis for record-keeping.
- Review privilege creep after a launch.
- Compare posture between environments via exports.
- Justify tightening an over-broad role.
- Find roles that duplicate administrator-level access.
- Track risk-score changes across audits.
- Restrict the report itself to `administer permissions` holders.
- Prioritize which roles to harden first.
- Support a periodic security review checklist.
- Spot accidental grants of destructive permissions.
