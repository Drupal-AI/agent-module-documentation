# Configuration

There's no settings page — you turn the checker on by adding its button to a text
format's CKEditor 5 toolbar. That's the whole configuration.

## Add the button to a text format

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`) and click **Configure** on a format that uses
   **CKEditor 5** (for example *Full HTML*).
2. In the **Toolbar configuration**, drag the **Accessibility Checker** button from
   *Available buttons* into the *Active toolbar*.
3. Save.

Editors using that format will now see the **Accessibility Checker** button. Clicking
it runs Sa11y over the content in that field and surfaces any accessibility issues
inline.

Add the button only to the rich-text formats that need it (typically the ones your
content team uses for body copy), and repeat these steps per format.

## Good to know

- The plugin adds **no markup** to your stored content — it's purely an authoring-time
  checker, so you don't need to change any *allowed HTML tags* settings.
- Everything runs **client-side** using the bundled Sa11y engine (with English
  language strings). There's no external service, no CDN call, and no API key to
  configure.
- It checks the content of any CKEditor 5-enabled field — body fields, long-text
  fields, and so on.

## Setting it in code

If you configure editors as code, append the toolbar item to the format's editor config
entity:

```php
// drush php:eval — add the button to Full HTML's CKEditor 5 toolbar.
$editor = \Drupal::entityTypeManager()->getStorage('editor')->load('full_html');
$settings = $editor->getSettings();
$settings['toolbar']['items'][] = 'a11ychecker';
$editor->setSettings($settings)->save();
```
