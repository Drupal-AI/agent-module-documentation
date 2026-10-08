# Entity Legal — programmatic API

## Load documents

```php
use Drupal\entity_legal\Entity\EntityLegalDocument;
$doc = EntityLegalDocument::load('privacy_policy');
$all = EntityLegalDocument::loadMultiple();
```

## `EntityLegalDocumentInterface` (the document)

- `getPublishedVersion(): ?EntityLegalDocumentVersionInterface` — the single published version, translated
  to the current language when available (null if none).
- `getAllVersions(): array` — every version entity for the document.
- `setPublishedVersion($version): bool` — publish a version (unpublishes the current one; returns false if
  the version isn't of this bundle).
- `userMustAgree(bool $newUser = FALSE, ?AccountInterface $account = NULL): bool` — whether the user must
  accept (new users: `require_signup`; existing: `require_existing` **and** `legal re-accept <id>` perm).
- `userHasAgreed(?AccountInterface $account = NULL): bool` — an acceptance exists for the published version.
- `getAcceptances(?AccountInterface $account = NULL, bool $published = TRUE): array` — acceptance entities.
- `getAcceptanceForm(): array` — the render array for the acceptance checkbox form.
- `getAcceptanceLabel(): string` — the published version's acceptance label, token-replaced then
  `Xss::filter()`ed.
- `getAcceptanceDeliveryMethod(bool $newUser = FALSE): ?string` — the selected method plugin id.
- `getPermissionView(): string` → `"legal view <id>"`; `getPermissionExistingUser(): string` →
  `"legal re-accept <id>"`.

## Versions (`EntityLegalDocumentVersionInterface`)

Content entity `entity_legal_document_version`; fields `label`, `acceptance_label`, `published`,
`document_name` (bundle ref), body `entity_legal_document_text`, created/changed. `publish()` / `unpublish()`
set the published flag; `getAcceptances($account)` lists acceptances of that version.

## Acceptances (`entity_legal_document_acceptance`)

Content entity; fields `vid` (version ref, required), `uid` (defaults to the **current user**), 
`acceptance_date` (created), `data`. Record acceptance by creating one for the published version:

```php
\Drupal::entityTypeManager()->getStorage('entity_legal_document_acceptance')
  ->create(['vid' => $doc->getPublishedVersion()->id()])   // uid auto = current user
  ->save();
```

`EntityLegalDocumentAcceptanceInterface::getDocumentVersion()` returns the referenced version;
`label()` reads "Accepted on <date>".

## Services / constants

- Plugin manager: `plugin.manager.entity_legal` — `createInstance('popup'|'message'|'redirect'|
  'form_link'|'form_inline')->execute($context)`.
- Entity-name constants (defined in `entity_legal.module`): `ENTITY_LEGAL_DOCUMENT_ENTITY_NAME`,
  `ENTITY_LEGAL_DOCUMENT_VERSION_ENTITY_NAME`, `ENTITY_LEGAL_DOCUMENT_ACCEPTANCE_ENTITY_NAME`.
