<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration & settings

## Install & enable

```bash
composer require drupal/media_entity_download
drush en eplikt -y   # pulls in core media + media_entity_download (info.yml deps)
```

No composer.json ships with the module; the only declared dependencies are core `media` and the
contrib `media_entity_download` module (`eplikt.info.yml`).

## Settings form

`Drupal\eplikt\Form\SettingsForm` (extends `ConfigFormBase`, form id `eplikt_settings`).

- Route `eplikt.settings` → path `/admin/config/services/eplikt`, requirement
  `_permission: 'administer site configuration'` (`eplikt.routing.yml`).
- Menu link `eplikt.settings` under `system.admin_config_services`
  (Configuration → Web services) (`eplikt.links.menu.yml`).
- `info.yml` sets `configure: eplikt.settings`.
- Editable config: `eplikt.settings` (`getEditableConfigNames()`).

Fields (`buildForm()`):

| Form key | Type | Config key | Notes |
|---|---|---|---|
| `publisher` | textfield | `publisher` | Publisher identifier stamped as `dc:publisher` on every item. README suggests `http://id.kb.se/organisations/SE<org_number>+ev.[-suffix]`. |
| `access_rights` | select | `access_rights` | Options `gratis` (Free) / `restricted` (Restricted); default `dcterms:accessRights` value. |
| `sources` | multi-select | `sources` | Which `eplikt_source` plugins are active. Options come from `getPluginOptions()` (all defined plugins, sorted by label). |

For each selected source id, `buildForm()` creates an instance, calls
`setConfiguration($config->get($id) ?? [])`, and embeds that plugin's `buildConfigurationForm()`
inside a `#tree => TRUE` `details` element keyed by the plugin id (so you configure sources only
after saving them into `sources` first).

## Config object `eplikt.settings`

Install defaults (`config/install/eplikt.settings.yml`):

```yaml
access_rights: gratis
publisher: https://www.drupal.org
sources: []
```

Per-source configuration is stored flat under the plugin id. `submitForm()` writes
`access_rights`, `publisher`, `sources`, then for each source id iterates its submitted values and
sets `<source_id>.<key>` (e.g. the shipped plugins store `node_source.bundles` /
`media_source.bundles`).

There is **no `config/schema/`** directory — the module provides no config schema, so strict
config-schema tooling will flag `eplikt.settings`. Values still save and load normally.
