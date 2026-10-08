<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor Small Tag — add the button to a text format

There is no admin settings form. You enable the feature by placing the **Small** button in a text
format's CKEditor 5 toolbar.

## Enable via UI

1. Go to *Configuration → Content authoring → Text formats and editors*
   (`/admin/config/content/formats`).
2. Edit a format that uses **CKEditor 5** as its text editor.
3. In *Toolbar configuration*, drag the **Small** button from Available to Active.
4. Save. Gated by the core `administer filters` permission (a restricted, trusted admin permission).

Because the plugin declares `elements: [ <small> ]`, Drupal's CKEditor 5 integration automatically
adds `<small>` to that format's allowed HTML tags (visible under *Enabled filters → Limit allowed
HTML tags*) — no manual filter edit needed. Removing the button removes the tag from the auto-allowed
set.

## Config where it lands

The button id is stored in the format's `editor.editor.<FORMAT>` config under
`settings.toolbar.items` (as `small`):
```
drush cget editor.editor.<FORMAT>
```

## Plugin internals (source under `js/ckeditor5_plugins/smallPlugin/src/`)

- `smallediting.js` — `SmallEditing`: extends the model `$text` schema with a `small` attribute
  (`isFormatting: false`, `copyOnEnter: true`) and converts it to/from the `<small>` view element;
  registers the `small` command.
- `smallcommand.js` — `SmallCommand`: a toggle command (based on CKEditor basic-styles'
  `AttributeCommand`) that sets/removes the `small` attribute on the selection or collapsed cursor.
- `smallui.js` — `SmallUI`: registers the toggleable toolbar `ButtonView` (icon `icons/small.svg`),
  bound to the command's `value`/`isEnabled`, executing `small` on click.
- `small.js` / `index.js` — `Small` plugin requires `SmallEditing` + `SmallUI`; exported as
  `smallPlugin.Small` to match the `.ckeditor5.yml` plugin id.

Rebuild the JS (if editing source) with the module's webpack config (`package.json`); the shipped
`js/build/smallPlugin.js` is the loaded artifact.
