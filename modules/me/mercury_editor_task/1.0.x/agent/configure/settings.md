<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Mercury Editor Task

## Settings form
Route `mercury_editor_task.settings` at `/admin/config/content/mercury-editor/task`
(`Drupal\mercury_editor_task\Form\MercuryEditorTaskSettingsForm`), gated by
`administer site configuration`. Use it to control how the Mercury Editor task
integrates with node forms and inline entity forms.

## The per-node route
`entity.node.mercury_editor_task` maps `/node/{node}/mercury-editor` to an
`_entity_form: node.default`, wrapped by
`MercuryEditorTaskHtmlEntityFormController::checkAccess` (extends Mercury Editor's
controller). On this route the controller applies the Mercury Editor rendering and
removes the raw `layout_paragraphs_builder` widget from the node form (it is only
visually hidden when `?schemadotorg_devel_generate` is present so generated data
still submits).

## Services you can build on
- `mercury_editor_task.form_alter` (arg `@config.factory`) — alters node forms.
- `mercury_editor_task.inline_entity_form` — manages nested IEF widgets.
- `mercury_editor_task.form_display_builder` — builds the editing form display.
- content-translation event + route subscribers keep translation routes consistent.
