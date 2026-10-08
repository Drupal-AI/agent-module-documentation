FakeObjects registers the CKEditor 4 "fakeobjects" plugin with Drupal so that other user-facing CKEditor plugins that depend on it can work. It is a utility/support plugin with no toolbar button and no configuration of its own.

---

FakeObjects is a thin integration module that exposes the third-party CKEditor 4 "fakeobjects" library to Drupal's CKEditor (CKEditor 4) module. It declares a single `@CKEditorPlugin` plugin whose `getFile()` points at `libraries/fakeobjects/plugin.js`, so once the JavaScript library is present and the module is enabled, the plugin is loaded into text formats that use CKEditor 4. The plugin itself has no toolbar buttons (`getButtons()` returns an empty array) and contributes no editor configuration (`getConfig()` returns an empty array) — it exists purely to satisfy other CKEditor plugins (such as image and link dialog plugins) that rely on the "fakeobjects" helper internally. The JavaScript is not bundled with the module; you must download the plugin (version 4.5.11 or newer) from ckeditor.com and place it in `/libraries/fakeobjects`. The module's `hook_requirements()` implementation checks for `libraries/fakeobjects/plugin.js` on install and at runtime, reporting an error on the status report if the file is missing. On Drupal 10 (and 11) CKEditor 4 has moved out of core, so you also need the contributed `drupal/ckeditor` module for this plugin to have an editor to attach to. It has no admin UI, permissions, config schema, or Drush commands — enabling it and installing the library is the whole setup.

---

- Provide the CKEditor 4 "fakeobjects" utility plugin as a dependency of other CKEditor plugins.
- Satisfy a "plugin not detected" or missing-dependency error thrown by another CKEditor 4 add-on that needs fakeobjects.
- Load `libraries/fakeobjects/plugin.js` into CKEditor 4 text formats automatically once enabled.
- Register the plugin with Drupal's CKEditor plugin system without writing custom code.
- Support image or link dialog CKEditor plugins that internally use fake-object placeholders.
- Verify the fakeobjects JavaScript library is installed via the status report requirements check.
- Get an install-time error if `libraries/fakeobjects/plugin.js` is absent, so misconfiguration is caught early.
- Keep a CKEditor 4 editor working after adding a plugin that lists fakeobjects as a requirement.
- Pin the fakeobjects JS library to `^4.5.11` through the module's Composer requirement.
- Add the plugin to a site still on CKEditor 4 during a phased CKEditor 5 migration.
- Enable the plugin on Drupal 8, 9, 10, or 11 (per `core_version_requirement`).
- Pair with the contributed `drupal/ckeditor` module on Drupal 10/11 where CKEditor 4 is no longer in core.
- Avoid manually editing text-format settings to reference the plugin file.
- Provide a headless helper plugin that renders no toolbar button to editors.
- Contribute no extra editor configuration, keeping CKEditor config minimal.
- Serve as a build-time Composer dependency that also pulls the JS library group package.
- Standardize where the fakeobjects library lives (`/libraries/fakeobjects`) across environments.
- Document, via README, the exact download and placement steps for the CKEditor add-on.
- Act as a shared prerequisite so multiple CKEditor plugins don't each ship their own copy.
- Remove the module cleanly when migrating fully to CKEditor 5, since it targets CKEditor 4 only.
