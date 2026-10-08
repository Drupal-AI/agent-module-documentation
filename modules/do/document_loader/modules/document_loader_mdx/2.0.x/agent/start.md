<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Document Loader: MDXEditor (document_loader_mdx) — agent index

Adds a **"Load Document"** button to the AI module's MDXEditor toolbar; a modal dialog loads a
document (converted to markdown) into the editor via **Document Loader**. Package `Web services`.
Version 2.0.5. Core `^10.4 || ^11`. GPL-2.0-or-later. Depends on `document_loader`,
`document_loader_media`, `ai`. No permissions of its own, no Drush, no config schema.

- **The dialog form, the media-library widget, the sanitizer, page attachments** →
  [config/dialog.md](config/dialog.md)

## What it provides

- **Route** (`document_loader_mdx.routing.yml`): `document_loader_mdx.dialog` →
  `/document-loader/mdx/dialog`, form `Form\DocumentLoaderMdxForm`, `_permission: 'access content'`.
- **Service** (`document_loader_mdx.services.yml`): `Hook\PageHooks` (autowired) — implements
  `hook_page_attachments()` to attach the button library + dialog URL + icon path on every page.
  Bridged for D10 via `document_loader_mdx.module` (`#[LegacyHook]`).
- **Utility**: `src/Utility/MdxContentSanitizer.php` — `sanitize()` strips HTML tags/comments and
  images from prose and normalizes fenced-code languages to MDXEditor's supported set.
- **Ajax command**: `src/Ajax/FillMdxEditorCommand.php` (`documentLoaderFillMdxEditor`) — JS sets
  the target textarea value and dispatches input/change events.
- **Libraries** (`document_loader_mdx.libraries.yml`): `mdx_editor_button`, `mdx_dialog_form`,
  `mdx_editor_command` (local CSS/JS only, `core/*` deps; no CDN).
- **Install requirement** (`document_loader_mdx.install`): errors at install unless the AI
  module's `ui/mdxeditor/dist/assets/main.js` contains `drupal:mdx-fill` (AI ≥ 1.4).

## Flow

Button (injected where an MDXEditor textarea exists) → opens `document_loader_mdx.dialog` →
`discoverSourceCategories()` filtered to markdown/text loaders → user picks source (media library
for files; schema fields otherwise) → submit runs
`DocumentLoaderManager::loadFromData(..., caller: 'mdx_editor')` → `MdxContentSanitizer::sanitize()`
→ `FillMdxEditorCommand` inserts into the textarea.

## Notes

- Needs a Document Loader **loader** plugin whose loaders support markdown/text; otherwise the
  dialog shows a "no plugins enabled" message.
- File selection goes through the media library (`document_loader_media` opener), avoiding
  `UploadedFile` serialization in the modal.
