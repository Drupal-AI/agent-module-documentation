<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Libraries, runtime option mapping, CKE4 → CKE5 upgrade

## Required external libraries

Both must sit in the docroot `libraries/` directory (paths in
`ckeditor_codemirror.libraries.yml` are absolute, starting with `/libraries/…`):

| Path | Package | Note |
|---|---|---|
| `/libraries/codemirror` | `codemirror` (npm), pinned **5.65.21** | **CodeMirror 6 is not supported** |
| `/libraries/ckeditor5-source-editing-codemirror` | `@cdubz/ckeditor5-source-editing-codemirror`, pinned **35.1.0** | the CKEditor 5 bridge |

`composer.libraries.json` in the module root declares both as `drupal-library` packages; use
it with the [Composer Merge plugin](https://github.com/wikimedia/composer-merge-plugin).

`ckeditor_codemirror_requirements()` (runtime phase only) checks
`libraries/codemirror/lib/codemirror.js` and
`libraries/ckeditor5-source-editing-codemirror/build/source-editing-codemirror.js`, and reads
the version from each package's `package.json`. Missing library ⇒ `REQUIREMENT_ERROR` on
`/admin/reports/status`. The two helper functions in `ckeditor_codemirror.module` are
`_ckeditor_codemirror_get_library_path()` and `_ckeditor_codemirror_get_library_version()`.

Drupal libraries defined: `admin`, `codemirror`, `codemirror.dialog`, `codemirror.fold`,
`codemirror.search`, `source_editing_code_mirror` (the one the plugin attaches).

## Plugin definition (`src/Plugin/CKEditor5Plugin/CodeMirror.php`)

```
id: ckeditor_codemirror_source_editing
ckeditor5.plugins: sourceEditingCodemirror.SourceEditingCodeMirror
drupal.label: CodeMirror source editing
drupal.library: ckeditor_codemirror/source_editing_code_mirror
drupal.admin_library: ckeditor_codemirror/admin
drupal.elements: false
drupal.conditions: { plugins: { ckeditor5_sourceEditing } }
```

It implements `CKEditor5PluginConfigurableInterface`; `defaultConfiguration()` is
`enable: FALSE`, `mode: 'htmlmixed'`, all nine `options` `TRUE`.

## Stored config → CodeMirror runtime options

`getDynamicPluginConfig()` emits `['sourceEditingCodeMirror' => ['options' => …]]`, built
from the stored `options` plus:

- `mode` copied in from the `mode` setting;
- `extraKeys: {'Alt-F': 'findPersistent'}` (always);
- `gutters: []`, plus `CodeMirror-linenumbers` when `lineNumbers` is on and
  `CodeMirror-foldgutter` when `folding` is on;
- `folding` is **renamed**: it is unset and replaced by `foldGutter: true`;
- `searchBottom` is **renamed**: it is unset and replaced by `search: {bottom: true}`.

So the runtime option names differ from the config keys for exactly those two settings.

## CKEditor 4 → 5 upgrade

`src/Plugin/CKEditor4To5Upgrade/CodeMirror.php` (`@CKEditor4To5Upgrade id = "codemirror"`)
maps the old CKE4 `codemirror` plugin settings onto
`ckeditor_codemirror_source_editing`. Only a subset survives: `enable`, `mode`, and the
options `autoCloseBrackets`, `autoCloseTags`, `folding` (from CKE4's `enableCodeFolding`),
`lineNumbers`, `lineWrapping`, `matchBrackets`. Everything else in the CKE4 settings is
dropped, and it maps no toolbar buttons (`mapCkeditor4ToolbarButtonToCkeditor5ToolbarItem()`
throws `\OutOfBoundsException`).
