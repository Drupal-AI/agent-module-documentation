<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Managing augmentors — admin UI, config, routes, permissions

## Install & enable

```bash
composer require drupal/augmentor      # pulls drupal/key
drush en augmentor -y
```

Then enable a provider submodule/companion (e.g. `augmentor_demo` to try it) and create Key
entities for any real API credentials. `augmentor_update_8401()` auto-enables `augmentor_ckeditor4`
if core's legacy `ckeditor` module is present.

## Where it lives

Admin list at **`/admin/config/augmentors`** (menu link `augmentor.list` under
*Configuration → Web services*; `info.yml` `configure: augmentor.list`).

## Routes & permissions (`augmentor.routing.yml`, `augmentor.permissions.yml`)

| Route | Path | Handler | Permission |
|---|---|---|---|
| `augmentor.list` | `/admin/config/augmentors` | `AugmentorListForm` | `administer augmentor` |
| `augmentor.augmentor_add_form` | `/admin/config/augmentors/add/{augmentor}` | `AugmentorAddForm` | `add augmentor+administer augmentor` |
| `augmentor.augmentor_edit_form` | `/admin/config/augmentors/{augmentor}` | `AugmentorEditForm` | `edit augmentor+administer augmentor` |
| `augmentor.augmentor_delete_form` | `/admin/config/augmentors/{augmentor}/delete` | `AugmentorDeleteForm` | `delete augmentor+administer augmentor` |
| `augmentor.augmentor_execute` | `/augmentor/execute/augmentor` | `AugmentorController::execute` | `execute augmentor` |

Permissions: `administer augmentor`, `add augmentor`, `edit any augmentor`, `delete any augmentor`
(all `restrict access: true`), and `execute augmentor` (**not** restricted — the editor-level
permission that lets the execute endpoint/field buttons run). The `+` in a requirement means "any
of" (OR).

Note: the add/edit/delete route requirements name `add augmentor` / `edit augmentor` /
`delete augmentor`; the defined permission ids are `add augmentor`, `edit any augmentor`,
`delete any augmentor` — so in practice `administer augmentor` is the reliable gate for those forms.

## The config object

Everything is stored in **`augmentor.settings`** (install default: `augmentors: {}`), under the
`augmentors` sequence keyed by **UUID**:

```yaml
augmentors:
  3f8c…-uuid:
    label: 'Summariser'
    weight: 0
    debug: false
    type: openai_chatgpt        # plugin id
    configuration:              # AugmentorBase::getConfiguration() shape
      label: 'Summariser'
      uuid: 3f8c…-uuid
      id: openai_chatgpt
      weight: 0
      key: openai_api_key       # a Key entity id, not the secret
      debug: false
      settings: { … provider settings … }
```

Schema `config/schema/augmentor.schema.yml` types `augmentors` as a sequence of
`{name,label,weight}` (loose — the full per-augmentor `configuration` sub-tree is not exhaustively
typed) and also defines `action.configuration.entity:augmentor_action:*` for the Action config
(`source_fields`, `targets[]{target_field,key}`, `augmentor`, `action`, `text_format`,
`explode_separator`).

## Form flow (`src/Form/`)

- **`AugmentorListForm`** (`ConfigFormBase`) — draggable table of saved augmentors (label, type,
  weight, edit/delete ops) + a "select a type → Add" row that redirects to the add form
  (`augmentorSave()` passes the chosen weight in the query). Saving persists the reordered weights.
- **`AugmentorFormBase`** (`AugmentorAddForm`/`AugmentorEditForm`) — renders the plugin's
  `buildConfigurationForm()` as a subform, generates a UUID for new instances, and writes
  `augmentor.settings:augmentors.<uuid>`.
- **`AugmentorEditForm`** adds a **Preview** fieldset: type test input, AJAX-run the saved augmentor
  (`AugmentorEditForm::previewAugmentor` → `executeAugmentor()`), and show the JSON output. You must
  **save before preview** (it runs the persisted config, not the unsaved form values). Output is
  rendered through core's `html_tag` element (admin-filtered).
- **`AugmentorDeleteForm`** (`ConfirmFormBase`) — unsets the UUID entry and re-saves.

## hook_help

`Hook\AugmentorHooks::help()` returns a short blurb on `help.page.augmentor` (wired via
`augmentor.module`'s `#[LegacyHook]` shim).
