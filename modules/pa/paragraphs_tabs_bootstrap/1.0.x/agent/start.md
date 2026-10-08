<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Paragraphs tabs bootstrap (paragraphs_tabs_bootstrap) — agent index

**Renders a Paragraphs reference field as Bootstrap 5 tabs/pills (horizontal or vertical), with a matching widget and an AJAX add-component modal.**

- **Version:** 1.0.x  •  core: `^9 || ^10 || ^11 || ^12`  •  depends on `paragraphs`.
- **Formatter:** `ParagraphsTabsBootstrapFormatter` • **Widget:** `ParagraphsTabsBootstrapWidget` (paragraph reference fields).
- **Route:** `paragraphs.add` → `/paragraphs-tabs/add/{paragraph_type}/{entity_type}/{entity_field}/{entity_id}` (`ComponentFormController::addForm`, opens `AddComponentForm` in a dialog; submit creates a paragraph and appends it to the host field).
- **Libraries:** `paragraphs-tabs-bootstrap`, `paragraphs-vertical-tabs-bootstrap` (core/jquery, core/once, core/js-cookie). Requires a Bootstrap 5 theme.
- **Security:** the mutating add route uses `_custom_access` (`ParagraphAccessController::accessAdd`) — requires `create paragraph content <bundle>` (paragraphs_type_permissions), or the field's permission (field_permissions), or `update` access on the parent entity. **Not anonymous / properly gated.** No security findings.

See [configure/formatter.md](configure/formatter.md) for settings and the add-component flow.
