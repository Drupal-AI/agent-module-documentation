<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `mailchimp` datasource

`modules/convivial_enricher_mailchimp/src/Plugin/EnricherDatasource/MailchimpEnricherDatasource.php`.
Id `mailchimp`, label *"Mailchimp"*. Extends the parent's `EnricherDatasourceBase`.

## Dependencies / client

- Constructor DI: `logger.factory` (channel `convivial_enricher`) and `mailchimp.client_factory`
  (contrib Mailchimp module). `$this->mailchimpApiClient =
  $mailchimp_client_factory->getByClassNameOrNull('MailchimpLists')`.
- **No API key is stored by this submodule** — Mailchimp credentials/transport come entirely from
  the contrib `mailchimp` module. Add `mailchimp:mailchimp` and configure it first.

## Settings (`buildConfigurationForm()`)

- `mailchimp_list_id` (required textfield) — the Mailchimp audience/list id to query.
- `allowed_contact_properties` (required textarea, default `tags`) — newline `fnmatch` patterns
  filtering member property names.
- `allowed_contact_tags` (textarea) — `fnmatch` patterns filtering tag namespaces.

Schema `convivial_enricher.datasource.mailchimp` (all string).

## `fetchAndProcessData($uniqid)`

1. `getListMemberInfoById($list_id, $uniqid)` → `mailchimpApiClient->getMemberInfoById(...)` (only
   if the client initialised). The token from the endpoint is used directly as the member UNIQID.
   Exceptions are caught and `logger->warning()`-logged.
2. For each `$this->listMember->members` member, cast to array and
   `filterKeyValueSetOnAcceptList($fields, $allowed_properties)` (`fnmatch(trim($pattern), $key)`).
3. For the `tags` field: `getContactTags($raw_tags)` splits each tag's `name` on `/` into
   `namespace => tagname`, then filters by `$allowed_tags`; each survivor → `createCookie($name,
   $value)`.
4. Other surviving fields: array/object values are `Json::encode()`d, then `createCookie(
   $field_name, $field_value)`.
5. Returns the collected `convivial_enricher_*` cookies.

## Notes

- Values are written into cookies for client-side profile tools; this module does not render the
  fetched Mailchimp data into any HTML/markup itself.
- `processIncomingPath()` reshapes the inbound URL exactly like the ActiveCampaign datasource
  (base64 `data:` token/return_to encoding).
