<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Ace Editor

There is **no settings form and no configure route**. You configure three separate things:
the global defaults (`ace_editor.settings`), per-text-format editor settings
(`editor.editor.<format>`), and the external JS library.

## 1. Install the Ace JavaScript library (required)

Not bundled. `ace_editor_lib_path()` looks for `ace.js` in, in order:
`/libraries/ace`, `/libraries/ace-builds`, `<module>/libraries`, and the profile's
`/libraries/ace`. Until found, `hook_requirements()` reports a runtime **error** and editors
render as plain textareas.

```bash
# from the Drupal docroot
cd libraries && git clone --depth 1 https://github.com/ajaxorg/ace-builds.git ace
# (or download a release zip into /libraries/ace so /libraries/ace/ace.js exists)
```
Theme (`theme-*.js`) and mode (`mode-*.js`) files in that directory are auto-registered as
libraries `ace_editor/theme.<name>` and `ace_editor/mode.<name>` by
`hook_library_info_build()`.

## 2. Global defaults — `ace_editor.settings`

One `config_object`; the module's ships defaults in `config/install/ace_editor.settings.yml`.
Keys used by all three integrations as defaults:

| Key | Default | Meaning |
|---|---|---|
| `theme` | `cobalt` | Ace color theme (must be a key of `theme_list`) |
| `syntax` | `html` | Highlight mode/language (key of `syntax_list`) |
| `height` / `width` | `300px` / `100%` | editor box size |
| `font_size` | `12pt` | |
| `line_numbers` | `true` | gutter line numbers |
| `show_invisibles` | `false` | whitespace/EOL markers |
| `print_margins` | `true` | 80-char margin line |
| `auto_complete` | `true` | Ctrl+Space autocomplete (loads `ext-language_tools.js`) |
| `use_wrap_mode` | `true` | soft word wrap |

`theme_list` and `syntax_list` are option maps (label per machine key) used to build the
select lists. There is no UI, so change a default like this:

```bash
drush config:set ace_editor.settings theme monokai -y
drush config:set ace_editor.settings auto_complete 0 -y
```

## 3. Assign the Ace editor to a text format

The `ace_editor` **editor plugin** (core `editor` module) attaches to a text format. In the UI
this is *Configuration → Content authoring → Text formats and editors* → edit a format → set
**Text editor: Ace Editor**, then the "Ace Editor Settings" fieldset. Programmatically it is an
`editor.editor.<format>` config entity; the meaningful settings sit under a **`fieldset`** key:

```php
use Drupal\filter\Entity\FilterFormat;
use Drupal\editor\Entity\Editor;

// A format must exist first.
FilterFormat::create(['format' => 'snippets', 'name' => 'Snippets'])->save();

Editor::create([
  'format'   => 'snippets',
  'editor'   => 'ace_editor',
  'settings' => ['fieldset' => [
    'theme' => 'twilight', 'syntax' => 'javascript',
    'height' => '300px', 'width' => '100%', 'font_size' => '12pt',
    'line_numbers' => TRUE, 'print_margins' => TRUE,
    'show_invisibles' => FALSE, 'use_wrap_mode' => TRUE, 'auto_complete' => TRUE,
  ]],
])->save();
```

Read it back:
```bash
drush cget editor.editor.snippets settings.fieldset
# editor: ace_editor ; settings.fieldset.theme: twilight ; ...
```
At runtime `AceEditor::getLibraries()` attaches `ace_editor/primary` plus the matching
`ace_editor/theme.<theme>` and `ace_editor/mode.<syntax>` libraries (falling back to the
global-config theme/syntax if that theme/mode file is missing). `getJsSettings()` passes
`settings.fieldset` to the JS. Supported element type: `textarea` only.

## 4. Field formatter `ace_formatter`

For `text_long` and `text_with_summary` fields. Set it on the entity's *Manage display*
(view mode), or in an `entity_view_display` config entity:
`content.<field>.type: ace_formatter`. Its per-display settings mirror the table above
(defaulted from `ace_editor.settings`). It renders a **read-only** Ace textarea.

## 5. Text filter `ace_filter`

Enable on a text format's *filters* (`filter.format.<format>` →
`filters.ace_filter.status: true`). Its `settings.*` default the highlighting for `<ace>` tags;
see [api/filter-and-formatter.md](../api/filter-and-formatter.md).
