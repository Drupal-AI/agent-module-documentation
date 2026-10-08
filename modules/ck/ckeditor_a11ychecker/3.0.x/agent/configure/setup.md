# Enable the Accessibility Checker on a text format

There is **no dedicated settings page** (`configure` is null). You enable the checker by adding its
button to a CKEditor 5 toolbar.

## Steps (UI)

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`) and edit a format that uses **CKEditor 5** (e.g. *Full HTML*).
2. In *Toolbar configuration*, drag the **Accessibility Checker** button from *Available buttons*
   into the *Active toolbar*.
3. Save. Editors using that format now see the button; clicking it runs Sa11y over the content.

## How it wires up

`ckeditor_a11ychecker.ckeditor5.yml` defines the plugin:

```yaml
ckeditor_a11ychecker_checker:
  ckeditor5:
    plugins: [ a11ychecker.A11ychecker ]
  drupal:
    label: Accessibility Checker
    library: ckeditor_a11ychecker/a11ychecker        # editor runtime (Sa11y + compiled plugin)
    admin_library: ckeditor_a11ychecker/admin.a11ychecker  # CSS shown on the format config page
    toolbar_items:
      a11ychecker: { label: Accessibility Checker }
    elements: false                                   # adds no markup to stored content
```

- Libraries live in `ckeditor_a11ychecker.libraries.yml`. The runtime library loads the bundled
  Sa11y engine (`sa11y/sa11y.umd.min.js`, `sa11y/sa11y.min.css`, `sa11y/lang/en.umd.js`) plus the
  compiled `js/build/a11ychecker.js`; it depends on `core/ckeditor5`. All assets are local (no CDN).
- `elements: false` means the plugin stores nothing in the markup and needs no text-format *allowed
  HTML tags* changes — it is purely an authoring-time checker.

## Set it in code (config entity)

Add the toolbar item to the editor config entity for a format:

```php
// drush php:eval — append the button to Full HTML's CKEditor 5 toolbar.
$editor = \Drupal::entityTypeManager()->getStorage('editor')->load('full_html');
$settings = $editor->getSettings();
$settings['toolbar']['items'][] = 'a11ychecker';
$editor->setSettings($settings)->save();
```
