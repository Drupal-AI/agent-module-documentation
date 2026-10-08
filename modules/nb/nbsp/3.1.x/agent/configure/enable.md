<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — enable NBSP on a text format

NBSP has no settings page. You enable it per **text format** at
`/admin/config/content/formats/manage/<format>`, in three steps:

1. **Toolbar button** — drag **NBSP** (toolbar item id `nbsp`, label "Non-breaking space")
   into the CKEditor 5 *Active toolbar*.
2. **Filter** — enable **"Cleanup NBSP markup"** (filter id `nbsp_cleaner_filter`).
3. **Allowed tags** — if *"Limit allowed HTML tags and correct faulty HTML"* is enabled,
   add `<nbsp>` to the allowed HTML tags. (If that filter is off, nothing to do.)

The ckeditor5 plugin declares the `<nbsp>` element and is only offered when
`nbsp_cleaner_filter` is enabled (`conditions.filter: nbsp_cleaner_filter` in
`nbsp.ckeditor5.yml`).

## Where the config lives

- Toolbar button → `editor.editor.<format>` → `settings.toolbar.items` (add `nbsp`).
- Filter → `filter.format.<format>` → `filters.nbsp_cleaner_filter.status: true`.
- Allowed tag → `filter.format.<format>` → `filters.filter_html.settings.allowed_html`
  (append `<nbsp>`), when `filter_html` is enabled.

## Drush / code recipes

```bash
# Add the NBSP button to a format's CKEditor 5 toolbar:
drush php:eval '
  $e = \Drupal\editor\Entity\Editor::load("full_html");
  $s = $e->getSettings();
  if (!in_array("nbsp", $s["toolbar"]["items"], TRUE)) { $s["toolbar"]["items"][] = "nbsp"; }
  $e->setSettings($s)->save();
'

# Enable the cleanup filter on a format:
drush php:eval '
  $f = \Drupal\filter\Entity\FilterFormat::load("full_html");
  $f->setFilterConfig("nbsp_cleaner_filter", ["status" => TRUE, "weight" => 20]);
  $f->save();
'
```

## What the filter does at runtime

`NbspCleanerFilter::process()` loads the HTML and, via XPath, replaces every `<nbsp>` element
and every `<span class="nbsp">` with a real UTF-8 non-breaking space (`"\xc2\xa0"`). It is a
`TYPE_TRANSFORM_IRREVERSIBLE` filter, so run it appropriately in the filter order.
