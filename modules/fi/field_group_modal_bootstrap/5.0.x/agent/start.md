<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field Group Modal Bootstrap (field_group_modal_bootstrap) — agent index

**A Field Group display formatter (`modal`) that renders its grouped fields inside a Bootstrap 5 modal on entity view.**

- **Version:** 5.0.x (5.0.0)
- **Core:** ^10.3 || ^11 || ^12
- **Requires:** field_group; Bootstrap 5 assets (Bootstrap 5.x theme or site libraries)
- **Formatter:** `Drupal\field_group_modal_bootstrap\Plugin\field_group\FieldGroupFormatter\ModalBootstrap` (id `modal`, context `view`)
- **Render element:** `ModalElement`; library attaches `core/drupal.dialog` + `core/drupal.dialog.ajax`
- **Hooks:** via `FieldGroupModalBootstrapHooks` service (help, theme, theme_suggestions_alter)
- **Config:** none beyond the field group's own display settings (id, attributes).

**Security:** Display-only formatter — no routes, permissions, services (besides the hook helper), or stored config; operates within the Field Group display configuration edited by display administrators. No security findings.
