<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Per-field PDF metadata & the entity-save write path

The module adds no field type/widget/formatter. It attaches **third-party settings** (namespace
`pdf_metadata`) to existing **file fields** and **entity-reference fields**, then writes PDF
metadata when the host entity is saved.

## Enabling it on a field

On a field's *Field settings / edit* form (`field_config_edit_form`), the
`EntityEventSubscriber::alterConfigForm()` handler calls
`MetadataCreationService::addMetaFormFields()`, which is triggered only for fields whose class is a
`FileFieldItemList` or `EntityReferenceFieldItemList`. It adds, under
`third_party_settings[pdf_metadata]`:

- **`enabled`** (checkbox) — turn on direct metadata writing for this file field.
- **`reference_enabled`** (checkbox, shown for media-referencing fields) — let *other* entity
  reference fields drive this field's metadata; mutually exclusive with `enabled`.
- **`meta_types`** (in a details fieldset visible when enabled): text patterns for **title**,
  **author**, **subject**, **keywords** (maxlength 512). Defaults: title & keywords default to the
  entity's title/name token (`[node:title]` for nodes, `[<type>:name:value]` otherwise); author &
  subject default to empty. A **token tree** browser link is rendered for the target entity type.
- **`type`** (hidden) — the token type for the target entity, from
  `TokenEntityMapper::getTokenTypeForEntityType()`.

These are persisted as the field's third-party settings and validated by the config schema
`field.field.*.*.*.third_party.pdf_metadata`.

## Two wiring modes (from README + source)

1. **Direct file field** — enable `pdf_metadata.enabled` on a File field and set token patterns
   built from the host entity. On save, its PDFs are stamped.
2. **Entity-reference driven** — on a node's reference/media field, enable `enabled` with the
   node's tokens; then on the *referenced* entity's file field enable `reference_enabled`. Parent
   tokens now populate the referenced file's PDF metadata. (`reference_enabled` deliberately
   disables `enabled` on the same field to avoid a conflict on save.)

## The write path (on entity insert/update)

`EntityEventSubscriber` subscribes to `EntityHookEvents::ENTITY_INSERT` and `ENTITY_UPDATE`; both
call `MetadataCreationService::appendMetadata($entity)`:

1. `validateFields($entity)` — iterate `$entity->getFields()`, read each field's
   `getThirdPartySettings('pdf_metadata')`, keep those with `enabled = TRUE`, split into
   `file_fields` and `reference_fields`.
2. `validateReferenceFields($reference_fields)` — for each reference, walk
   `referencedEntities()`, and for referenced content entities keep file fields whose settings have
   `reference_enabled = TRUE`.
3. `validateFiles(file_fields + reference file_fields)` — for each referenced file, **skip unless
   `getMimeType() === 'application/pdf'`**, then resolve the `meta_types` patterns with
   `checkReplacementTokens()` → `Token::replacePlain($pattern, [entityType => entity], ['clear' => TRUE])`.
4. `generatePdfWithMetadata($files)` — get `providerManager->getActiveProvider()`, resolve the
   real path with `FileSystem::realpath($file->getFileUri())`, and call
   `$provider->writeMetadata($file_path, $metadata)`; failures are logged to the `pdf_metadata`
   channel (via `getLastError()`), and exceptions are caught per file.

## Operational notes (from README)

- **Not reactive to referenced-entity edits.** Editing only the referenced media does not
  re-stamp; resave the parent, e.g. `drush entity:save node --bundle=article`, to regenerate all
  PDFs for a content type.
- **No de-duplication** when several reference entities point at the same file field — the last
  save wins for that file's metadata.
- Only genuine PDFs are touched (MIME check), so enabling the feature on a mixed file field is
  safe for non-PDF uploads.
- Metadata values come from the token patterns you configure, resolved against the saved entity;
  choose patterns whose tokens resolve to the values you actually want embedded.
