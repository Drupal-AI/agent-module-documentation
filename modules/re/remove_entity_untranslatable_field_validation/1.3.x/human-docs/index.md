# Remove Entity Untranslatable Field Validation — manual setup guide

**Remove Entity Untranslatable Field Validation**
(`remove_entity_untranslatable_field_validation`) removes one specific Drupal core
safety check: the rule that stops you from editing an *untranslatable* field while
you are working on a translation other than the original language.

By default, when a content type has fields that are **not** marked "Users may
translate this field," core treats those fields as shared across all languages and
only lets you change them on the default (original) translation. Try to change one
while editing, say, the German translation, and core blocks the save with the error
*"Non-translatable field elements can only be changed when updating the original
language."* This module lifts that restriction across the whole site. When enabled,
it loops over every entity type and strips the `EntityUntranslatableFields`
constraint, so editors and code can set different values for a shared field per
translation without core rejecting the save.

The effect is global and immediate the moment you enable it — there is nothing to
configure. There is no settings form, no configuration entity, no permissions, and
no Drush commands. The only "switch" is the module itself: on when enabled, off (and
core's normal enforcement restored) when disabled.

Because it removes a genuine safety check, use it deliberately. With the constraint
gone, an untranslatable field can be written from any translation and effectively
becomes **last-write-wins** across languages — the most recent save wins, regardless
of which language it came from. It is the right tool for sites whose editorial,
migration, or workflow processes legitimately need to touch shared fields from any
translation, but it is not something to enable casually.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Nowhere — the module adds no admin pages, settings form, or menu items. Its entire
behavior is driven by whether it is enabled.

## How to use it

There is no configuration step. Enable the module (see
[Installation](installation/index.md)) and the untranslatable-field validation is
removed site-wide right away. Common reasons to reach for it:

- Get rid of the *"Non-translatable field elements can only be changed when updating
  the original language"* error for editors working in a non-default language.
- Let translators adjust a shared reference, flag, or status field regardless of
  which language they are editing.
- Unblock migrations, imports, or content-staging tools that set untranslatable
  field values on non-default translations.
- Allow programmatic `$entity->validate()` calls to pass when untranslatable values
  differ across translations.
- Apply the change to custom entity types too, not just nodes — it loops over every
  entity type, not a selectable subset.

To confirm it is working, a translatable entity type such as `node` will no longer
list `EntityUntranslatableFields` among its constraints after a cache rebuild, and
saving a changed shared field from a secondary language will succeed. To restore
core's normal enforcement, simply uninstall the module.
