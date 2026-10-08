<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Wysiwyg Linebreaks (wysiwyg_linebreaks) — agent index

A CKEditor plugin (CKEditor 5 for core 10/11, with legacy CKEditor 4 support retained) that transforms
content at the **editor boundary, entirely client-side**. When an editor instance opens, it reads the
source textarea's raw value and runs `linebreaks_attach()` — converting newline-separated plain text
into `<p>`/`<br>` HTML so legacy content that has no paragraph tags renders as paragraphs inside
CKEditor. The conversion is chosen per text format by a single radio, **Conversion Method** (`force` or
`convert`), that the module injects into CKEditor's plugin settings on the *Text formats and editors*
page — there is no separate module settings route. In `convert` mode only that open-time step runs and
the content is saved with the editor's HTML tags intact. In `force` mode the plugin additionally
registers an editor-`destroy` handler that runs `linebreaks_detach()`, stripping `<p>`/`<br>` back to
plain newlines and writing the cleaned text into the textarea before submit — so the stored value stays
plain text and you rely on a display filter (e.g. core's "Convert line breaks into HTML") to render it.

All transformation happens in the editing user's own browser: there is no route, controller, service,
hook, or PHP that renders or stores user content, and the markup the editor produces still passes
through the text format's normal filter pipeline on output. The PHP classes only register the plugin
and build the config radio. Entry points: CKEditor 5 plugin `wysiwyg_linebreaks_extension`
(JS `linebreaks.LineBreaks`, class `Plugin\CKEditor5Plugin\LineBreaks`), legacy CKEditor 4 plugin
`@CKEditorPlugin(id="linebreaks")` (`Plugin\CKEditorPlugin\Linebreaks`), and the upgrade-path plugin
`@CKEditor4To5Upgrade(id="linebreaks")` (`Plugin\CKEditor4To5Upgrade\LineBreaks`).

- **Depends on:** `drupal:editor` (info.yml).
- **Core:** `^9.3 || ^10 || ^11`.
- **Package:** User interface.
- **Settings page / configure route:** none — configuration is a radio injected into the core Text
  formats & editors form (`admin/config/content/formats/manage/<format>`); no module route or menu link.
- **Permissions:** none provided (gated by core `administer filters`).
- **Drush:** none. **Hooks:** none. **Services:** none.
- **Plugin types:** none provided (the module supplies CKEditor *plugin instances*, not a plugin type).
- **Config schema:** `ckeditor5.plugin.wysiwyg_linebreaks_extension` (key `method`, enum `force`/`convert`).

## What you'd do → where
- Choose/inspect the conversion method for a text format → [configure/ckeditor.md](configure/ckeditor.md)
- Understand the newline↔HTML transformation and force-mode save behavior → [configure/ckeditor.md](configure/ckeditor.md)

## Key facts (real machine names)
- CKEditor 5 plugin id: `wysiwyg_linebreaks_extension`; JS plugin: `linebreaks.LineBreaks`;
  library: `wysiwyg_linebreaks/ckeditor5` (`js/build/linebreaks.js`); enabled elements: `<p>`, `<br>`.
- CKEditor 5 plugin class: `Drupal\wysiwyg_linebreaks\Plugin\CKEditor5Plugin\LineBreaks`
  (`CKEditor5PluginConfigurableInterface`); default `method` = `force`; `getDynamicPluginConfig()` passes
  `linebreaks.method` to the JS.
- Legacy CKEditor 4 plugin: `Drupal\wysiwyg_linebreaks\Plugin\CKEditorPlugin\Linebreaks` (id `linebreaks`,
  file `js/plugins/linebreaks/linebreaks.js`, config key `linebreaks_method`).
- CKEditor 4→5 upgrade plugin: `Drupal\wysiwyg_linebreaks\Plugin\CKEditor4To5Upgrade\LineBreaks`
  (id `linebreaks`, maps CKE4 `linebreaks` settings to CKE5 `LineBreaks` config).
- Config schema key: `ckeditor5.plugin.wysiwyg_linebreaks_extension` → `method` (enum `force`, `convert`).
- Transformation functions (client-side JS): `linebreaks_attach()` (open: plain text → `<p>`/`<br>`),
  `linebreaks_detach()` (force-mode save: `<p>`/`<br>` → newlines) in `LineBreaksFilter`
  (`js/ckeditor5_plugins/linebreaks/src/linebreaksfilter.js`).
