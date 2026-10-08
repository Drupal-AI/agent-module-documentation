# Configuration

There are two layers to configuring CodeMirror: the **global settings form**
(how the library loads and its default look) and switching on the **individual
integrations** (editor, filter, field widget/formatter) where you want them.

## The global settings form

Go to **Configuration → Content authoring → CodeMirror**
(`/admin/config/content/codemirror`). You need the **Administer codemirror
editor** permission (a restricted permission — grant it only to trusted
administrators). The form has four options:

- **Load from CDN** (`cdn`, on by default) — load the CodeMirror library from a
  content delivery network. Turn it off to use a locally hosted copy under
  `libraries/codemirror` (see [Installation](../installation/index.md) for the
  `drush codemirror:download` command).
- **Use minified library** (`minified`, on by default) — use the smaller,
  minified build. Turn off only if you need the unminified source, e.g. for
  debugging.
- **Theme** (`theme`, default *default*) — the CodeMirror editor theme applied to
  every instance (for example *material*).
- **Language modes** (`language_modes`, default *xml*) — which language modes to
  preload globally. Preload only the ones you actually use (for example CSS,
  JavaScript, Twig) to keep pages light. Twelve modes ship by default: clike, css,
  htmlmixed, javascript, markdown, php, python, ruby, sql, twig, xml, and yaml.

Click **Save configuration**. Saving clears the relevant caches so the new
library settings take effect.

## Switching on the integrations

The global form sets defaults; you still enable CodeMirror where you want it.

### As a text‑format editor

Turn a text format's textarea into a CodeMirror editor:

1. Go to **Configuration → Content authoring → Text formats and editors**.
2. Edit (or add) a text format.
3. Set **Text editor** to **CodeMirror editor**, and choose the language **mode**
   for that format.
4. Save.

### As a filter

To render code inside content with highlighting, edit a text format's **filters**
and enable the **CodeMirror** filter. Its options include line wrapping (off by
default), line numbers (on by default), and code folding (off by default).

### As a field widget (data entry)

Give editors a proper code field:

1. Add a **Plain text (long)** or **Text (long)** field to your content type.
2. On **Manage form display**, set that field's widget to **CodeMirror editor**.
3. Use the widget's gear icon to set its options — the language **mode**, number
   of **rows**, **placeholder** text, and the shared toolbar/line options.

### As a field formatter (display)

To show stored code read‑only with highlighting, go to the content type's **Manage
display** and set the field's format to **CodeMirror editor**. Its options include
the language **mode**, line wrapping, line numbers, and code folding.

## Per‑instance options

Beyond the global theme and preloaded modes, each integration has its own
per‑instance settings (toolbar and toolbar buttons, line wrapping, line numbers,
fold gutter, tag auto‑closing, active‑line styling, the language mode, rows, and
placeholder). These are set on each plugin's own settings form, not on the global
page. Developers using the `#type => 'codemirror'` form element set the same
options via a `#codemirror` array — see the
[`agent/api/usage.md`](../../agent/api/usage.md) reference.
