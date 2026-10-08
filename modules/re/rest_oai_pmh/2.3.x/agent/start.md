<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# rest_oai_pmh — agent start

Turns Drupal into an **OAI-PMH 2.0 repository**. One REST resource (`oai_pmh`) at
**`/oai/request`** answers the six OAI verbs (`Identify`, `ListMetadataFormats`, `ListSets`,
`ListIdentifiers`, `ListRecords`, `GetRecord`) via a `verb` GET/POST param. Depends on
`views` + `rest`. Configure route: `rest_oai_pmh.rest_oai_pmh_settings_form`
(`/admin/config/services/rest/oai-pmh`).

**How it works:** you don't expose entities directly — you select **Views** (each an
*Entity Reference* display) on the settings form; a queue/batch/cron job indexes their results
into three tables (`rest_oai_pmh_record`, `rest_oai_pmh_set`, `rest_oai_pmh_member`). Each View
= one OAI **set** (or, with an entity-reference contextual filter, one set per referenced entity).
At harvest each record is rendered by an **OaiMetadataMap** plugin and re-checked for view access
live. A bare install returns **403** until you grant `restful get oai_pmh` (usually to anonymous).

- Turn the endpoint on, pick Views/sets, set path/name/email, choose metadata format & cache
  strategy, rebuild the index → [configure/endpoint.md](configure/endpoint.md)
- The two plugin types — write a custom metadata schema (`OaiMetadataMap`) or cache strategy
  (`OaiCache`), plus the template-override hook → [plugins/metadata-and-cache.md](plugins/metadata-and-cache.md)

Key names: REST resource id `oai_pmh` (route `rest.oai_pmh.GET` / `.POST`); default path
`/oai/request` (`OaiPmh::OAI_DEFAULT_PATH`); config object `rest_oai_pmh.settings`; plugin
managers `plugin.manager.oai_metadata_map` + `plugin.manager.oai_cache`; metadata plugins
`dublin_core_rdf`/`dublin_core_metatag` (`oai_dc`), `mods` (`mods`), `default_metadata_map`
(`oai_raw`); cache plugins `liberal_cache` / `conservative_cache`; queue
`rest_oai_pmh_views_cache_cron`; resumption tokens in keyvalue `rest_oai_pmh.resumption_token`.
No Drush commands; no permissions of its own (endpoint gated by core REST perm
`restful get oai_pmh`, settings form by `administer rest resources`).
