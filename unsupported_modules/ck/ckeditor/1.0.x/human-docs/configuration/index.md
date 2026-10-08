# Configuration

There are two layers to configure: the module's own **LTS license-key** form, and
the normal **per-text-format editor and toolbar** (which is identical to core
CKEditor 4).

## 1. Enter the LTS license key

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → Content authoring → CKEditor4 - LTS**
   (`/admin/config/ckeditor-lts/settings`).
3. Paste your **License key** — the Extended Support Model key from CKSource. It is
   optional to save the form, but if you enter a key it must be at least 48
   characters (the form validates this). The key is passed to CKEditor as its
   `licenseKey` at runtime, which is what unlocks the LTS security patches.
4. Save. Saving clears the relevant plugin caches.

You can also set the key with Drush:

```bash
drush cset ckeditor.lts.settings license_key '<your key>' -y
```

### Advanced: Clear cache

The form has an **Advanced → Clear cache** button that flushes APCu/WinCache. Use
it when this module replaces a previously installed OSS CKEditor 4 and the new
library or plugins do not load.

## 2. Attach CKEditor to a text format

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`).
2. Edit (or add) a text format.
3. Set **Text editor** to **CKEditor**.
4. The **toolbar builder** appears — drag buttons from the *Available buttons* rows
   into the *Active toolbar* to compose your rows and button groups. A plugin
   becomes active when one of its buttons is placed in the toolbar (or when it
   enables itself contextually).
5. Configure any plugin-specific settings that appear (for example the **Styles**
   dropdown for `stylescombo`, or the **language list** for the language button).
6. Save the format.

The editor configuration — toolbar rows and per-plugin settings — is stored on the
core `editor` config entity, exactly as with core CKEditor 4.

### The bundled Drupal integration plugins

- **drupalimage** / **drupalimagecaption** — the Drupal image button, upload, and
  caption dialog.
- **drupallink** — the Drupal link dialog.
- **drupalmedia** / **drupalmedialibrary** — embed media, including via the Media
  Library button.
- **language** — mark language/direction runs.
- **stylescombo** — a Styles dropdown offering custom block/inline styles.

## 3. Keep a sanitizing filter enabled (security)

The CKEditor editor plugin is declared **not XSS-safe** (`is_xss_safe = FALSE`) —
this is the same as core, and it means Drupal still relies on the text format's
**filters** to sanitize output. Keep a proper HTML-restricting filter (such as
"Limit allowed HTML tags") enabled on any format that uses CKEditor. This is normal
Drupal behaviour, not a flaw in the module.

## Extending (developers)

To add your own CKEditor 4 button or behaviour, implement a `@CKEditorPlugin`; to
tweak another module's plugin or inject iframe CSS, use
`hook_ckeditor_plugin_info_alter` / `hook_ckeditor_css_alter`. See the
[`agent/`](../agent/start.md) docs for the plugin type and hook details.
