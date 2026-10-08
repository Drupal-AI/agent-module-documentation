<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Component lock — agent index

info.yml name **"Component lock"**; description *"Allows to lock components by locking their settings."*
Version **1.0.0-alpha1** (early alpha, NOT security-advisory covered). Core `^10 || ^11`.
Depends on core `layout_builder` and contrib `form_decorator`.

Scope is narrow: it hides fields on a Layout Builder **block/component configuration form** from
non-administrators. It does **not** prevent a component from being moved, removed, or the layout
otherwise changed — it only locks the component's *settings form fields*. Governs which config an
editor may touch; it complements, not replaces, Layout Builder access.

## What ships
- `src/FormDecorator/BlockComponentFormAlter.php` — a `form_decorator` plugin
  (`#[FormDecorator('hook_form_alter')]`) that `applies()` to form IDs `layout_builder_add_block`
  and `layout_builder_update_block`. This is the whole feature.
- `src/EventSubscriber/SectionComponentVisibility.php` — subscribes to
  `LayoutBuilderEvents::SECTION_COMPONENT_BUILD_RENDER_ARRAY`; when a component has
  `label_interface_translation` set, flags `#configuration['component_lock_translate_label'] = TRUE`.
- `component_lock.module` — `hook_preprocess_block()`: if that flag is set, wraps the block
  `label` in `t()` so it can be translated via the Interface Translation UI.
- No routing, no `*.permissions.yml`, no `config/`, no config schema, no Drush, no templates, no JS.

## Mechanism (BlockComponentFormAlter::buildForm)
- **Admin UI** (only rendered for users with core permission `administer blocks`): adds two
  `details` tabs to the block form —
  - **Lock settings**: `lock_all_settings` (checkbox) and `locked_elements` (checkboxes, one per
    visible child of `$form['settings']`, shown only while `lock_all_settings` is unchecked, via
    `#states`).
  - **Translation settings**: `label_interface_translation` (checkbox).
- **Enforcement** (applied to everyone, gated by permission):
  - If `lock_all_settings` (or legacy `hide_settings`) is set, `$form['settings']['#access']` is set
    to `$currentUser->hasPermission('administer blocks')` — i.e. `FALSE` for non-admins.
  - Each locked element in `locked_elements` (or legacy `hidden_elements`) gets `#access = FALSE`
    for non-admins.
  - `#access = FALSE` is core Form API: the element is neither rendered nor mapped from user input on
    submit, so a locked field cannot be set by a crafted POST.
  - Workaround: if `label_display` ends up `#access = FALSE`, it is converted to `#type => value`
    with the existing config value, to dodge a core bug where `#return_value` checkboxes lose their
    value when access-denied.
- **Persistence** (`submitForm`): reads `lock_settings`/`translation_settings` values and calls
  `$component->set('lock_all_settings', …)`, `set('label_interface_translation', …)`,
  `set('locked_elements', array_keys(array_filter(...)))` on the Layout Builder
  `SectionComponent` (its additional settings, saved with the layout override/default).

## Config keys stored on the component
`lock_all_settings` (bool), `locked_elements` (array of form element keys), `label_interface_translation`
(bool). Read-only legacy fallbacks accepted for back-compat: `hide_settings`, `hidden_elements`.

## Notes for consumers
- The lock/translation UI (the tabs that set or clear these flags) is rendered only for holders of core
  `administer blocks`; that permission is also the admin override — such users always see and edit every
  locked setting.
- No standalone settings page; locking is per placed component inside Layout Builder.
- `configure` route: none.
