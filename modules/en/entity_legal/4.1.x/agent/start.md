# Entity Legal — agent index

Versioned, acceptance-tracked legal documents (T&C, privacy policy). Admin UI at
`/admin/structure/legal` (route `entity.entity_legal_document.collection`, permission
`administer entity legal`). Depends on `text` and `token`. Provides config schema, dynamic permissions,
an `EntityLegal` plugin type, and `hook_entity_legal_document_method_alter`. No Drush.

Entities: `entity_legal_document` (config entity + bundle) → `entity_legal_document_version` (content,
title + rich-text body, one published) → `entity_legal_document_acceptance` (content, logs uid+vid+date).

- **Documents, versions, settings, and the acceptance flow (create/configure a document)** →
  [configure/documents.md](configure/documents.md)
- **The `EntityLegal` acceptance-method plugin type (message/popup/redirect/form_link/form_inline) + writing one** →
  [plugins/methods.md](plugins/methods.md)
- **Programmatic API: document/version/acceptance methods you'll call** →
  [api/documents.md](api/documents.md)
- **Permissions (static + dynamic per-document)** →
  [permissions/permissions.md](permissions/permissions.md)
- **`hook_entity_legal_document_method_alter()`** →
  [hooks/hooks.md](hooks/hooks.md)

Key facts:
- Acceptance is recorded only for the **current user** against the **published** version
  (`EntityLegalDocumentAcceptanceForm`; acceptance `uid` defaults to `currentUser`). No cross-user forging.
- A document requires acceptance per audience: `require_signup` (new users) / `require_existing` (existing
  users, gated by `legal re-accept <id>`). Users with `administer entity legal` or
  `bypass entity legal acceptance` are exempt.
- Exactly one published version enforced by the `SingleLegalDocumentPublishedVersion` constraint.
- Body is a standard `text_default` (formatted-text) field — output is filtered by its text format;
  `acceptance_label` is `Xss::filter()`ed; the title `title_pattern` runs through the token service.
