<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How it works (internals)

No services or public API to call — the module is entirely hook + field-widget driven.
Read this to understand/debug behavior; to change behavior you edit form-display config
(see [../configure/form-display.md](../configure/form-display.md)).

## The widget

`src/Plugin/Field/FieldWidget/RevisionLogWidget.php` — plugin id
`hide_revision_field_log_widget`, `field_types = {string_long}`, extends core
`StringTextareaWidget`. `formElement()` decides visibility in this order:

1. Start from `settings['show']`.
2. If `settings['permission_based']`, override: show only if current user has
   `access revision field`.
3. If `settings['allow_user_settings']` **and** user has
   `administer revision field personalization`, load the user's `revision_log_settings`
   and, if it has an entry for this entity type + bundle, use that value.
4. If the result is "hide", the textarea `#type` is switched to `hidden` and
   `#hide_revision` is set from `settings['hide_revision']`.

## Hooks (`hide_revision_field.module`)

- `hook_entity_base_field_info_alter()` — on every entity type that has a
  `revision_log_message` revision metadata key, makes that field form-display-configurable
  and sets its default widget to `hide_revision_field_log_widget` (weight 80). This is why
  the widget appears automatically on all revisionable bundles.
- `hook_entity_base_field_info()` — adds the `revision_log_settings` (`string_long`) base
  field to the **user** entity for per-user overrides.
- `hook_form_user_form_alter()` — for users with `administer revision field personalization`,
  adds the "Revision Field Settings" section (only listing bundles whose widget has
  `allow_user_settings` on) and serializes the choices into `revision_log_settings` on submit.
- `hook_form_alter()` — when the revision log widget rendered as `hidden` with
  `#hide_revision`, removes the field `#group` and turns the `revision` checkbox into a
  hidden element (fixed to its default), so no empty "Revision information" tab remains.

## Install

`hook_install()` sets the module weight to 1 (so its alters run after other modules). No
config is created on install; per-bundle behavior comes from form-display config as bundles
are saved/updated.
