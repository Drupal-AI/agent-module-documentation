BUEditor is a lightweight, fully customizable text editor for Drupal that attaches to text areas via the core Editor framework. Instead of a fixed WYSIWYG, you define editors, toolbars, and custom buttons (code snippets, templates, shortcuts) suited to HTML, Markdown, Textile, or any markup.

---

BUEditor depends on core `editor` and integrates as an `@Editor` plugin (`Plugin\Editor\BUEditor`), so a BUEditor instance is selected per text format at *Configuration → Content authoring → Text formats*. It defines two config entities: **BUEditor Editor** (`bueditor_editor`, config prefix `editor`) holds an editor's toolbar item list and settings (class name, indentation, HTML tag autocomplete, file browser), and **BUEditor Button** (`bueditor_button`, config prefix `button`) defines reusable toolbar buttons with a label, tooltip, class, keyboard shortcut, insert `code`, HTML `template`, and required libraries — custom button ids are auto-prefixed `custom_`. Everything is managed at `/admin/config/content/bueditor` (list, add/edit/duplicate/delete editors and buttons, plus a global settings form) behind the `administer bueditor` permission (`restrict access: true`). Toolbar behavior is extensible through a plugin type, `bueditor_plugin` (annotation `@BUEditorPlugin`, manager `BUEditorPluginManager`, namespace `Plugin/BUEditorPlugin`): plugins contribute buttons and can alter the editor JS, the toolbar widget, and the editor form. The bundled `Core` plugin supplies the standard buttons and the `XPreview` plugin adds an Ajax "Preview" button that renders the textarea content through a text format at `/xpreview` — gated by the separate `access ajax preview` permission and, for authenticated users, a CSRF token (added in `hook_js_settings_alter`); the preview only renders formats the requesting user already has access to and returns the result to that same user. A `devmode` setting swaps in the un-minified BUE library via `hook_library_info_alter`.

---

- Provide a lightweight alternative to CKEditor for a text format.
- Build a Markdown or Textile source editor with a custom toolbar.
- Define custom editor buttons that insert code snippets into the textarea.
- Create buttons that insert HTML templates (e.g. a table or callout box).
- Assign keyboard shortcuts to editor buttons.
- Compose multiple editors and assign different ones to different text formats.
- Duplicate an existing editor or button as a starting point for a new one.
- Add an Ajax "Preview" button that renders markup through the active text format.
- Restrict who can use Ajax preview with the `access ajax preview` permission.
- Enable HTML tag autocomplete while typing in the editor.
- Toggle automatic indentation of the source.
- Attach a file browser to the editor for inserting file/image links.
- Give an editor a custom CSS class for theming.
- Group custom buttons into an editor's toolbar in a chosen order.
- Extend BUEditor with a `bueditor_plugin` to add new buttons or alter editor JS.
- Alter the editor settings form from a plugin (`alterEditorForm`).
- Turn on development mode to load the un-minified BUE library for debugging.
- Associate a BUEditor instance with a text format from the format's settings.
- Ship a consistent authoring toolbar across an editorial team.
- Migrate editor/button definitions as exportable config entities.
