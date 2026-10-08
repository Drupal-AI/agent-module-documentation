<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Editor.md plugs the open-source Editor.md JavaScript library into Drupal's text-editor system so authors can write Markdown (with live preview) in any textarea attached to a text format.
---
The module registers an `editor_md` Editor plugin that attaches to `textarea` elements and provides a full/simple/mini/custom toolbar, CodeMirror editor themes, GFM or plain Markdown mode, and live preview. It is purely an **authoring aid**: the plugin declares `is_xss_safe = FALSE`, so the raw Markdown the user types is stored as-is and the actual HTML rendering and sanitization are done by the text format's filter pipeline (the required `markdown` module's Markdown filter plus Drupal's XSS/HTML filters). The module does not itself convert Markdown to HTML on output, so output safety depends on the text format being configured with the Markdown filter and an appropriate HTML restriction — configure the format the same way you would any Markdown format.

Setup: install the Editor.md library into `/libraries/editor.md`, enable this module and the `markdown` dependency, then at *Configuration > Content authoring > Text formats and editors* pick **Editor.md** as the editor for a format and tune its settings (toolbar mode, themes, width/height, watch/preview). Custom toolbar icon lists entered in the settings form are passed through `Xss::filterAdmin()` before being stored.
---
- Offer authors a Markdown editor with live preview
- Enable Editor.md on an existing text format
- Create a dedicated Markdown text format for editors
- Choose GFM or plain Markdown mode
- Pick a full, simple, mini, or custom toolbar
- Define a custom comma-separated toolbar icon list
- Select a CodeMirror editor theme
- Set light or dark container and preview themes
- Configure editor width and height
- Toggle live watch/preview
- Keep the toolbar fixed while scrolling
- Provide a distraction-free fullscreen writing mode
- Insert tables, code blocks, and images via toolbar
- Pair with the markdown module's filter for HTML rendering
- Restrict allowed HTML via the format's filters for safety
- Use for documentation-style content authoring
- Use for issue/comment fields that accept Markdown
- Swap CKEditor for Markdown on selected formats
- Install the Editor.md library under /libraries/editor.md
- Localize the toolbar via the module's translated strings