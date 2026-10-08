<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
SharpSpring CRM connects Drupal Webforms to the SharpSpring marketing CRM, sending submissions as CRM leads or list subscriptions through SharpSpring's JSON Public API.
---
The module ships two Webform handler plugins — `SharpSpringCrmLeadHandler` (maps webform fields to SharpSpring lead fields and calls `createLeads` on submission) and `SharpSpringCrmListHandler` (adds a submitter email to a chosen active list) — plus a service class `SharpSpringCrm` that wraps the API methods `getActiveLists`, `getFields`, `addListMemberEmailAddress` and `createLeads`. Credentials (`account_id`, `secret_key`, and a fallback/backup email) are entered on the config form at `/admin/config/sharpspring_crm/settings`, gated by the `administer sharpspring settings` permission. When a lead fails to reach SharpSpring, the lead handler emails a backup address with a link to the submission.

Security/operational notes accurate to this code: every API call builds its URL as `http://api.sharpspring.com/pubapi/v1/?...` over **plain HTTP** with the `accountID` and `secretKey` placed directly in the query string (`SharpSpringCrm.php`), so the API secret is transmitted in cleartext and can be intercepted or logged by intermediaries. The secret is stored in ordinary module config. Request `id` uses `rand()`, which is fine here since it is only a JSON-RPC correlation id, not a security token. Setup: obtain a SharpSpring account ID and secret key from the SharpSpring account settings, save them on the config form, then attach the Lead or List handler to a Webform and map its fields.
---
- Enter your SharpSpring `account_id` and `secret_key` at `/admin/config/sharpspring_crm/settings`.
- Set a backup email address to receive failed-lead notifications.
- Attach the SharpSpring Lead Handler to a Webform.
- Map webform field machine names to SharpSpring lead fields.
- Push completed Webform submissions to SharpSpring as leads.
- Attach the SharpSpring List Handler to a Webform for list signups.
- Add a submitter's email to a chosen SharpSpring active list.
- Fetch the list of active SharpSpring email lists for configuration.
- Retrieve SharpSpring lead field definitions to drive field mapping.
- Mark required SharpSpring fields as required on the webform mapping.
- Receive an admin email with a submission link when a lead fails to send.
- Grant `administer sharpspring settings` only to marketing admins.
- Collect newsletter signups from a contact form into SharpSpring.
- Sync event registration webforms into a SharpSpring list.
- Route different webforms to different SharpSpring lists.
- Verify the account ID/secret by loading the field list on the handler form.
- Log SharpSpring API errors to the `sharpspring_crm` channel.
- Review that credentials are sent over HTTP and plan a proxy/TLS mitigation.
- Rotate the SharpSpring secret key if it may have been exposed.
- Disable a handler to pause syncing without deleting the mapping.
