<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Split Preview (split_preview) — agent index

Live split-screen **preview** of node add/edit forms in an iframe with device-width toggles. Version **1.0.1**, core `^8 || ^9 || ^10`. No dependencies.

**Shape:** `hook_form_alter` on node `ContentEntityForm`s → attaches `split_preview/split_preview-library`, relabels/AJAX-wires the *Preview* action (`_submit_ajax_form`), and (for Layout Builder forms) injects a preview button. AJAX callback returns a custom `PreviewContentCommand` (`command: previewContent`) that JS renders into the iframe.

**No** routes/services/permissions/config. Runs inside the existing node-edit form, so access = normal node create/edit permissions; core handles the form token. Presentation-only.
