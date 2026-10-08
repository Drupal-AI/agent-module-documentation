<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Dropcap Ckeditor adds a CKEditor toolbar button and modal dialog that lets authors insert a drop-cap — a large decorative initial letter or phrase with a chosen font size and colour — into rich-text fields.
---
The module registers a CKEditor (CKEditor 4) plugin (`Drupal\dropcap_ckeditor\Plugin\CKEditorPlugin\Dropcap`) that adds a `Dropcap` button backed by a JS plugin (`js/plugins/dropcap/plugin.js`) and depends on `core/drupal.ajax`. Clicking the button opens a Drupal dialog served by the route `dropcap_ckeditor.dropcap_dialog` at `/plugin/dialog/dropcap/{filter_format}`; that route is access-controlled by `_entity_access: 'filter_format.use'`, so only users permitted to use the given text format can open it. The `EditorDropcapDialog` form collects the text, font size (px) and font colour, and returns the markup via an `EditorDialogSave` Ajax command. When the format is `basic_html` the dialog shows a notice that full HTML is required (the dropcap markup needs tags Basic HTML strips).

Set-up is entirely through the text-format UI: enable the module, then on Administration → Configuration → Content authoring → Text formats and editors drag the Dropcap button into the active toolbar of a Full-HTML-style format. There are no mutating or anonymous endpoints; the only route is the format-gated editor dialog.
---
- Insert a styled drop-cap at the start of an article.
- Choose the drop-cap font size in pixels.
- Set the drop-cap font colour with a hex value.
- Add the Dropcap button to a text format's toolbar.
- Restrict the feature to formats a user may use (entity access).
- Provide decorative typography without hand-writing HTML.
- Use with Full HTML where the needed tags are allowed.
- See a helper notice when Basic HTML is selected.
- Enable per text format via Manage text formats.
- Insert emphasised lead-in phrases, not just single letters.
- Keep editor markup inline via the Ajax dialog save.
- Combine with other CKEditor buttons in the toolbar.
- Validate that the button is only usable with permitted formats.
- Remove the button from the toolbar to disable it for a format.
- Apply consistent drop-cap styling across articles.
- Author decorative initials without leaving the WYSIWYG editor.