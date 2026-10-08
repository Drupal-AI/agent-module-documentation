<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Email Octopus — setup & API surface

## Configure the API key
Form `OctopusConfigurationForm` at `/admin/config/credentials` (route `email_octopus.configuration_form`). Saves `api_key` into config `octopus.adminsettings`. Stored in **plaintext config** (exported with config sync) — there is no Key module integration; treat the key as a secret and avoid committing it.

## Access-control caveat
All three routes declare `requirements._permission: 'administer'`. No permission named exactly `administer` exists in Drupal core, so the access check grants only user 1 (fails closed). If admins cannot reach the forms, that is why — a patch would change this to a real permission (e.g. `administer site configuration`).

## Public subscribe block
- Block id `email_octopus_subscribe_form_block` (`SubscribeFormBlock`), placed via Block layout; each instance picks a list and sets title/body/thank-you message.
- Renders `OctopusSubscribeForm`, which validates the email (`FILTER_VALIDATE_EMAIL`) and calls `subscribe()`:
  - POST `https://emailoctopus.com/api/1.5/lists/{listid}/contacts` with JSON `{api_key, email_address, status:"SUBSCRIBED"}` via Guzzle (`http_client`), 300s timeout, TLS default (verified).
  - Returns `'1'` success, `'2'` already a member, `'0'` no key / error.
- **No CAPTCHA or rate limiting** — this is an anonymous endpoint; a bot can submit arbitrary emails and consume API quota. Add a spam-protection/CAPTCHA module in front of it on production.

## Admin list browser
`OctopusListForm` (`/admin/config/users-list`): GET `.../lists?api_key=KEY` to populate the list select, then GET `.../lists/{id}/contacts/{subscribed|unsubscribed}?api_key=KEY` to table the contacts. The API key is sent as a query parameter here.

## Notes for agents
- Verify the key is set before expecting the block to work (empty key → subscribe returns `'0'`).
- Two files `define("URL", ...)` the lists endpoint (block + list form); harmless duplication.
