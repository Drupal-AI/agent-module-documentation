<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure download options & attach them to a field

Two configuration steps: (1) create one or more **Download Option Config** entities, (2) enable them
in the **File Downloader** field formatter on a `file`/`image` field.

## 1. Create a Download Option Config entity

- Admin UI: **Configuration → Media → Download Options** — collection route
  `entity.download_option_config.collection` at `/admin/config/media/download_options`. "Add" =
  `entity.download_option_config.add_form` (`/admin/config/media/download_options/add`).
- Form: `Drupal\file_downloader\Form\DownloadOptionConfigForm`. Fields:
  - **Label** (`label`) — required.
  - **Machine name** (`id`) — the config entity id; disabled once saved. It becomes part of the
    per-option permission name (`use {id} download option link`) and the URL.
  - **Allowed file extensions** (`extensions`) — space/comma separated, no leading dot. **Empty means
    all extensions are allowed.** Validated by `DownloadOptionConfigForm::validateExtensions`
    (`DownloadOptionConfigForm.php:216`, regex `^([a-z0-9]+([.][a-z0-9])* ?)+$`, lower-cased).
  - **Plugin** (`plugin_id`) — required, **only selectable when the entity is new** and then locked
    (`#disabled => !isNew()`); options come from `plugin.manager.download_option`. Choosing the plugin
    at creation is permanent — to change plugin, delete and recreate.
- After the first save, editing the entity shows a **"Plugin specific settings"** fieldset built from
  the chosen plugin's `downloadOptionForm()` (e.g. the `image_style` plugin adds an **Image Style**
  select whose value is stored under the `settings.image_style` config key).

The saved config entity (config prefix `download_option_config`, e.g.
`download_option_config.<id>.yml`) exports: `id`, `label`, `uuid`, `plugin_id`, `extensions`,
`settings`. Schema: `config/schema/download_option_config.schema.yml`.

Example stored config:

```yaml
id: original
label: 'Original file'
plugin_id: original_file
extensions: 'pdf jpg png'   # empty = all extensions allowed
settings:
  id: original_file
  extensions: 'pdf jpg png'
```

## 2. Enable options on the File Downloader field formatter

On a `file` or `image` field's display (Manage display), set the formatter to **File Downloader**
(`file_downloader_formatter`). Its settings form
(`FileDownloaderFieldFormatter::settingsForm`, `FileDownloaderFieldFormatter.php:37`) shows a
**required** checkboxes element **Download options** (`download_options`) listing every existing
Download Option Config (label plus its extensions in parentheses). Each checked option becomes one
download link when the field renders.

Formatter setting stored under `field.formatter.settings.file_downloader_formatter`:

```yaml
download_options:
  original: original
  thumb: thumb
```

## Grant access

Creating a config entity does not by itself let anyone download. Each option generates the dynamic
permission **`use {id} download option link`** — grant it to the roles that should see/use that
option's link (People → Permissions). Downloads additionally require the file entity's own `view`
access and, if `extensions` is set, a matching file extension. See
[../permissions/permissions.md](../permissions/permissions.md) and
[../api/download-route.md](../api/download-route.md).
