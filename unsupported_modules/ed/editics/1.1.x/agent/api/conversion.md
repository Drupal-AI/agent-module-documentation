<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# editics — remote conversion & template engine

## Configuration
`/admin/api/configuration` (`SettingsForm`, `administer site configuration`) writes `editics.api.settings`:
- `global_prod_url_server_access`, `global_prod_credential_id`, `global_prod_credential_pass`
- `global_recette_url_server_access`, `global_recette_credential_id`, `global_recette_credential_pass`

## Remote validate/convert
`FluxValidateService::remote($content, $options)` (service `default.validator.service`):
- `$options['_env']` selects `production`/`prod` vs default `recette` credentials.
- POSTs `json => $content` to the configured URL with `Authorization: Basic base64(id:pass)`.
- **`'verify' => false`** — TLS certificate verification is disabled on this credentialed request (`src/Service/Validator/FluxValidateService.php:115`). A MITM can capture the Basic-auth credentials. Report / patch before production use.

## Template engine (cri_php_word)
`TemplateProcessor` + element processors under `cri_php_word/src/elements/` map typed items (`Text`, `Date`, `Image`, `Table`, `Numeric`, `Percent`, `Checkboxlist`, `Evaluate`) into a .docx template.
- `Evaluate::process()` executes `eval('$v = ' . $val . ';')` on the item value (`cri_php_word/src/elements/Evaluate.php:19`) — arbitrary PHP if template content is attacker-influenced. Do not feed untrusted content through the Evaluate type.

## Mapping (cri_core_mapping)
`MappingService` parses YAML mapping documents (`src/mapping/documents/*.mapping.yml`) describing field → placeholder conversions; each `Models/Types/*` class implements one field type.
