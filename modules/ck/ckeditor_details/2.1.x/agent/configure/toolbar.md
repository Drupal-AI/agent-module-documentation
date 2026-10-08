<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Add the accordion button to a text format

There is no module settings page. You enable the accordion per **text format** that uses CKEditor 5.

## Via the UI

1. Go to *Configuration → Content authoring → Text formats and editors*
   (`/admin/config/content/formats`).
2. Edit (or add) a format whose text editor is **CKEditor 5**.
3. In the toolbar configuration, drag the **Detail** button (the accordion icon) from *Available
   buttons* into the *Active toolbar*.
4. Ensure the format's **Limit allowed HTML tags** filter (if enabled) permits the elements the
   plugin needs: `<details>`, `<summary>`, and `<div class="details-wrapper">` (plus `<div>`).
5. Save the format.

## Where it is stored

Adding the button updates the **editor** config entity for that format:

```yaml
# editor.editor.<format_id>
settings:
  toolbar:
    items:
      - bold
      - italic
      - detail        # <- the accordion toolbar item
```

The plugin id is `ckeditor_details_detail` and its toolbar item id is **`detail`** (see
`ckeditor_details.ckeditor5.yml`). The corresponding `filter.format.<format_id>` must allow the
declared elements so the inserted markup isn't stripped by `filter_html`.

## Scriptable

```php
$editor = \Drupal::entityTypeManager()->getStorage('editor')->load('full_html'); // a CKEditor5 format
$settings = $editor->getSettings();
$settings['toolbar']['items'][] = 'detail';
$editor->setSettings($settings)->save();
```

Read it back: `drush cget editor.editor.full_html settings.toolbar.items` and look for `detail`.

## What gets inserted

Clicking the button inserts a native HTML5 disclosure widget:

```html
<details>
  <summary>Summary / title</summary>
  <div class="details-wrapper"> … body content … </div>
</details>
```

Browsers render `<details>` as a click-to-expand accordion with no runtime JavaScript.

## CKEditor 4 → 5 upgrade

Formats migrated from CKEditor 4 are handled by the `CKEditor4To5Upgrade` plugin `ckeditor_details`,
which maps the old `detail` button to the new `detail` toolbar item automatically; you don't add it
by hand for upgraded formats.
