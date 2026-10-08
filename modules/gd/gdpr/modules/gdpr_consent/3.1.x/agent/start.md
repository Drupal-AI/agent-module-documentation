<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# GDPR Consent — agent index

Define versioned **consent agreements** and record users' consent. Requires `gdpr`, `token`,
`message`, `entity_reference_revisions`, `views`. No single settings form (`configure: null`).

- **The `gdpr_consent_agreement` entity, the `gdpr_user_consent` field type/widget/formatter,
  agreements UI** → [configure/agreements.md](configure/agreements.md)
- **The ConsentUserResolver plugin type (map an entity → its user) and built-in resolvers** →
  [plugins/consent-resolver.md](plugins/consent-resolver.md)

Key facts:
- Content entity `gdpr_consent_agreement` (revisionable, translatable) at
  `/admin/config/gdpr/agreements`; required base fields `title`, `mode`
  (`implicit`/`explicit`), `description`.
- Field type `gdpr_user_consent`; widget `gdpr_consent_widget`; formatter
  `gdpr_consent_formatter`.
- Plugin type `gdpr_consent_resolver` (manager `plugin.manager.gdpr_consent_resolver`);
  resolvers `gdpr_consent_user_resolver` (user), `gdpr_consent_node_resolver` (node),
  `gdpr_consent_profile_resolver` (profile).
- Acceptances logged as `message` entities (template `consent_agreement_accepted`,
  view `gdpr_log_messages`). Block `GdprMyAgreementsBlock`; page `/user/{user}/gdpr/agreements`.
- Permissions: `manage gdpr agreements`, `grant gdpr any consent`, `grant gdpr own consent`.
