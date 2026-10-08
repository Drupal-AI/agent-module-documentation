<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Web Service Manager (wsm) — agent index

**Configure outbound web-service endpoints (URL/headers/params/field mappings) and import their JSON/XML into Drupal entities via cron or a render-time field formatter.**

- **Version:** 3.0.x (dev-3.0.x checkout; info.yml stamps 2.1.1)
- **Core:** ^10.3 || ^11
- **Requires:** jsonapi
- **Configure route:** `entity.endpoint.collection` → `/admin/config/services/wsm` (`_permission: administer wsm`) — all endpoint/header/param/field_mapping routes gated by `administer wsm`
- **Permission:** `administer wsm`
- **Config entities:** `endpoint`, `header`, `param`, `field_mapping`
- **Service:** `wsm.webservice_manager` (WebServiceManager) — `endpointCall()`, saveEntity / saveEntityUrlParamMode, createImage, deleteObsoleteEntities
- **Cron:** CronTasks::endpointsCall() calls all save-enabled endpoints
- **Field formatter:** `wsm_endpoint` (entity_reference) — calls the API on render, themes via `endpoint_reference_formatter`
- **Multilingual:** `[LANG]` in source path (response_data) or URL (url_param)
- See [configure/endpoints.md](configure/endpoints.md)

**Access:** all routes gated by `administer wsm`. Endpoint URLs/headers/params are **admin-configured**; server-side fetches + response-URL image downloads use Guzzle defaults. XML parsed with `simplexml_load_string`. Remote API tokens go in header/param config values.
