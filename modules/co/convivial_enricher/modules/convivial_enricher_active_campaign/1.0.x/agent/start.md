<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Convivial Enricher ActiveCampaign (convivial_enricher_active_campaign) — agent index

Submodule of [Convivial Enricher](../../../../1.0.x/agent/start.md). Adds the `active_campaign`
EnricherDatasource plugin that enriches a visitor from their ActiveCampaign contact (properties,
tags, custom fields), looked up by email hash via ActiveCampaign REST v3. Package `Convivial`.
Depends on `convivial_enricher`. Core `^10.2 || ^11 || ^12`. GPL-2.0-or-later. Version 1.0.0-alpha10.

- **The datasource plugin, settings, allow-lists, privacy gate, caching, and the REST adaptor** →
  [plugins/active_campaign.md](plugins/active_campaign.md)

## What it provides (from source)

- **Plugin** `ActiveCampaignEnricherDatasource` (id `active_campaign`, subdir
  `Plugin/EnricherDatasource`), extends `convivial_enricher`'s `EnricherDatasourceBase`.
- **Service** `convivial_enricher_active_campaign.api` = `ActiveCampaignPhpApiAdaptor`
  (`arguments: [@http_client, @logger.factory, @cache.discovery]`) — Guzzle REST adaptor
  implementing `ActiveCampaignPhpApiAdaptorInterface`.
- **Exception** `Exception\ContactHashMismatchException` — thrown when a contact id's cached email
  hash differs from the incoming one (spoofing guard).
- **Hook service** `Hook\ConvivialEnricherActiveCampaignHooks` — help text only.
- **Schema** `convivial_enricher.datasource.active_campaign` (extends the parent's datasource
  schema): `active_campaign_api_key` (string), `active_campaign_base_url` (uri),
  `allow_list` (contact_properties/tags/fields), `privacy` (enabled, property_name),
  `cache_settings` (account_tags / contact_tags / contact → enabled + expiry).

No permissions, no routes, no Drush of its own — it plugs into the parent's `enricher` entity and
public endpoint.

## Request path (summary)

`processIncomingPath()` rewrites `/{endpoint}/{email_hash}/{return/to}` →
`/{endpoint}/data:<base64(return_to=…&token=email_hash)>`. `fetchAndProcessData($email_hash)` sets
the API key + base URL on the adaptor, resolves the contact, gathers properties/tags/fields, filters
each through `fnmatch` allow-lists, applies the privacy opt-in gate, and returns
`convivial_enricher_*` cookies. See the plugin doc for the API-call sequence and caching.
