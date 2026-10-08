<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DCAT-AP field-provider plugins

The whole module is three `dcat_field_provider` plugins (the plugin type is defined by the base
`dcat` module; dcat_ap only supplies instances) plus an install hook and optional display config.
Files in `src/Plugin/DcatFieldProvider/`. Each extends `Drupal\dcat\DcatFieldProviderBase` and
carries the `#[Drupal\dcat\Attribute\DcatFieldProvider]` attribute (`id`, `entity_type`, `label`,
`weight: 5`). Two methods matter: `getFieldDefinitions()` returns new `BaseFieldDefinition`s to
merge onto the target entity; `alterFieldDefinitions(array &$fields)` mutates the base fields the
`dcat` module already defined (referenced by the base interfaces' `FIELD_*` constants).

## Install / enable

`ddev drush en dcat_ap -y` (pulls in `dcat`). On install, `dcat_ap_install()` in
`dcat_ap.install` runs `\Drupal::moduleHandler()->loadInclude('dcat', 'install')` then
`dcat_sync_entity_schemas()` — necessary because `dcat` creates the entity tables before
dcat_ap is enabled, so without the sync the new/altered fields exist only at runtime and are
never written to the DB. Any schema-change messages are logged to the `dcat_ap` channel.
There is no uninstall hook. No config to set — the module has no settings route.

## DcatApDatasetFields (`dcat_ap_dataset_fields`, entity_type `dcat_dataset`)

New base fields from `getFieldDefinitions()`:

| Machine name | Type | Card. | DCAT-AP term | Notes |
|---|---|---|---|---|
| `dcat_ap_version_info` | string (max 255) | 1 | owl:versionInfo | e.g. "1.0.2" |
| `dcat_ap_is_version_of` | link (URL-only, no title) | 1 | dcterms:isVersionOf | link to a dataset |
| `dcat_ap_has_version` | link (URL-only) | unlimited | dcat:hasVersion | |
| `dcat_ap_source` | link (URL-only) | unlimited | dcterms:source | derived-from dataset |
| `dcat_ap_provenance` | string_long | unlimited | dcterms:provenance | custody/ownership statement |
| `dcat_ap_sample` | entity_reference → `dcat_distribution` | unlimited | adms:sample | default handler |

Link fields set `link_type => 0x10` (external URL) and `title => DRUPAL_DISABLED`. Each field
sets configurable view/form display options (weights 30–39).

`alterFieldDefinitions()` (constants from `DcatResourceInterface`):
- `FIELD_DESCRIPTION` → `setRequired(TRUE)` (DCAT-AP mandatory) + updated description.
- `FIELD_PUBLISHER` → `setRequired(TRUE)` (DCAT-AP mandatory) + updated description.
- `FIELD_THEME` → description only (recommended; points at the EU Data Theme vocabulary).

## DcatApDistributionFields (`dcat_ap_distribution_fields`, entity_type `dcat_distribution`)

New base fields:

| Machine name | Type | DCAT-AP term | Notes |
|---|---|---|---|
| `dcat_ap_checksum` | string (max 512) | spdx:checksum | format "algorithm:hash-value", e.g. "sha-256:9f86d08..." (plain string, not validated) |
| `dcat_ap_representation_technique` | link (URL-only, no title) | adms:representationTechnique | EU representation-technique vocabulary URI |

`alterFieldDefinitions()` (constants from `DcatDistributionInterface`) — description updates only,
no `setRequired` calls (title and access URL are already required in the base
`DistributionCoreFields`):
- `FIELD_TITLE` → description (mandatory in DCAT-AP; already required in base).
- `FIELD_ACCESS_URL` → description (mandatory; already required in base).
- `FIELD_STATUS` → description (recommended; ADMS status vocabulary).
- `FIELD_FORMAT` → description (recommended; EU file-type vocabulary).
- `FIELD_MEDIA_TYPE` → description (recommended; IANA media types).

## DcatApAgentFields (`dcat_ap_agent_fields`, entity_type `dcat_agent`)

`getFieldDefinitions()` returns `[]` — no new fields. `alterFieldDefinitions()` (constants from
`DcatAgentInterface`):
- `FIELD_NAME` → `setRequired(TRUE)` (foaf:name mandatory in DCAT-AP) + updated description.
- `FIELD_TYPE` → **replaced** with a fresh `entity_reference` `BaseFieldDefinition`: target
  `taxonomy_term`, handler `default:taxonomy_term`, restricted to the `eu_corporate_body`
  bundle (`auto_create => FALSE`), `options_select` widget. Note: this expects a taxonomy
  vocabulary `eu_corporate_body` to exist; the module ships no such vocabulary, so the reference
  is empty until you create it and add terms.

## Display config (`config/optional/`)

Four YAML files provide default form + view displays for the new dataset and distribution fields
(`core.entity_{form,view}_display.dcat_dataset.dcat_dataset.default` and the `dcat_distribution`
pair). Each declares a config dependency on the matching base default display plus module deps
(`dcat_ap`, and `link`/`text` where used), so Drupal installs them only when those base displays
and modules already exist. They mirror the per-field `setDisplayOptions()` (weights, widgets,
formatters) from the plugins. The module ships no `config/schema/` and no `config/install/`.

## Operating notes

- After enabling, the new dataset/distribution fields appear on the standard Manage form/display
  and Manage display screens for those entity types (they are display-configurable base fields).
- Existing dataset/distribution/agent content saved before enabling may now fail validation on
  next edit because description/publisher/title/access-URL/name became required — a content
  cleanup, not a bug.
- To alter or extend the profile fields, add your own `dcat_field_provider` plugin (higher weight
  runs later) rather than patching this module.
