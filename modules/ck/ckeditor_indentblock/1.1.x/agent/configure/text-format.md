# Configure block indentation per text format

There is **no global settings page** (`configure` route is `null`). You enable block
indentation for each text format at `/admin/config/content/formats/manage/<format>`.
Everything persists on the `editor.editor.<format>` config entity.

## Three things must all be true

1. **Indent / Outdent buttons in the toolbar.** IndentBlock ships no button; it depends on
   core's `ckeditor5_indent` plugin, whose toolbar items are `indent` and `outdent`. Drag
   both into the active toolbar (or add them to `settings.toolbar.items`). Without them the
   IndentBlock plugin's condition is unmet and it never loads.
2. **The "Indent block" vertical tab is Enabled.** A checkbox *Enable indentation on
   paragraphs* (default **on**) at `settings.plugins.ckeditor_indentblock_indent.enable`.
   When off, the plugin removes its indent classes and zeroes the offset, so paragraph
   indentation is suppressed (list indentation still works).
3. **`<p class="Indent*">` is allowed.** The plugin declares this element subset when
   enabled; if the format uses restrictive filters, ensure the `<p>` class markup survives
   (e.g. via Source Editing allowed tags) or Indent/Outdent stay greyed out on paragraphs.

## UI

1. Go to `/admin/config/content/formats`, edit a CKEditor 5 format (e.g. Full HTML).
2. Drag **Indent** and **Outdent** from *Available buttons* into the toolbar.
3. Open the **Indent block** vertical tab, confirm *Enable indentation on paragraphs*.
4. Save. The bundled CSS (`ckeditor_indentblock/indentblock`) renders the `Indent*` classes
   on both the editor and the front end (attached to every page via `hook_page_attachments`).

## Drush / config

Read the current state:

```bash
drush config:get editor.editor.full_html settings.toolbar.items
drush config:get editor.editor.full_html settings.plugins.ckeditor_indentblock_indent
```

Enable it programmatically (append the buttons, set the flag):

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

Config schema for the stored settings lives in
`config/schema/ckeditor_indentblock.schema.yml` (`ckeditor5.plugin.ckeditor_indentblock_indent`,
a mapping with one boolean `enable`).
