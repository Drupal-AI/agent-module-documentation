<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Helper traits and translatable field item lists

These are developer utilities. The traits are meant to be `use`d inside your model (bundle) classes;
the field item list classes are wired automatically by `entity_model_field_info_alter()`.

## `FieldHelpers` — `src/Entity/Traits/FieldHelpers.php`

`protected`/`private` helpers for reading and writing field values. Intended to be used from an entity
class (it calls `$this->get()`, `$this->hasField()`, `$this->set()`, `$this->entityTypeManager()`).

- `getDateTime(string $field_name): ?\DateTimeInterface` — first date-like value, or NULL.
- `getDateTimes(string $field_name): array` — all values as `\DateTime` in the site default timezone;
  handles `TimestampItem` and `DateTimeItem`; throws `\InvalidArgumentException` for other field types.
- `setDateTime(string, \DateTimeInterface)` / `setDateTimes(string, array)` — store `\DateTime` values;
  picks the storage format from field type (`created`/`changed`/`timestamp` → `U`; `datetime` → date or
  datetime storage format per `datetime_type`), converting to the storage timezone first. Throws for
  unsupported field types.
- `getMediaSource(string $field_name): ?FieldItemListInterface` — the source field item list of a
  referenced media entity (via `$media->getSource()->getConfiguration()['source_field']`).
- `formatLink(string): array` / `formatLinks(string): array` — turn a `link` field into structured
  arrays. Private `formatLinkItem(LinkItem)` returns `url`, `text`, `external`, `entity`: it resolves
  `<nolink>`/`<none>` to a fragment or empty string, resolves an `entity:<type>/<id>` uri to the loaded
  (and translated) entity's URL via `getReferencedEntityFromLink()`, else uses `getUrl()->toString()`.

## `EntityTranslatorTrait` — `src/Entity/Traits/EntityTranslatorTrait.php`

- `translateEntity(?EntityInterface, ?string $langcode = NULL, bool $strict = TRUE): ?EntityInterface`
  — returns the entity's translation for `$langcode` (defaults to the current **content** language).
  Returns the entity unchanged if it is not translatable or already in the target language. If the
  translation is missing: NULL when `$strict`, else the original entity.
- `translateEntities(array, ?string, bool): array` — maps `translateEntity()` over an array and
  `array_filter`s out NULLs.

## Translatable field item lists — `src/Field/`

`entity_model_field_info_alter()` swaps the `list_class` of three field types so referenced entities are
returned already translated for the current context:

- `entity_reference` → `TranslatableEntityReferenceFieldItemList`.
- `entity_reference_revisions` → `TranslatableEntityReferenceRevisionsFieldItemList` (only meaningful
  when the `entity_reference_revisions` module is installed — that class extends its field item list).
- `taxonomy_enum` → `TranslatableTaxonomyEnumItemList` (requires the `taxonomy_enum` module).

All three `use TranslatableEntityReferenceFieldItemListTrait`
(`src/Field/TranslatableEntityReferenceFieldItemListTrait.php`):

- `getTranslation(?string $langcode = NULL): ?EntityInterface` — `entity.repository`
  `getTranslationFromContext()` of the single referenced entity.
- `getTranslations(?string $langcode = NULL): array` — context translations of all referenced entities.
- Magic `__get()` exposes `$field->translation` and `$field->translations` as shortcuts to those methods
  (falling back to the parent `__get()` for other properties).

These integrations are optional: `entity_reference_revisions` and `taxonomy_enum` are **not** hard
dependencies — the alter only sets those `list_class` values when those field types are present.
