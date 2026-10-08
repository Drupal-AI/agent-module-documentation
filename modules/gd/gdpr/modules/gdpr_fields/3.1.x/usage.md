<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
GDPR Fields lets you mark any entity field as personal data and record how it should be handled for a Subject Access Request (Right to Access) and a Right-to-be-Forgotten removal (anonymize or delete), including which anonymizer to use.

---

The module adds a **GDPR field settings** section to every field's edit form and a report at `/admin/reports/fields/gdpr-fields` (route `gdpr_fields.fields_list`, permission `view gdpr fields`) that lists all entity fields with their GDPR configuration. Per-field metadata is stored in a **config entity** `gdpr_fields_config` (one per entity type, id = entity type, config name `gdpr_fields.gdpr_fields_config.<entity_type>`), which holds a nested `bundles[<bundle>][<field>]` map of settings: `enabled`, `rta` (Right to Access: `inc`/`maybe`/`no`), `rtf` (Right to be Forgotten: `anonymize`/`remove`/`maybe`/`no`), `anonymizer` (an [anonymizer](../../anonymizer/3.1.x/agent/start.md) plugin id), `notes`, `relationship` (whether to traverse entity references: 0 disabled / 1 follow / 2 owner-reverse) and `sars_filename`. A simplified copy of the sensitivity flags is also mirrored onto the field's own third-party settings (`field.field.*.third_party.gdpr_fields` with `gdpr_fields_rta` / `gdpr_fields_rtf`). The `gdpr_fields.collector` service (`GDPRCollector`) plus the `EntityTraversal` classes walk an entity graph (following configured relationships) so the GDPR Tasks submodule can build a subject's full data export or perform a removal. It defines two permissions (`view gdpr fields`, `edit gdpr fields`) and ships config schema for both the config entity and the third-party field settings. Requires `gdpr` and `anonymizer`. It has no settings form of its own (`configure: null`); you configure fields on their normal field-edit pages.

---

- Mark a user's email field as personal data included in a Subject Access Request.
- Flag a profile "phone" field to be anonymized (not deleted) on a removal request.
- Choose `email_anonymizer` as the anonymizer for the user mail field.
- Record that a field should be removed (deleted) rather than anonymized under RTF.
- Mark a field as "maybe" personal data for later human review.
- Build a report of every field's GDPR status at /admin/reports/fields/gdpr-fields.
- Configure whether an entity-reference relationship is followed when collecting data.
- Set which fields are included (`inc`) in a data-access export vs excluded (`no`).
- Add notes explaining why a field is or isn't personal data.
- Drive GDPR Tasks' data export from the per-field RTA settings.
- Drive right-to-be-forgotten anonymization/removal from the per-field RTF settings.
- Store GDPR field config as deployable config (`gdpr_fields.gdpr_fields_config.*`).
- Mirror sensitivity flags onto field third-party settings for other modules to read.
- Traverse a user's related entities (nodes, profiles) to find all their data.
- Restrict who can view/edit GDPR field settings via dedicated permissions.
- Define a per-bundle export filename for multi-value SAR assets.
- Mark a computed or reference field as the "owner" side of a relationship.
- Keep a consistent personal-data inventory across content types.
- Configure GDPR handling for taxonomy/media/profile fields, not just users.
- Prepare fields so a removal request anonymizes exactly the right data.
- Audit which fields are enabled for GDPR processing across the site.
- Feed a data-protection impact assessment from the field metadata.
