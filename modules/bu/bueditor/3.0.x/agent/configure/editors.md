# BUEditor — configuration

## Routes / admin UI (base `/admin/config/content/bueditor`)

| Route | Path | Handler | Access |
|---|---|---|---|
| `bueditor.admin` | (list) | `BUEditorController::adminOverview` | `administer bueditor` |
| `bueditor.editor_add` | `/add-editor` | `bueditor_editor.add` form | create access `bueditor_editor` |
| `entity.bueditor_editor.edit_form` | `/{bueditor_editor}` | edit form | `bueditor_editor.update` |
| `entity.bueditor_editor.delete_form` | `/{bueditor_editor}/delete` | delete form | `bueditor_editor.delete` |
| `entity.bueditor_editor.duplicate_form` | `/{bueditor_editor}/duplicate` | duplicate | create access |
| `bueditor.buttons` | `/buttons` | `BUEditorController::buttonsOverview` | `administer bueditor` |
| `bueditor.button_add` | `/buttons/add-button` | `bueditor_button.add` form | create access `bueditor_button` |
| `entity.bueditor_button.*` | `/buttons/{bueditor_button}[/delete|/duplicate]` | button forms | entity access |
| `bueditor.settings` | `/settings` | `BUEditorSettingsForm` | `administer bueditor` |
| `drupal.xpreview` | `/xpreview` | `XPreviewController::response` | `access ajax preview` (see permissions/) |

`configure` route = `bueditor.admin`. Menu under *Configuration → Content authoring*.

## `bueditor_editor` config entity (config prefix `editor` → `bueditor.editor.*`)

- Admin permission `administer bueditor`. `config_export`: `id`, `label`, `description`, `settings`.
- `settings` is a keyed sequence (schema `bueditor.editor_settings.*`):
  - `toolbar` — sequence of toolbar item ids (button ids / plugin button ids).
  - `cname` — editor CSS class.
  - `indent` — bool, enable indentation.
  - `acTags` — bool, autocomplete HTML tags.
  - `fileBrowser` — string, file browser id.
- Helper on the entity: `hasToolbarItem($id)`.

## `bueditor_button` config entity (config prefix `button` → `bueditor.button.*`)

- `config_export`: `id`, `label`, `tooltip`, `text`, `cname`, `shortcut`, `code`, `template`, `libraries`.
- `preSave()` prefixes non-`custom_` ids with `custom_`.
- `jsProperties()` exposes id/label/tooltip/text/cname/shortcut/code/template to the editor JS.
- `code` = string inserted into the textarea; `template` = HTML injected into the editor UI;
  `libraries` = required asset libraries. (Only `administer bueditor` — a restricted permission — can create/edit these.)

## Associating an editor with a text format

BUEditor integrates through core Editor (`Plugin\Editor\BUEditor`). Go to *Configuration → Content
authoring → Text formats and editors*, edit a format, and choose **BUEditor** as the text editor,
then pick which `bueditor_editor` instance / default editor + per-role editors
(schema `editor.settings.bueditor`: `default_editor`, `roles_editors`).

## `bueditor.settings` (schema `bueditor.settings`, install default)

| Key | Default | Effect |
|---|---|---|
| `devmode` | `false` | When true, `hook_library_info_alter` replaces the `BUE` library with `BUE.dev` (un-minified) for debugging. |

Drush: `ddev drush config:get bueditor.settings`.
