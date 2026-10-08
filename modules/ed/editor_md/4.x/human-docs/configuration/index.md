# Configuration

Editor.md is configured **per text format** — you pick it as a format's editor and
then tune how it looks and behaves. Just as important, you configure the format's
**filters** so the Markdown authors type is safely converted to HTML on output.

## Assign Editor.md to a text format

1. Log in as a user with the **Administer filters** permission (an administrator
   by default).
2. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`).
3. Configure an existing format, or add a new one (a dedicated "Markdown" format
   is a common choice).
4. Set the **Text editor** dropdown to **Editor.md**.

## Configure the filters (do not skip this)

Because Editor.md stores raw Markdown and is **not** XSS-safe, the format's
filters are what make the output both correct and safe:

- Enable the **Markdown** filter (from the `markdown` module) so stored Markdown
  is converted to HTML when the content is displayed.
- Enable **Limit allowed HTML tags** to bound what the converted HTML may contain.

Never grant a format that uses Editor.md to untrusted roles without these
filters in place — the module relies entirely on the format's filter pipeline for
output sanitisation.

## Editor.md settings

With Editor.md selected as the editor, its settings appear in vertical tabs:

### General

- **Mode** — choose **GFM** (GitHub-Flavored Markdown) or plain **Markdown**.
- **Width** and **Height** — the editor's dimensions.
- **Watch / live preview** — toggle the side-by-side live preview that re-renders
  as you type.

### Themes

- **Container theme** — the overall editor chrome, light or dark.
- **Editor theme** — the CodeMirror editing-pane theme (syntax colours).
- **Preview theme** — the theme applied to the rendered preview pane.

### Toolbar

- **Toolbar enabled** — show or hide the button toolbar.
- **Auto-fixed toolbar** — keep the toolbar pinned in place while scrolling.
- **Toolbar mode** — **full**, **simple**, **mini**, or **custom**. For
  **custom**, enter a comma-separated list of Editor.md icon names (use a pipe
  `|` to insert separators between groups). Custom toolbar input is passed through
  `Xss::filterAdmin()` before being stored.

## Save

Click **Save configuration**. Edit any field that uses this format to confirm the
Markdown editor renders with the toolbar, themes, and preview you chose.
