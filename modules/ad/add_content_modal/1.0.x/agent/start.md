<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Manage content modal — agent orientation

UX layer that makes node add/edit/delete/translate open in a modal or off-canvas dialog for selected content types.

Key file: `add_content_modal.module` — a set of alters (`link_alter`, `menu_links_discovered_alter`, `menu_local_actions_alter`, `menu_local_tasks_alter`, `entity_operation_alter`, `form_alter`) that add `use-ajax` + `data-dialog-*` attributes via `_add_content_modal_helper_modal_options_array()`.
Config: `src/Form/SettingsForm.php` (`add_content_modal.settings`, const SETTINGSNAME). Controllers: `DialogController`/`ModalController` just return Close*DialogCommand.

Security posture: none — no data disclosure or mutation of its own; core forms/routes still enforce entity access. Settings form gated by `manage add_content_modal settings`; close route requires the authenticated role.
