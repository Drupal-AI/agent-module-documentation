<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Convivial Enricher Mailchimp (convivial_enricher_mailchimp) — agent index

Submodule of [Convivial Enricher](../../../../1.0.x/agent/start.md). Adds the `mailchimp`
EnricherDatasource plugin that enriches a visitor from their Mailchimp list-member record, looked
up by unique id via the contrib Mailchimp client. Package `Convivial`. Depends on
`convivial_enricher` and contrib `mailchimp`. Core `^10.2 || ^11 || ^12`. GPL-2.0-or-later.
Version 1.0.0-alpha10.

- **The datasource plugin, settings, allow-lists, and the fetch/tag logic** →
  [plugins/mailchimp.md](plugins/mailchimp.md)

## What it provides (from source)

- **Plugin** `MailchimpEnricherDatasource` (id `mailchimp`, subdir `Plugin/EnricherDatasource`),
  extends the parent's `EnricherDatasourceBase`.
- **No API adaptor / no credential of its own** — the constructor pulls the Mailchimp client from
  contrib `mailchimp`'s `mailchimp.client_factory` (`ClientFactory::getByClassNameOrNull(
  'MailchimpLists')`). Credentials live in the Mailchimp module.
- **Hook service** `Hook\ConvivialEnricherMailchimpHooks` — help text only.
- **Schema** `convivial_enricher.datasource.mailchimp`: `mailchimp_list_id`,
  `allowed_contact_properties`, `allowed_contact_tags` (all string).

No permissions, no routes, no Drush. Plugs into the parent's `enricher` entity and public endpoint.

## Request path (summary)

`processIncomingPath()` rewrites `/{endpoint}/{uniqid}/{return/to}` →
`/{endpoint}/data:<base64(return_to=…&token=uniqid)>`. `fetchAndProcessData($uniqid)` →
`getMemberInfoById($list_id, $uniqid)` on the Mailchimp client, filters member properties by the
Contact Properties allow-list, splits the `tags` property's `namespace/tag` values by the Contact
Tags allow-list, and returns `convivial_enricher_*` cookies. Details in the plugin doc.
