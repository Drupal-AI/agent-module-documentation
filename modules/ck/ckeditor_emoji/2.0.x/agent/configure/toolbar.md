<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enable the Emoji button on a text format

The module has **no configure route** (`configure: null`) and no settings of its own. You enable
it by adding the **Emoji** button to a text format's CKEditor 5 toolbar. The choice lives in the
`editor.editor.<format>` config entity.

## Requirements

- Core `ckeditor5` module enabled and the target text format uses **CKEditor 5** as its editor
  (`editor.editor.<format>.editor: ckeditor5`).
- No filter/allowed-tags change is needed: the plugin declares `elements: false`, so it inserts a
  plain Unicode emoji character, not new markup.

## Via the UI

1. Go to *Administration → Configuration → Content authoring → Text formats and editors*
   (`/admin/config/content/formats`).
2. Click **Configure** on a CKEditor 5 format (e.g. *Full HTML*).
3. In **Available buttons**, find the 🙂 **Emoji** button and drag it into **Active toolbar**.
4. **Save configuration**. Editors using that format now see the Emoji button.

## Where the setting is stored

Config entity: `editor.editor.<format>` (e.g. `editor.editor.full_html`). The button appears as
the string `Emoji` in the toolbar items list:

```yaml
format: full_html
editor: ckeditor5
settings:
  toolbar:
    items:
      - bold
      - italic
      - Emoji        # <-- the Emoji button
```

## Read it back

```bash
drush cget editor.editor.full_html settings.toolbar.items
# look for "Emoji" in the list
```

## Scriptable (drush php:eval)

```php
$e = \Drupal::entityTypeManager()->getStorage('editor')->load('full_html');
$settings = $e->getSettings();
if (!in_array('Emoji', $settings['toolbar']['items'], TRUE)) {
  $settings['toolbar']['items'][] = 'Emoji';
  $e->setSettings($settings)->save();
}
```

To remove it, drop `Emoji` from `settings.toolbar.items` and save (or drag it out of the active
toolbar in the UI).

## Plugin identifiers (for reference)

- Drupal CKEditor5 plugin definition id (in `ckeditor_emoji.ckeditor5.yml`): `ckeditor_emoji_Emoji`.
- Underlying CKEditor 5 plugin: `emojiPlugin.Emoji`.
- `toolbar_items` key that names the button: `Emoji`.
