<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Lionbridge Translation Provider (project `lionbridge_translation_provider`) — agent index

A TMGMT translator plugin that sends translation jobs from Drupal to the **Lionbridge
Content API** (professional, human translation) and pulls the completed translations back
into the normal TMGMT review/accept workflow. Depends on `tmgmt`. Core `^9 || ^10 || ^11`.

> **Project name ≠ module name.** The project is `lionbridge_translation_provider`, but the
> installable module it ships is **`tmgmt_contentapi`** (the only `.info.yml` in the package).
> Enable with `drush en tmgmt_contentapi`; `drush en lionbridge_translation_provider` fails.
> Composer still uses the project name: `composer require drupal/lionbridge_translation_provider`.
> The TMGMT translator plugin id is **`contentapi`** (`@TranslatorPlugin(id="contentapi")`).

No dedicated settings page. `configure` points at TMGMT's translator collection
(`entity.tmgmt_translator.collection`, `/admin/tmgmt/translators`) — you create a translator
of type "Lionbridge Content API Connector" there. Defines **1 permission**, **1 route**,
**1 block**, a **plugin type** (`FormatPlugin`), several **views field/filter** plugins, and
**7 queue workers**. No drush commands.

Solution docs:
- **Configure the Lionbridge translator (credentials, host, provider, cron auto-import)** → [configure/translator.md](configure/translator.md)
- **Public services + the submit / poll / import runtime flow + the queue-process route** → [api/services.md](api/services.md)
- **The `access queue process` permission** → [permissions/permissions.md](permissions/permissions.md)
- **The `FormatPlugin` export-format plugin type (add your own)** → [plugins/format.md](plugins/format.md)
- **Hooks it implements (cron, form/entity-op alters, tmgmt_job_delete, views)** → [hooks/hooks.md](hooks/hooks.md)
- **The Queue Status block** → [blocks/queue-status.md](blocks/queue-status.md)
- **Views fields/filters over the connector tables** → [views/views.md](views/views.md)

Key facts:
- Module machine name: `tmgmt_contentapi`. Translator plugin id: `contentapi`.
- Translator config entity: `tmgmt.translator.contentapi` (settings live under `settings.*`).
- Credential/host keys: `settings.capi-settings.capi_username_ctt` (Client ID),
  `capi_password_ctt` (Client Secret), `capi_host` (default `https://contentapi.lionbridge.com/v2`),
  `provider`. Token endpoint: `https://login.lionbridge.com/connect/token`.
- Cron: `tmgmt_contentapi_cron()` — polls Lionbridge status updates and (if enabled) auto-imports.
- Permission: `access queue process` (restrict access TRUE).
- Route: `tmgmt_contentapi.queue_process_in_bg` → `/tmgmt-contentapi/queue-process-background/{queue_name}/{batch_size}` (POST).
- Block: `queue_status_block`. Plugin type: `FormatPlugin` (manager `plugin.manager.tmgmt_contentapi.format`).
- Install tables: `tmgmt_capi_request_processor`, `tmgmt_capi_response`.
- Optional "Analysis Code" feature talks to the Lionbridge Freeway SOAP API
  (`settings.code-analysis-settings.*`).
