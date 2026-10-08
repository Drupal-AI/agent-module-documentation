<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Layout Paragraphs Clipboard — agent index

Submodule of `paragraphs_clipboard`. Extends the same clipboard to the **Layout Paragraphs** builder:
adds "Copy to clipboard" controls to components and "Paste from clipboard" (+ "…with edit") entries
to the builder's component chooser. Depends on `paragraphs`, `paragraphs_clipboard`,
`layout_paragraphs`. No settings, permissions, or schema of its own.

- **Routes, controllers, the allowed-types event, and the paste flow** →
  [api/integration.md](api/integration.md)

Parent module: [../../../../1.0.x/agent/start.md](../../../../1.0.x/agent/start.md)

Key facts:
- Copy control added by `hook_preprocess_layout_paragraphs_builder_controls` → route
  `layout_paragraphs_clipboard.builder.copy_clipboard`; `CopyClipboardController` stores the
  component paragraph's **UUID** under `ParagraphsClipboardService::CLIPBOARD_UUID_KEY`.
- `LayoutParagraphsClipboardAllowedTypesSubscriber` injects `paste_clipboard` and
  `paste_clipboard_form` pseudo-types into `LayoutParagraphsAllowedTypesEvent` when a compatible,
  access-allowed paragraph is on the clipboard.
- Paste handled by `PasteClipboardController` (immediate) and `PasteClipboardFormController` +
  `PasteClipboardComponentForm` (edit-before-paste). All three routes require
  `_layout_paragraphs_builder_access`.
- Reuses the parent's `ParagraphsClipboardService` + `ParagraphsClipboardAccess`.
