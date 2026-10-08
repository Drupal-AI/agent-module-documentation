<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Layout Paragraphs builder integration

Sources: `layout_paragraphs_clipboard.module`, `layout_paragraphs_clipboard.routing.yml`,
`src/Controller/CopyClipboardController.php`, `src/Controller/PasteClipboardController.php`,
`src/Controller/PasteClipboardFormController.php`,
`src/EventSubscriber/LayoutParagraphsClipboardAllowedTypesSubscriber.php`,
`src/Form/PasteClipboardComponentForm.php`, `src/PasteClipboardTrait.php`.

## Routes (all require `_layout_paragraphs_builder_access`)

| Route | Path | Controller |
|---|---|---|
| `…builder.copy_clipboard` | `/layout-paragraphs-builder/{layout}/copy_clipboard/{source_uuid}` | `CopyClipboardController::copyClipboard` |
| `…builder.paste_clipboard` | `/layout-paragraphs-builder/{layout}/paste_clipboard` | `PasteClipboardController::pasteClipboard` |
| `…builder.paste_clipboard_form` | `/layout-paragraphs-builder/{layout}/paste_clipboard_form` | `PasteClipboardFormController::pasteClipboardForm` |

`{layout}` is a `layout_paragraphs_layout` resolved from the layout tempstore. Access is delegated to
Layout Paragraphs' own builder access check — the same gate as editing that layout.

## Copy

`hook_preprocess_layout_paragraphs_builder_controls` adds a `Copy to clipboard` AJAX link to each
*saved* component. `CopyClipboardController::copyClipboard` verifies the paragraph exists and is saved,
then stores `['paragraph_uuid' => $source_uuid]` under
`ParagraphsClipboardService::CLIPBOARD_UUID_KEY` and returns an AJAX message (refreshing the layout if
needed).

## Offering paste — the allowed-types event

`LayoutParagraphsClipboardAllowedTypesSubscriber::onAllowedTypes` listens to
`LayoutParagraphsAllowedTypesEvent`. When a clipboard paragraph exists, passes
`ParagraphsClipboardAccess` (update + allowed bundle) and fits the field cardinality, it adds two
chooser entries:
- `paste_clipboard` → immediate paste route.
- `paste_clipboard_form` → paste-with-edit dialog (width 800), and it stashes the placement query
  params (`sibling_uuid`, `parent_uuid`, `region`, `placement`) in tempstore `layout_paragraph_paste`.

## Paste (immediate)

`PasteClipboardController::pasteClipboard` re-checks the clipboard paragraph, cardinality and
`ParagraphsClipboardAccess`, then `createDuplicate()`s the source component and inserts it per the
request query:
- `placement=before|after` relative to `sibling_uuid`, or
- into `parent_uuid` + `region`, or
- appended.
If the copied component **is a layout**, it recurses and duplicates all child components into the
clone. The layout is saved to tempstore and the affected DOM region is updated via AJAX commands
(Before/After/Append/Prepend + `LayoutParagraphsEventCommand`). Errors close the dialog with a message
(`PasteClipboardTrait::displayErrorMessage`).

## Paste (with edit)

`PasteClipboardFormController::pasteClipboardForm` dispatches a
`LayoutParagraphsComponentDefaultsEvent`, loads the paragraph type, and builds
`PasteClipboardComponentForm` (extends Layout Paragraphs' `InsertComponentForm`). That form's
`newParagraph()` returns the clipboard paragraph so the dialog is pre-populated; the submit label is
"Paste". `PasteClipboardTrait` provides `initClipboardServices()`, `getParagraphFromClipboard()` and
`displayErrorMessage()` shared by the controllers.
