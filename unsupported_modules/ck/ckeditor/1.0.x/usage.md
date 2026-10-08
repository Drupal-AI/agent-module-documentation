<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CKEditor 4 - LTS resurrects the CKEditor 4 WYSIWYG editor (removed from Drupal core in favor of CKEditor 5) as a contrib module, bundling the commercially-supported "Long Term Support" build 4.25.1-lts and adding a field for the required LTS license key.

---

The module (composer project `ckeditor_lts`, machine name `ckeditor`) is essentially the old Drupal-core CKEditor 4 module lifted into contrib, so its plugin architecture and config schema match core CKEditor 4 exactly. It registers a `ckeditor` text-editor plugin (`Plugin\Editor\CKEditor`, `@Editor`, `is_xss_safe = FALSE`) for the core Text Editor (`editor`) module, which you attach to a text format at `admin/config/content/formats`; the editor's toolbar, plugins and settings are stored in the `editor` config entity under `editor.settings.ckeditor` (schema in `config/schema/ckeditor.schema.yml`). It defines its own plugin type — `CKEditorPlugin` (manager `plugin.manager.ckeditor.plugin`, discovery dir `Plugin/CKEditorPlugin`, annotation `@CKEditorPlugin`, base class `CKEditorPluginBase`, alter hook `hook_ckeditor_plugin_info_alter`) — and ships the Drupal-integration plugins `drupalimage`, `drupalimagecaption`, `drupallink`, `drupalmedia`, `drupalmedialibrary`, `language`, `stylescombo`, and `internal`. Two dialog routes (`/cke4-lts/dialog/image|link/{editor}`) back the image/link buttons, gated by `_entity_access: editor.use`. The one module-specific addition is a settings form at `/admin/config/ckeditor-lts/settings` (route `ckeditor.lts.settings`, permission `administer site configuration`) that stores an `ckeditor.lts.settings:license_key` (min length 48) which is passed to the editor as CKEditor's `licenseKey`, plus a "Clear cache" button that flushes APCu/WinCache (needed when replacing the OSS CKEditor 4). Important caveat: CKEditor 4 reached end-of-life in June 2023; the LTS build carries post-EOL security fixes but requires a paid Extended Support Model license, so treat this as a migration bridge, not a long-term choice — new sites should use core CKEditor 5.

---

- Keep an existing CKEditor 4 setup working on Drupal 10/11 after CKEditor 4 was removed from core.
- Install the security-patched CKEditor 4 LTS build (4.25.1-lts) with post-EOL fixes.
- Enter and apply a commercial Extended Support Model license key for CKEditor 4.
- Attach the CKEditor 4 WYSIWYG editor to a text format's rich-text fields.
- Buy time to migrate content and custom plugins from CKEditor 4 to CKEditor 5.
- Preserve custom CKEditor 4 plugins that have no CKEditor 5 equivalent yet.
- Build a toolbar with the toolbar-builder UI (drag buttons into rows/groups).
- Use the Drupal image button + upload/caption dialog inside rich text.
- Use the Drupal link dialog to insert links with the editor.
- Embed media via the Media Library button (`drupalmedialibrary`) in CKEditor 4.
- Add a Styles dropdown (`stylescombo`) offering custom block/inline styles.
- Add the language button to mark text direction/language runs.
- Override a Drupal 9 site's bundled OSS CKEditor 4 with the LTS build.
- Implement a custom `@CKEditorPlugin` to add a toolbar button or behavior.
- Alter another module's CKEditor plugin definitions via `hook_ckeditor_plugin_info_alter`.
- Inject custom iframe CSS into the editor via `hook_ckeditor_css_alter` or a theme's `ckeditor_stylesheets`.
- Clear APCu/WinCache from the settings form after swapping in the LTS module.
- Configure per-format toolbars and enabled plugins stored in the `editor` config entity.
- Provide inline (contextual) enabling of plugins that don't expose a toolbar button.
- Keep rich-text authoring consistent across a large legacy editorial workflow during a phased upgrade.
- Satisfy an auditor's requirement that the EOL editor at least receives commercial security patches.
