# Enable the Bootstrap Tabs button on a text format

There is no configure route or settings form. You enable the widget by adding its **toolbar item**
to a text format's CKEditor 5 configuration, then making sure the format's filters allow the tab
markup.

## The CKEditor 5 plugin

Declared in `ckeditor_bootstrap_tabs.ckeditor5.yml`:

- Provider plugin: `ckeditor5-bootstrap-tabs.BootstrapTabs`
- Toolbar item: **`bootstrapTabs`** (label "Bootstrap Tabs")
- Editing library: `ckeditor_bootstrap_tabs/ckeditor5_tabs`; admin library `admin.bootstrap_tabs`
- Declared `elements` it needs allowed (a subset):
  `<div>`, `<a>`,
  `<div class="bootstrap-tabs tab-content tab-pane active tab-pane-content" role="tabpanel" id data-tab-set-title>`,
  `<ul class="nav nav-tabs" role="tablist">`, `<li class="active" role="presentation">`,
  `<a class="tab-link" href aria-controls data-toggle role="tab">`.

## Via the UI

1. Go to **Administration → Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`) and edit a CKEditor 5 format (e.g. *Full HTML*).
2. In the **Toolbar configuration**, drag the **Bootstrap Tabs** button from *Available* into the
   *Active toolbar*.
3. If the format uses **Limit allowed HTML tags** (filter_html), add the tab elements/attributes
   above so the markup is not stripped. Formats with full HTML need no change.
4. **Save**. Editors of that format now see the Bootstrap Tabs button.

## Where it is stored (config)

The button lives in the editor config entity `editor.editor.<format>`:

```yaml
# editor.editor.full_html
editor: ckeditor5
settings:
  toolbar:
    items:
      - bold
      - italic
      - bootstrapTabs        # <-- the Bootstrap Tabs button
```

Read/verify:
```bash
drush cget editor.editor.full_html settings.toolbar.items
```

Set by script (append the item):
```php
$editor = \Drupal::entityTypeManager()->getStorage('editor')->load('full_html');
$settings = $editor->getSettings();
if (!in_array('bootstrapTabs', $settings['toolbar']['items'], TRUE)) {
  $settings['toolbar']['items'][] = 'bootstrapTabs';
  $editor->setSettings($settings)->save();
}
```

## Editing experience & output

The button is a split button/dialog: choose the number of tabs to insert; a context menu adds a tab
before/after, removes a tab, or renames a tab title. Multiple tab widgets per field are supported.
Output is Bootstrap tab markup (`ul.nav.nav-tabs` triggers + `div.tab-content > div.tab-pane` panels).

## Front-end

`hook_page_attachments()` loads `ckeditor_bootstrap_tabs/tabs` (`js/tabs.js` + `css/tabs.css`) on
pages so the tabs switch for visitors. The module does **not** ship the Bootstrap CSS framework —
your theme is expected to provide Bootstrap's tab styling.
