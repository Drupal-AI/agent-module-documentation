<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# b24_webform (b24_webform) — agent index

Submodule of **[b24](../../../../agent/start.md)**. Exports **Webform** submissions to
Bitrix24 **leads** through a Webform handler. Depends on `b24` and contrib `webform`. Package
`bitrix24`. Configure route `b24_webform.settings` (`/admin/config/b24/webform`, permission
`administer b24 configuration`).

## What it provides

- **Webform handler plugin `b24_webform_handler`**
  (`src/Plugin/WebformHandler/B24WebformHandler.php`, `WebformHandlerBase`) — single-cardinality,
  processes results.
  - `buildConfigurationForm()` builds a *Fields mapping* fieldset via
    `FormHelper::getMappingSelects($form, $config, $webform->getElementsDecodedAndFlattened(),
    'settings', ['webform','webform_submission'])`; stored in `configuration['mapping']`.
  - `postSave()` — on a `completed` submission (or when results are disabled), for each mapped
    Bitrix24 field takes the value from a webform element (`$values[$int_field]`) or a
    token-replaced `<field>_custom` string; wraps `crm_multifield`; then
    `RestManager::addLead($fields)`.
- **`SettingsForm`** (`src/Form/SettingsForm.php`) — informational page listing every webform with a
  link to add/edit its `b24_webform_handler` (settings moved to the handler itself); warns users
  lacking `edit any webform` / per-webform update access.

Config for mappings is stored on the webform's handler configuration (no module config object /
schema of its own). No separate solution doc — the handler above is the whole module.
