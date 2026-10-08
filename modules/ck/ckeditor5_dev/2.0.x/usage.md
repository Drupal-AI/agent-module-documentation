<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CKEditor 5 Dev tools switches on the official CKEditor 5 Inspector inside Drupal, adds an admin report listing every registered CKEditor 5 plugin, and ships a copy-and-rename starter template for writing your own plugins. It is a development-only aid — do not leave it enabled in production.

---

Debugging a CKEditor 5 problem without the Inspector is guesswork. The editor's model is not the DOM, and questions like "why did my element get stripped", "what schema does this widget register", "which plugin is swallowing this keystroke" are answerable in seconds with the Inspector and not at all by inspecting the DOM. Enabling the Inspector normally means maintaining a local dev build of the editor; this module makes it a matter of turning a module on. The mechanism is small: a `hook_library_info_alter()` adds the module's library as a dependency of core's `internal.drupal.ckeditor5` library, and a Drupal behavior wraps `Drupal.CKEditor5Instances.set`/`delete` so that `CKEditorInspector.attach()`/`detach()` fires as each editor is created or torn down. The Inspector then appears as a pane at the bottom of any page that has a live CKEditor 5 editor (a node edit form, a text-format-configured field, and so on).

The plugin report at `/admin/reports/ckeditor5-plugins` answers a different question: what CKEditor 5 plugins does this site know about? It calls the CKEditor 5 plugin manager's `getDefinitions()` and prints one row per registered plugin definition — label, plugin id, the HTML elements the plugin declares, and the providing module. Note this is the full site-wide set of registered plugin definitions, not the subset enabled for one particular text format; it is the reference for "which module provides this plugin and what markup does it allow". The report is gated by the `access ckeditor5 plugin report` permission.

`ckeditor5_plugin_starter_template/` is a scaffold you copy into the root of a new module. It carries the webpack build config, a `package.json` (yarn `build`/`watch` scripts, CKEditor 5 as a dev dependency), the `*.ckeditor5.yml` plugin definition and `*.libraries.yml`, and a complete working demo plugin (SimpleBox — glue, editing, and UI files) based on CKEditor's block-widget tutorial with extra Drupal-oriented comments. Plugin sources go in `js/ckeditor5_plugins/{name}/src/index.js`; `yarn build` compiles them to `js/build/{name}.js`.

**This is a development tool.** The Inspector is a debugging overlay and the report exposes the site's editor plugin configuration; the module's own hook_help and README both say it should not be enabled in production. The report permission is admin-gated, but the Inspector itself renders for any user who can reach a page with a CKEditor 5 instance while the module is on — another reason to keep it out of production. It is exactly the kind of leftover development module a production-readiness/dev-modules check exists to catch.

---

- Debug a CKEditor 5 problem with the official Inspector inside Drupal.
- See the editor's model, view, and commands live rather than guessing from the DOM.
- Find out why the editor is stripping an element on save.
- Inspect the schema a custom widget registers.
- Discover which plugin is handling (or swallowing) a given keystroke or command.
- List every CKEditor 5 plugin registered on the site and which module provides it.
- See the HTML elements each registered plugin declares as allowed.
- Diagnose a plugin that is enabled but not showing up in the editor.
- Look up the providing module for an unfamiliar plugin id.
- Compare the plugin/element declarations of two modules that seem to conflict.
- Scaffold a new module that provides a custom CKEditor 5 plugin.
- Learn the CKEditor 5 plugin file layout from a working demo (SimpleBox).
- Get a ready webpack + yarn build pipeline for compiling CKEditor 5 plugin source.
- Understand how a `*.ckeditor5.yml` definition maps to a JS plugin export.
- Verify a plugin's Drupal-side definition (toolbar item, elements, libraries).
- Teach a team the editing/UI/glue split of a CKEditor 5 plugin.
- Confirm an integration works before writing custom plugin code.
- Audit a site for development modules accidentally left enabled.
- Keep CKEditor 5 debugging tooling out of the production build.
- Investigate model-vs-view differences that the DOM cannot reveal.
