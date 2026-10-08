<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Services & extension points

## Services (`alt_text_validation.services.yml`)

### `alt_text_validation.validationtools` → `ValidationTools`
Runs rules against alt text. Key methods (interface `ValidationToolsInterface`):
- `getViolations(string $filename, string $alt, string $title): array` — messages from
  enabled **prevent** rules that match, keyed by rule label.
- `getWarnings(...): array` — same for **warn** rules.
- `validateImageField(string $field_name, EntityInterface $entity): array` — per-image
  validation results for an image field (filename/alt/title + violations/warnings + apex
  entity + metadata).
- `validateTextField(string $field_name, EntityInterface $entity): array` — same for each
  `<img>` found inside a formatted/text field.
- `getRules(): array` — all rules whose action is not `off` (access-check bypassed).
- Static `ValidationTools::extractImageTags(string $html): array` — parses an HTML snippet
  with `DOMDocument` and returns `[['src','alt','title'], …]` for each `<img>`.

### `alt_text_validation.auditor` → `Auditor`
Drives the site-wide audit (interface `AuditorInterface`):
- `queueAllImages(): void` — enqueues entities for auditing (Queue API:
  `atv_entity_types` → `atv_entity_instances`).
- `tryCron(): void` — called from `hook_cron`; rebuilds on the `cron_delay` schedule when
  `cron_enabled` is set.

### `alt_text_validation.audit_service` → `AuditStorage`
Reads/writes the `alt_text_validation_audit` table (interface `AuditStorageInterface`):
- `writeAuditRow(...)` — inserts one audit row (parameterized `insert()`).
- `truncateTable()` — clears the table and resets the audit State keys.
- `generateTestData()` — dev-only demo rows.

### `alt_text_validation.batch_processor` → `BatchProcessor`
Backs the report's "Rebuild" button (`AltTextValidationAudit::batchProcess`); runs the audit
as a Batch API job using the queue workers.

### Queue workers (`src/Plugin/QueueWorker`)
`EntityImageFieldQueuer` (processes `atv_entity_types`, expands to instances) and
`ImageFieldAuditor` (processes `atv_entity_instances`, audits one entity and writes rows).

## Validation constraint
- Constraint `AltTextRules` (`src/Plugin/Validation/Constraint/AltTextRulesConstraint.php`)
  is attached to alt-carrying fields by `alt_text_validation_entity_bundle_field_info_alter()`.
- `AltTextRulesConstraintValidator` builds messages via the `atv-prevent` / `atv-warning`
  SDC components, adds warnings through the messenger, and raises a single violation for
  prevent errors. It skips validation when the master switch is off and on most AJAX requests
  (`shouldSkipAjaxValidation()` — media-library saves still validate).

## Extending
- **Add a rule type:** rule matching is hard-coded in `AltTextRule::isViolation()`; a new
  type needs a new `case` there plus the option in `AltTextRuleForm`. There is no plugin
  system for rules.
- **Alt-carrying field types:** governed by `AtvCommonTools::getAltContainingFieldTypes()`,
  `getImageFieldTypes()` (`image`), and `getTextImageFieldTypes()` — extend those to cover
  more field types.
- **Report:** the report is an editable View (`alt_text_report`) over the audit table; add
  columns/filters as with any view. Custom Views handlers live in `src/Plugin/views/`.
