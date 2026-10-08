<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings config object & admin form

## Config object `openintranet_documents.settings`

Single config object. Install default (`config/install/openintranet_documents.settings.yml`):

```yaml
enabled_sources:
  - local_file
default_source: local_file
max_file_size: 50
```

Schema (`config/schema/openintranet_documents.schema.yml`, type `config_object`):

| Key | Type | Meaning |
|---|---|---|
| `enabled_sources` | sequence of string | plugin ids offered to editors when adding a document |
| `default_source` | string | source pre-selected on the add form |
| `max_file_size` | integer | maximum local upload size, in MB |

`provides_config_schema: true`. There is no config schema for the entities themselves — they are
code-defined content entities.

## Admin form — `DocumentSettingsForm`

Route `openintranet_documents.settings` at **`/admin/config/content/documents`**, permission
**`administer oi_document`**. Class `src/Form/DocumentSettingsForm.php` (extends `ConfigFormBase`,
form id `openintranet_documents_settings`, editable config `openintranet_documents.settings`).

Fields:

- **Enabled Document Sources** — `checkboxes` over every discovered source. `local_file` is
  force-checked and `#disabled` (always enabled); `submitForm()` re-adds `local_file` to the saved
  list unconditionally.
- **Default Document Source** — `select` over all sources.
- **Maximum file size (MB)** — `number`, min 1 / max 500, default 50.

`submitForm()` writes `enabled_sources` (filtered, with `local_file` forced),
`default_source`, and `max_file_size` (cast to int) back to the config object.

> Note: the file field's own upload validators (`LocalFile::buildSourceForm()` and the
> `oi_document` base field) hard-code a 50 MB limit and the extension allowlist; the
> `max_file_size` setting is stored but the shipped `local_file` source does not read it back into
> its `FileSizeLimit` validator.

## How enabled/default sources are consumed

- `DocumentSourceManager::getEnabledDefinitions()` reads `enabled_sources`.
- `OiDocumentForm::buildForm()` builds the source `select` from the enabled definitions and uses
  `getDefaultSourceId()` when no source is chosen.
- `template_preprocess_oi_documents_browser()` exposes the enabled sources to the browser template
  so the toolbar shows one "add" action per enabled source.

## The `configure` link

`info.yml` sets `configure: entity.oi_folder.collection` (the folder admin collection at
`/admin/content/...`), so the module's "Configure" link on the Extend page points to the folder
listing rather than to this settings form. The settings form is reached directly at
`/admin/config/content/documents`.
