<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Alt-Text Validation — agent index

Validates image alt text against configurable rules on save, and audits alt text site-wide
into a downloadable report. Depends on core `field`, `views`, and contrib `views_data_export`
(CSV). `configure` route `alt_text_validation.setting`. No plugin types of its own.

- **Settings form, the `alt_text_rule` config entity, all rule types, the six default rules,
  the audit/report and how to populate it** → [configure/settings.md](configure/settings.md)
- **The two permissions** → [permissions/permissions.md](permissions/permissions.md)
- **Drush commands** → [drush/drush.md](drush/drush.md)
- **Services (`auditor`, `validationtools`, `audit_service`, batch), the constraint, image
  extraction, extension points** → [api/services.md](api/services.md)

Key facts:
- Constraint `AltTextRules` is auto-attached by `hook_entity_bundle_field_info_alter()` to
  image fields and text fields that may hold `<img>` tags. Master switch
  `alt_text_validation.settings:alt_text_validation_enabled` gates on-save validation.
- Rules: config entity `alt_text_rule`, `admin_permission = administer alt text validation`,
  fields `rule_type`, `content_char_limit`, `text_to_compare`, `violation_action`
  (`prevent`/`warn`/`off`), `violation_message`. Match logic in `AltTextRule::isViolation()`.
- Audit table `alt_text_validation_audit` (schema in `config/schema`, not an entity); report
  is View `alt_text_report` at `/admin/reports/alt-text-report`. Populate via cron, the batch
  button (`/admin/reports/alt-text-report/rebuild`), or `drush alt-text-validation:queue-audit`.
- Messages rendered via SDC components `alt_text_validation:atv-warning` / `:atv-prevent`.
