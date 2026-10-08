<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Add the Select All button to a text format

This module has **no admin settings form** (`configure: ''`). The only configuration is placing its
toolbar button into each text format that should have it. Enabling the module alone does nothing
visible — the button must be added per format.

## UI

1. Enable the module: `drush en ckeditor5_select_all -y`.
2. Go to **Admin › Configuration › Content authoring › Text formats and editors**
   (`/admin/config/content/formats`).
3. Click **Configure** on a text format whose editor is **CKEditor 5** (e.g. *Basic HTML* or
   *Full HTML*). Formats using the older CKEditor 4 or no editor will not show CKEditor 5 items.
4. In the **Toolbar configuration** drag-and-drop area, find **Select All** under
   *Available buttons* and drag it into the *Active toolbar*.
5. **Save configuration**. The button is available immediately to anyone who can use that format;
   no cache rebuild is required.

Because the plugin declares `elements: false`, adding it never changes the format's allowed HTML —
there is nothing to add to the *Allowed HTML tags* filter.

## What gets stored

The button is persisted as the toolbar item id **`selectall`** in the format's editor config entity
`editor.editor.{format}`, under `settings.toolbar.items`. Example (Full HTML):

```yaml
# editor.editor.full_html.yml (excerpt)
settings:
  toolbar:
    items:
      - bold
      - italic
      - selectall
```

## Setting it via config / Drush instead of the UI

Add the `selectall` string to the toolbar items array of the target format's editor config, then
import. Read the current value, insert `selectall`, and set it back:

```bash
drush config:get editor.editor.full_html settings.toolbar.items
# add 'selectall' to that list, then:
drush config:set editor.editor.full_html settings.toolbar.items.<index> selectall
drush cr
```

For repeatable deployments, edit the `editor.editor.{format}.yml` in your config sync directory to
include `selectall` in `settings.toolbar.items` and run `drush config:import`.

## Runtime behavior

- The button and the Ctrl/Cmd+A shortcut select all content **inside the focused editor widget**
  only — not the surrounding page.
- The plugin stores no per-format settings; `getDynamicPluginConfig()` returns `[]`.
