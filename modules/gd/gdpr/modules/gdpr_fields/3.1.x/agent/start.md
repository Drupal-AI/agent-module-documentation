<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# GDPR Fields — agent index

Mark entity fields as personal data with Right-to-Access (RTA) and Right-to-be-Forgotten
(RTF) settings and an anonymizer, stored per entity type in a config entity. Requires
`gdpr` + `anonymizer`. No settings form of its own (`configure: null`); fields are configured
on their normal field-edit page. Report at `/admin/reports/fields/gdpr-fields`.

- **The `gdpr_fields_config` config entity, the per-field keys (rta/rtf/anonymizer/…), and
  where field settings live** → [configure/gdpr-field-settings.md](configure/gdpr-field-settings.md)
- **The collector/traversal API used by GDPR Tasks** → [api/collector.md](api/collector.md)

Key facts:
- Config entity `gdpr_fields_config` (id = entity type; config name
  `gdpr_fields.gdpr_fields_config.<entity_type>`) → `bundles[<bundle>][<field>]` =
  `{enabled, rta, rtf, anonymizer, notes, relationship, sars_filename, entity_type_id}`.
- `rta` ∈ `inc|maybe|no`; `rtf` ∈ `anonymize|remove|maybe|no`; `anonymizer` = an anonymizer
  plugin id; `relationship` 0=disabled,1=follow,2=owner.
- Also mirrored to `field.field.*.third_party.gdpr_fields` (`gdpr_fields_rta`/`gdpr_fields_rtf`).
- Permissions: `view gdpr fields`, `edit gdpr fields`. Report route `gdpr_fields.fields_list`.
- Service `gdpr_fields.collector` (`GDPRCollector`) + `EntityTraversal` walk the entity graph.
