<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Field Group Modal Bootstrap adds a Field Group display formatter (id `modal`, label "Modal Bootstrap") that wraps a group of fields in a Bootstrap 5 modal window when an entity is viewed.

---

It plugs into the Field Group module: on an entity type's Manage display, you add a group, choose the "Modal Bootstrap" formatter, and the fields placed in that group are rendered inside a modal triggered from the entity display (supported context: `view`). The formatter (`ModalBootstrap`) builds the modal markup via a custom `ModalElement` render element and a `theme.inc` template, letting you set an element id and extra HTML attributes (parsed from a string). It depends on Bootstrap 5 being present — either from the Bootstrap 5.x theme or added to your site libraries — and attaches core's `drupal.dialog`/`drupal.dialog.ajax` libraries.

The module is display-only: hooks are provided through a `FieldGroupModalBootstrapHooks` service (help, theme, theme-suggestions), and there are no routes, permissions, services beyond that hook object, or stored configuration outside the field group's own settings. Use it to tuck secondary or lengthy field content behind a "view details" style modal without custom theming.
---
- Show a group of fields inside a Bootstrap 5 modal on a node.
- Add a "Modal Bootstrap" field group on Manage display.
- Hide secondary fields behind a modal trigger.
- Present long content (terms, specs) in a popup dialog.
- Give the modal a custom HTML id.
- Add custom HTML attributes to the modal element.
- Reuse Bootstrap 5's modal styling without custom CSS.
- Group related fields into a single "view details" modal.
- Use core drupal.dialog libraries for the modal behavior.
- Override the modal markup via the module's template.
- Apply the modal formatter per view mode.
- Combine multiple field groups, one rendered as a modal.
- Keep entity teasers compact by deferring detail to a modal.
- Display supplementary media or descriptions in a popup.
- Leverage the Bootstrap theme's bundled Bootstrap 5 assets.
- Add site-library Bootstrap 5 if not using the Bootstrap theme.
- Theme the modal trigger and body with Twig suggestions.
- Present per-item detail modals in an entity display.
