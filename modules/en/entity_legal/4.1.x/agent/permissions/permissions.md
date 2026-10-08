# Entity Legal — permissions

## Static (`entity_legal.permissions.yml`)

| Permission | Gates |
|---|---|
| `administer entity legal` | Full admin: manage documents/versions, the `/admin/structure/legal` UI, and the admin route of every document/version. Holders are **exempt** from having to accept any document. Note: not marked `restrict access: true`, but it is the module's config-admin permission. |
| `bypass entity legal acceptance` | Holder is never forced to accept/re-accept any document (support/admin staff). |

Both exemptions are applied in `EntityLegalPluginBase::getDocumentsForMethod()` (returns no documents for
holders) so the delivery methods simply never prompt them.

## Dynamic, per document (`EntityLegalPermissions::permissions()`)

For every `entity_legal_document` two permissions are generated (dependency-tracked to the document):

| Permission | Format | Gates |
|---|---|---|
| View | `legal view <document_id>` | Viewing the document (checked by `EntityLegalDocumentAccessControlHandler` for the `view` op). |
| Re-accept | `legal re-accept <document_id>` | Whether an **existing** user is required to (re-)accept: `userMustAgree()` requires `require_existing` **and** this permission. |

## Access handler

`EntityLegalDocumentAccessControlHandler::checkAccess()`: `administer entity legal` ⇒ allowed for any
operation; otherwise `view` is allowed when the account holds the document's `legal view <id>` permission;
all else falls through to the default entity access. So to expose a document to anonymous users, grant
`legal view <id>` to the anonymous role.
