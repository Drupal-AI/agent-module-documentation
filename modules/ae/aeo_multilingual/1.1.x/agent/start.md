<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AEO Multilingual (aeo_multilingual) — agent index

A **multilingual SEO/AEO auditing tool**: for each translation of a node it runs pluggable audit
checks and produces a per-language 0-100 score shown on an admin dashboard and a per-node tab. It is
**read-only reporting** — it does not change content or output meta tags. Depends on core
**`language`**, **`content_translation`**, **`node`**. Recommends `metatag` + `schema_metatag`.
Core `^10.2 || ^11`, PHP 8.1+. License GPL-2.0-or-later. Version 1.1.0.

- **Plugin type, the seven checks, services, routes, permissions & config** →
  [plugins/audit-checks.md](plugins/audit-checks.md)

## What it provides

- **Plugin type `AuditCheck`** — annotation-based (`@AuditCheck`, `src/Annotation/AuditCheck.php`),
  manager `AuditCheckManager` (service `aeo_multilingual.audit_check_manager`, dir
  `Plugin/AuditCheck`, interface `AuditCheckInterface`, base `AuditCheckBase`, alter hook
  `aeo_multilingual_audit_check_info`). Seven checks ship: `hreflang`, `schema_markup`,
  `meta_description`, `header_hierarchy`, `image_alt_text`, `content_length`,
  `translation_completeness`.
- **Services**: `aeo_multilingual.audit` (`Service\AuditService` — runs checks per node/langcode),
  `aeo_multilingual.score_calculator` (`Service\ScoreCalculator` — averages scores, maps to
  pass/warning/fail), `aeo_multilingual.audit_check_manager`.
- **Controller** `AeoMultilingualDashboard` with `dashboard()` and `nodeAudit()`.
- **Theme hooks** `aeo_multilingual_dashboard` and `aeo_multilingual_node_tab` (templates in
  `templates/`), library `aeo_multilingual/dashboard`.
- **Config** object `aeo_multilingual.settings` (`enabled_content_types`, `score_threshold`), schema
  in `config/schema/`, install defaults in `config/install/`.

## Routes & permissions (`*.routing.yml`, `*.permissions.yml`)

- `aeo_multilingual.settings` → `/admin/config/search/aeo-multilingual`
  (`Form\SettingsForm`, permission **`administer aeo multilingual`**, `restrict access: true`).
- `aeo_multilingual.dashboard` → `/admin/reports/aeo-multilingual`
  (`AeoMultilingualDashboard::dashboard`, permission **`view aeo multilingual reports`**).
- `aeo_multilingual.node_audit` → `/node/{node}/aeo-multilingual`
  (`AeoMultilingualDashboard::nodeAudit`, permission **`view aeo multilingual reports`**; a local
  task tab on the node). Third permission `run aeo multilingual audits` is declared but the shipped
  audits run inline in the report controllers.

## Mechanism (from source)

`AuditService::auditNode($node)` iterates active languages, and for each `hasTranslation()` langcode
runs every `AuditCheck` plugin (`audit($node, $langcode)` → `score`, `message`, `status`,
`suggestions`), then `ScoreCalculator::calculateOverallScore()` averages the check scores and
`getStatus()` maps ≥80 pass / ≥50 warning / else fail. The dashboard entity-query is access-checked
(`accessCheck(TRUE)`, `status = 1`, range 50). Output renders through `#theme` templates (auto-escaped;
no `|raw`). Both report pages set `max-age = 0`.
