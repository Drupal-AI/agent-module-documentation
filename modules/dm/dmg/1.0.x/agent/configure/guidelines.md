<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring guidelines

Two distinct kinds of guideline, both edited by admins and rendered with `Xss::filterAdmin()`.

## 1. Per-display-mode guidelines (third-party settings)
Stored on each `entity_view_mode` / `entity_form_mode` config entity as third-party setting
`dmg.guidelines` (rich text). Wired via `dmg.module` form alters:
- `hook_form_(entity_view_mode|entity_form_mode)_(add|edit)_form_alter` →
  `_dmg_entity_display_mode_form_alter()` adds a required `Configuration Guidelines` `text_format`
  field to the mode add/edit form and registers `_dmg_form_guidelines_builder_callback` in
  `#entity_builders`, which saves the value with `$entity->setThirdPartySetting('dmg','guidelines', …)`.
- On the **add** form it also shows any entity-type *creation* guideline (see below) as a
  `messages--warning` block.
- `hook_form_(entity_view_display|entity_form_display)_edit_form_alter` →
  `_dmg_entity_display_form_alter()` renders the stored guideline for that mode as a `messages--warning`
  block at the top of the Manage display form (weight -10).

## 2. Entity-type creation guidelines (`dmg.settings`)
Config object `dmg.settings`, schema `config/schema/dmg.schema.yml`:
```yaml
dmg.settings:
  view:  # sequence
    - { entity_type_id: node, guidelines: "…" }
  form:  # sequence
    - { entity_type_id: node, guidelines: "…" }
```
Default install ships `view: {}` / `form: {}` (empty).

Edited via `SettingsForm` at route `dmg.settings`:
`/admin/structure/display-modes/{type}/manage/{entity_type_id}/guidelines` where `{type}` is `view` or
`form` (`administer site configuration`). The form has an **Entity Type** select (content entity types)
and a required rich-text **Creation Guidelines** field (loaded/updated per `entity_type_id`).
`validateForm()` rejects a `type` other than `view`/`form` and unknown entity types.

Reached from the display-mode collection pages via the "Set creation guidelines" action links
(`dmg.links.action.yml`, `entity_type_id: '_new'`). These creation guidelines then render as a warning
on the matching entity type's "add display mode" form.

## List builder
`EntityDisplayModeListBuilder` (set on `entity_view_mode`/`entity_form_mode` via
`hook_entity_type_alter`) extends core's Field UI list builder to add a **Guidelines** column (shows the
mode's stored guideline or "- No guidelines configured yet -") and swaps the add-link text to
"Update/Set creation guidelines …" depending on whether a creation guideline exists.

## Notes
- No config UI beyond the above; no `configure` key in `dmg.info.yml`.
- All guideline text is rendered through `Xss::filterAdmin()`; input is only reachable by users who can
  administer display modes / site configuration (trusted admins).
