<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AEO Multilingual: audit checks, services, routes & config

## Install & enable

```bash
composer require drupal/aeo_multilingual
drush en aeo_multilingual -y
# recommended companions for full auditing:
composer require drupal/metatag drupal/schema_metatag
```

Requires core **`language`**, **`content_translation`**, **`node`** and PHP **8.1+**. The
`meta_description` and `schema_markup` checks degrade gracefully (return a warning score) when
`metatag` / `schema_metatag` are not installed.

## The `AuditCheck` plugin type

- Annotation: `@AuditCheck` (`src/Annotation/AuditCheck.php`) — properties `id`, `label`,
  `description`, `weight` (lower runs first).
- Manager: `AuditCheckManager extends DefaultPluginManager` (service
  `aeo_multilingual.audit_check_manager`), dir `Plugin/AuditCheck`, interface
  `AuditCheckInterface`, alter hook `aeo_multilingual_audit_check_info`, cache key
  `aeo_multilingual_audit_check_plugins`.
- Interface `AuditCheckInterface::audit(NodeInterface $node, string $langcode): array` must return
  `['score' => int 0-100, 'message' => string, 'status' => 'pass'|'warning'|'fail',
  'suggestions' => string[]]`. Base class `AuditCheckBase` (has `StringTranslationTrait`,
  `getWeight()`, `getLabel()`, `getDescription()`).

### Shipped checks (`src/Plugin/AuditCheck/`)

| id | weight | What it does |
|---|---|---|
| `hreflang` | 2 | Scores the fraction of active languages the node is translated into; lists missing languages. |
| `schema_markup` | 3 | Via `metatag.manager`, looks for a JSON-LD (`application/ld+json`) element / `schema_*` tag with `inLanguage` = langcode. Warns if `schema_metatag` absent. |
| `meta_description` | 4 | Reads the resolved meta description (`tagsFromEntityWithDefaults` → `strip_tags`), scores presence and length (optimal 120-160 chars). Warns if `metatag` absent. |
| `header_hierarchy` | — | Parses the body for H1-H6; penalizes multiple H1 / missing H2. |
| `image_alt_text` | — | Parses body images; scores the fraction that have alt text. |
| `content_length` | — | Word count of text fields; higher for longer content. |
| `translation_completeness` | — | Compares key translatable fields against the source language. |

All check `message`/`suggestions` are built with `$this->t()` (translatable, escaped placeholders).

## Services & scoring

- `Service\AuditService` (`aeo_multilingual.audit`): `auditNode($node)` loops active languages,
  runs `auditNodeLanguage($node, $langcode)` for each translated language — which sorts check
  definitions by `weight`, `createInstance()`s and runs each plugin (exceptions are logged, not
  fatal), then asks the score calculator for the overall score/status.
- `Service\ScoreCalculator` (`aeo_multilingual.score_calculator`): `calculateOverallScore()` =
  integer mean of the check scores; `getStatus()` ≥80 `pass` / ≥50 `warning` / else `fail`;
  `getScoreClass()` good/warning/poor.

## Routes & permissions

`aeo_multilingual.routing.yml` + `aeo_multilingual.permissions.yml`:

| Route | Path | Controller/Form | Permission |
|---|---|---|---|
| `aeo_multilingual.settings` | `/admin/config/search/aeo-multilingual` | `Form\SettingsForm` | `administer aeo multilingual` (`restrict access: true`) |
| `aeo_multilingual.dashboard` | `/admin/reports/aeo-multilingual` | `AeoMultilingualDashboard::dashboard` | `view aeo multilingual reports` |
| `aeo_multilingual.node_audit` | `/node/{node}/aeo-multilingual` (`node: \d+`) | `AeoMultilingualDashboard::nodeAudit` | `view aeo multilingual reports` |

Permissions: `administer aeo multilingual`, `view aeo multilingual reports`,
`run aeo multilingual audits` (declared; the built-in report pages run audits inline). Menu links:
settings under *Configuration → Search*, dashboard under *Reports*; the node tab is a local task on
`entity.node.canonical`.

## Controller behaviour

- `dashboard()` runs an access-checked node query (`accessCheck(TRUE)`, `status = 1`, up to 50 nodes),
  optionally filtered by `enabled_content_types`, audits each, and builds `#theme =>
  aeo_multilingual_dashboard` with per-language score columns and a `buildSummary()` average per
  language. `max-age = 0`.
- `nodeAudit(NodeInterface $node)` audits the route's node and builds `#theme =>
  aeo_multilingual_node_tab` (per-language sections, per-check rows with score/status/suggestions).
  Cache tags = the node's; `max-age = 0`.

Templates `templates/aeo-multilingual-dashboard.html.twig` and `…-node-tab.html.twig` render all
values through Twig autoescaping (node titles, check messages, suggestions) — no `|raw`.

## Configuration (`aeo_multilingual.settings`)

| Key | Type | Default | Meaning |
|---|---|---|---|
| `enabled_content_types` | sequence | `[]` (all) | Content types to audit; empty = every type. |
| `score_threshold` | integer | `70` | Nodes below this are flagged. |

Schema: `config/schema/aeo_multilingual.schema.yml`. Install defaults:
`config/install/aeo_multilingual.settings.yml`. Set both via `Form\SettingsForm`
(`administer aeo multilingual`).

## Extend it

Add a check by dropping a plugin in `yourmodule/src/Plugin/AuditCheck/` with `@AuditCheck(id=…,
label=…, weight=…)`, extending `AuditCheckBase` and implementing `audit()`. It is auto-discovered and
included in the average; use `$this->t()` for messages/suggestions.
