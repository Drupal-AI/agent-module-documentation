<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure: templates and global settings

## The `twig_template` config entity

Config entity type `twig_template` (class `Drupal\twig_ui\Entity\TwigTemplate`,
`config_prefix = template`), so each template is stored as config named
`twig_ui.template.<id>`. Exported keys (`config_export`):

| Key | Meaning |
|---|---|
| `status` | boolean — enabled/disabled. Only **enabled** templates write files and override anything. |
| `id` | machine name (the `<id>` in `twig_ui.template.<id>`). |
| `label` | admin label. |
| `theme_suggestion` | the theme hook / suggestion to override, e.g. `page__front`, `node__article`, `block`. Uses underscores. |
| `template_code` | the raw Twig written to the `.html.twig` file. |
| `themes` | array of theme machine names the template applies to (e.g. `['olivero']`). |

### Create/update via drush php:eval

```php
$t = \Drupal::entityTypeManager()->getStorage('twig_template')->create([
  'id' => 'my_node_article',
  'label' => 'Article override',
  'theme_suggestion' => 'node__article',
  'template_code' => "{# custom #}\n<article>{{ content }}</article>\n",
  'themes' => ['olivero'],
  'status' => TRUE,
]);
$t->save();   // postSave() writes public://twig_ui/olivero/node--article.html.twig and rebuilds the kernel
```

Disable with `$t->set('status', FALSE)->save();` (deletes the files); delete with `$t->delete();`.
The filename is the suggestion with `_` → `-` plus `.html.twig`
(`node__article` → `node--article.html.twig`), under `public://twig_ui/<theme>/`.

### Read back

```bash
drush cget twig_ui.template.my_node_article
drush config:status         # shows it as a config entity
```

## Validation rules (form)

- Only **one enabled** template may exist for a given `theme_suggestion` + `theme`
  combination. `TwigTemplateForm::validateForm()` calls
  `TemplateManager::templateExists()` and sets an error on the `themes` field if a
  conflicting enabled template already targets that theme.
- The **Clone** operation copies an entity, prefixes the label with "Clone of", sets the id
  to `clone_<originalid>`, and clears `themes` so you must re-pick.

## Global settings — `twig_ui.settings`

Settings form route `twig_ui.settings` at `/admin/config/system/twig_ui`
(`Drupal\twig_ui\Form\SettingsForm`, a `ConfigFormBase`). Keys:

| Key | Values | Meaning |
|---|---|---|
| `allowed_themes` | `all` \| `selected` | Whether every active theme is offered on the template form, or only a chosen list. |
| `allowed_theme_list` | array of theme machine names | Used when `allowed_themes` = `selected`. |
| `default_selected_themes` | array of theme machine names | Pre-checked themes on the *new* template form. |
| `codemirror_config` | YAML string | Passed to the CodeMirror editor when `codemirror_editor` is installed (e.g. `lineNumbers: false`). |

```bash
drush cget twig_ui.settings
drush cset twig_ui.settings allowed_themes selected -y
```

Config schema lives in `config/schema/twig_ui.schema.yml` (`twig_ui.settings` config_object
and `twig_ui.template.*` config_entity), so both are validatable/exportable.

## Templates directory

Files are written under `public://twig_ui/` (constant
`TemplateManager::DIRECTORY_PATH = 'public://twig_ui'`), each theme in its own subdirectory,
protected by an `.htaccess`. `hook_requirements()` flags the directory if missing/unprotected
and links to the `twig_ui.templates_directory_prepare` route to (re)create it. On non-Apache
servers ensure `public://twig_ui` is not web-accessible.
