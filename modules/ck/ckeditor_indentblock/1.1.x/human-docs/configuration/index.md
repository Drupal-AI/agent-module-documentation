# Configuration

CKEditor IndentBlock has **no global settings page**. You turn paragraph
indentation on for each text format individually, at **Configuration → Content
authoring → Text formats and editors** (`/admin/config/content/formats`).
Everything is stored on that format's `editor.editor.<format>` config.

## Three things must all be true

For paragraph indentation to work in a format, all three of these must be in
place:

1. **The Indent and Outdent buttons are in the toolbar.** IndentBlock ships no
   button of its own — it relies on core's Indent/Outdent buttons. Drag both into
   the format's active toolbar. Without them the plugin never loads.
2. **The "Indent block" tab is enabled.** The **Enable indentation on
   paragraphs** checkbox (on by default) must stay ticked. When you untick it,
   the plugin removes its indent classes and suppresses paragraph indentation —
   though list indentation still works.
3. **`<p class="Indent*">` markup is allowed.** The plugin declares this
   paragraph-class markup when enabled, but if your format uses restrictive
   filters you need to make sure the `<p>` class survives (for example via Source
   Editing's allowed tags). Otherwise Indent/Outdent stay greyed out on
   paragraphs.

## Step by step (UI)

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`) and edit a CKEditor 5 format, for example
   **Full HTML**.
2. In the toolbar configuration, drag **Indent** and **Outdent** from *Available
   buttons* into the active toolbar.
3. Scroll to the editor plugin settings and open the **Indent block** vertical
   tab. Confirm **Enable indentation on paragraphs** is ticked.
4. If the format has strict filtering, ensure `<p class="Indent*">` is allowed
   (via Source Editing's allowed tags).
5. Save the format.

The bundled CSS renders the `Indent1`…`Indent10` classes on both the editor and
the front end (it's attached to every page), so indented paragraphs look the same
when editing and when published.

## Configuring in code (Drush)

Read the current state of a format:

```bash
drush config:get editor.editor.full_html settings.toolbar.items
drush config:get editor.editor.full_html settings.plugins.ckeditor_indentblock_indent
```

Enable it programmatically — append the buttons and set the flag:

```bash
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("editor.editor.full_html");
  $items = $c->get("settings.toolbar.items");
  if (!in_array("indent", $items, TRUE))  { $items[] = "indent"; }
  if (!in_array("outdent", $items, TRUE)) { $items[] = "outdent"; }
  $c->set("settings.toolbar.items", $items);
  $c->set("settings.plugins.ckeditor_indentblock_indent.enable", TRUE);
  $c->save();
'
drush cr
```

The single stored setting is `enable` (a boolean) under
`settings.plugins.ckeditor_indentblock_indent`.
