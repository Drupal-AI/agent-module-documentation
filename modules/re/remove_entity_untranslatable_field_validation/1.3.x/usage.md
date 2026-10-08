Remove Entity Untranslatable Field Validation strips Drupal core's `EntityUntranslatableFields` validation constraint from every entity type, so untranslatable field values can be changed while editing a non-default translation without triggering a validation error.

---

Drupal core adds an `EntityUntranslatableFields` constraint to translatable content entity types. It enforces that the values of **untranslatable** fields (fields not marked "Users may translate this field") may only be edited on the *original/default* translation, and raises a validation violation if a shared/untranslatable field is changed while editing another language's translation. This module implements a single `hook_entity_type_alter()` that, through the `remove_entity_untranslatable_field_validation.entity_modifier` service (`EntityModifier::removeUntranslatableEntityFieldValidation()`), loops over **all** entity type definitions and unsets that `EntityUntranslatableFields` constraint. The effect is global and unconditional the moment the module is enabled: there is no settings form, no configuration entity, no config schema, no permissions and no Drush commands. Editors (and code paths that call `$entity->validate()`) can then set different values for an untranslatable field per translation without core blocking the save. This is useful on sites whose editorial workflow legitimately needs to touch shared fields from any translation, or that hit the "Non-translatable field elements can only be changed when updating the original language" error and want to lift it site-wide. Because it removes a safety check, it should be used deliberately — untranslatable field values become last-write-wins across translations.

---

- Remove the "Non-translatable field elements can only be changed when updating the original language" validation error site-wide.
- Let editors change an untranslatable field while editing a non-default (e.g. German) translation.
- Allow content-translation forms to save when a shared field was modified from a secondary language.
- Support workflows where translators must adjust a shared reference or flag field regardless of language.
- Unblock migrations/imports that set untranslatable field values on non-default translations.
- Enable programmatic `$entity->validate()` to pass when untranslatable values differ across translations.
- Avoid patching core just to drop the untranslatable-field constraint.
- Fix third-party modules that fail validation because they write shared fields on translation save.
- Permit per-translation editing of fields that were intentionally left untranslatable to save storage.
- Let a moderation/workflow step update a shared status field from any translation.
- Remove the constraint for custom entity types as well as nodes, since it loops every entity type.
- Simplify decoupled editing where the front end submits full field sets on every translation.
- Support paragraph/inline-entity workflows that re-save shared subfields across languages.
- Allow bulk operations (VBO, actions) that modify untranslatable fields on many translations at once.
- Keep a single source of truth field editable from whichever translation an editor happens to be in.
- Unblock content staging/deployment tools that replay untranslatable field changes per language.
- Let a "sync to all translations" pattern work without core rejecting the save.
- Reduce editor confusion caused by fields being silently locked on non-default translations.
- Provide a quick site-wide toggle (enable/disable the module) for the untranslatable-field rule.
- Accommodate legacy data models where "untranslatable" fields are edited per-language by convention.
