<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enable the Abbreviation button on a text format

There is no settings form for this module. You enable it by adding its **toolbar item** to a
CKEditor 5 text format and allowing the `<abbr>` markup it produces.

## The CKEditor 5 plugin definition

`ckeditor_abbreviation.ckeditor5.yml`:

```yaml
ckeditor_abbreviation_abbreviation:
  ckeditor5:
    plugins:
      - abbreviation.Abbreviation      # the JS plugin
  drupal:
    label: CKEditor Abbreviation
    library: ckeditor_abbreviation/abbreviation
    admin_library: ckeditor_abbreviation/abbreviation.admin
    toolbar_items:
      abbreviation:                    # <-- toolbar item id you add to a toolbar
        label: Abbreviation
    elements:
      - <abbr>
      - <abbr title>
```

- **CKEditor5 plugin id**: `ckeditor_abbreviation_abbreviation`
- **Toolbar item id** (what goes in the toolbar): `abbreviation`
- **Elements produced**: `<abbr>` and `<abbr title>`

## Via the UI

1. *Configuration → Content authoring → Text formats and editors*
   (`/admin/config/content/formats`).
2. Edit a format whose text editor is **CKEditor 5** (e.g. Full HTML).
3. In *Available buttons*, drag the **Abbreviation** button into the *Active toolbar*.
4. If you use the *Limit allowed HTML tags and correct faulty HTML* filter, make sure `<abbr>`
   (and `title` on it, i.e. `<abbr title>`) is in the allowed tags, so tooltips survive filtering.
5. Save.

## Where it is stored (config)

Enabling the button writes the toolbar item into the editor config entity:

```yaml
# editor.editor.<format>
editor: ckeditor5
settings:
  toolbar:
    items:
      - bold
      - abbreviation        # <-- the Abbreviation button
```

The allowed-HTML lives in the format's filter config:

```yaml
# filter.format.<format>
filters:
  filter_html:
    settings:
      allowed_html: '... <abbr title> ...'
```

Read back: `drush cget editor.editor.<format> settings.toolbar.items` and
`drush cget filter.format.<format> filters.filter_html.settings.allowed_html`.

## Scriptable (drush php:eval)

```php
$editor = \Drupal::entityTypeManager()->getStorage('editor')->load('full_html');
$settings = $editor->getSettings();
$settings['toolbar']['items'][] = 'abbreviation';
$editor->setSettings($settings)->save();
```

## Editor usage (runtime)

- Select text → click **Abbreviation** → fill in the abbreviation text and its title/explanation
  in the balloon dialog.
- To edit: put the cursor inside an existing `<abbr>` and click the button, or right-click →
  **Edit Abbreviation**.
- Clear the title to drop the `title` attribute; clear the abbreviation to untag it.
