<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DeferJs — settings form & config

One admin form drives everything. There is no default config shipped, so until you save this form the
config object `deferjs.settings` does not exist and the module does nothing (`module_enable` is unset).

## Route & access
- Route name: `deferjs.settings`
- Path: `/admin/config/development/performance/deferjs` (a local task under *Performance*,
  `system.performance_settings`)
- Form: `\Drupal\deferjs\Form\DeferJsForm` (`getFormId()` → `deferjs_form`, extends `ConfigFormBase`)
- Permission: `administer site configuration` (core; the module defines none of its own)
- Note: the info.yml `configure:` key points at `deferjs.settings_form`, which is **not** a defined route,
  so the *Configure* link on `/admin/modules` is broken. Navigate to the path directly.

## Config keys (`deferjs.settings`)
Set via `DeferJsForm::submitForm()` (`src/Form/DeferJsForm.php:91`), which also calls
`drupal_flush_all_caches()` on save.

| Key | Form element | Type | Meaning |
| --- | --- | --- | --- |
| `module_enable` | checkbox "Enable deferjs" | bool | Master on/off. When false, both hooks short-circuit. |
| `enabled_content_types` | checkboxes "Enabled Content Types" | array of node-type ids | **Exclude** list despite the label — see below. Options include `'' => "Select All"`. |
| `exclude_page` | textarea "Exclude Pages" | string | Path **aliases** to skip, one per line (`\r\n`-separated). Matched exactly (no wildcards). |
| `exclude_file` | textarea "Exclude JS files" | string | JS asset paths to skip, one per line (`\r\n`-separated). Compared as `'/' . $value['data']`. |

The content-type options are built from `entity_type.manager` → `node_type` storage
(`buildForm()`, `DeferJsForm.php:60`), so a node module must be present for the list to populate.

## Set it from the CLI
```bash
# module is a no-op until this is saved; there is no config/install default
ddev drush config:set deferjs.settings module_enable 1 -y
ddev drush config:set deferjs.settings exclude_page $'/blog/one\n/blog/two' -y
ddev drush config:set deferjs.settings exclude_file '/core/misc/drupal.js' -y
```
There is no `config/schema/` for the module, so these values are stored schema-less; core config-inspection
tooling may warn about the missing schema, but the module reads the raw values directly.

## enabled_content_types gotcha
The form describes this field as "by default this will enabled for all content type, un-check if you want
exclude any content type", and the runtime check in `deferjs_js_alter()` is
`!in_array($curentPageContentType, $enabled_content_type_name)`. Net effect: **checking a content type
turns deferral OFF for that type's node pages**; leaving everything unchecked defers everywhere. It reads
as an include list but behaves as an exclude list. The `'' => "Select All"` option contributes an empty
string that is filtered out and has no effect. See `agent/hooks/asset-alter.md` for the full flow.
