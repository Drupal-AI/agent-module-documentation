<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Seeds Editor — settings form & custom LTR/RTL CSS

## Install / enable

`drush en seeds_editor -y`. Enabling requires all 17 dependencies (6 core + 11 contrib) to be
available; Composer pulls the contrib set via `composer.json` `require`. On install the text
formats/editors in `config/install` are created (see [text-formats.md](text-formats.md)).

## Route & permission

- Route `seeds_editor.config` (`seeds_editor.routing.yml`) → path `/admin/config/content/seeds-editor`,
  `_form: \Drupal\seeds_editor\Form\SeedsEditorConfigForm`, `_admin_route: TRUE`.
- Requirement: `_permission: 'administer seeds editor'`. That permission
  (`seeds_editor.permissions.yml`) is `restrict access: true` — treat as trusted-admin only.
- Menu link `seeds_editor.settings` (`seeds_editor.links.menu.yml`) under
  `system.admin_config_content`, weight 99.

## Config object `seeds_editor.settings`

Editable via `SeedsEditorConfigForm` (`src/Form/SeedsEditorConfigForm.php`, extends
`ConfigFormBase`; `getFormId()` = `seeds_editor_settings`; `getEditableConfigNames()` =
`['seeds_editor.settings']`). Keys:

| key | type | notes |
|---|---|---|
| `load_ckeditor_styles` | checkbox (bool) | master toggle; when off, no custom CSS is attached |
| `ckeditor_ltr_style` | textfield (maxlength 128) | path to LTR stylesheet; visible only when toggle on |
| `ckeditor_rtl_style` | textfield (maxlength 128) | path to RTL stylesheet; visible only when toggle on |

`submitForm()` saves the three values and shows a status message. `validateForm()` only calls the
parent — no path validation. No config schema file ships (`config/schema` absent), so these keys are
untyped; the form uses `config.typed` in its `create()` but stores plain strings.

## The three hooks (all in `seeds_editor.module`)

All read `seeds_editor.settings` and act only when `load_ckeditor_styles` is truthy.

1. **`seeds_editor_library_info_alter(&$libraries, $extension)`** — runs only for the `seeds_editor`
   extension. Registers dynamic libraries `seeds_editor/ltr_css` and `seeds_editor/rtl_css`, each a
   `css.base` entry pointing at the configured stylesheet path. (There is no static
   `seeds_editor.libraries.yml`; the libraries exist only through this alter.)
2. **`seeds_editor_ckeditor_css_alter(array &$css, EditorInterface $editor)`** — appends the LTR or
   RTL stylesheet to CKEditor's in-editor CSS, chosen by
   `\Drupal::languageManager()->getCurrentLanguage()->getDirection()`.
3. **`seeds_editor_field_widget_complete_form_alter(...)`** — when the widget is a core
   `TextareaWidget`, attaches `seeds_editor/ltr_css` or `seeds_editor/rtl_css` to the widget's
   `#attached['library']`, so plain textareas get the same styling as CKEditor.

Direction selection uses the current interface/content language direction (`ltr` vs anything else →
rtl). This is the mechanism that makes `ckeditor_bidi` RTL content render correctly in the editor.

## Operating notes

- The stylesheet paths are free text entered by a trusted admin; point them at theme/module CSS
  (e.g. `themes/custom/foo/css/editor-ltr.css`). Clearing the master checkbox disables all three
  hooks at once.
- Changing the paths takes effect after a cache rebuild (`drush cr`) because library definitions are
  cached.
