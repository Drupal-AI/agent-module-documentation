A Drupal client library for the ActiveCampaign v3 marketing/CRM REST API, exposing typed endpoint and resource classes plus an event-tracking service.

---

The `activecampaign_api` module is a thin, typed PHP wrapper around ActiveCampaign's v3 REST API. It stores one or more sets of credentials (API base URL + API token, and optional event-tracking key/actid) as `activecampaign_api_account` config entities managed under Configuration -> Web services -> ActiveCampaign API. Developers obtain an endpoint from the `activecampaign_api.endpoint_factory` service (after selecting an account) and call `get()`/`create()`/`update()`/`delete()`/`list()` to work with contacts, lists, tags, custom fields, field values and account-contact data. Responses are hydrated into plain `ApiResource` value objects (Contact, ContactList, Tag, Field and its typed subclasses, etc.). A separate `EventTrackingService` posts named site events for a contact e-mail. Two convenience module functions cover the common "subscribe an e-mail to a list" and "find the account for a contact" flows. The module is mostly consumed by higher-level modules (notably `contact_activecampaign`) rather than used directly by site builders, and ships an optional `activecampaign_api_raven_context` submodule that adds request payload context to Sentry error reports. Outbound calls go through Drupal's `http_client` (Guzzle) with TLS verification left at its secure default; the API token is sent as an `Api-Token` header, never in the URL.

---

- Integrate a Drupal site with ActiveCampaign's CRM/marketing platform via its v3 REST API.
- Store credentials for multiple ActiveCampaign accounts side by side as config entities.
- Subscribe an e-mail address to a named ActiveCampaign contact list from custom code (`activecampaign_api_subscribe_contact_to_list()`), auto-creating the contact if needed.
- Unsubscribe or re-subscribe an existing contact from a list via `ContactLists::updateStatus()`.
- Look up a contact by e-mail and read its list memberships (`Contacts::list()`, `Contacts::getContactListMemberships()`).
- Create new ActiveCampaign contacts (name, e-mail, phone, custom field values) from Drupal data.
- Update existing contacts, keeping ActiveCampaign records in sync with Drupal user/profile changes.
- Manage ActiveCampaign contact tags: create, list, fetch and delete tags (`Tags` endpoint).
- Read and manage custom contact fields and their per-contact values (`Fields`, `FieldValues`, `FieldRels`).
- Introspect the account's custom field definitions with typed field classes (text, textarea, date, datetime, dropdown, listbox, radio, checkbox, hidden, number).
- Work with account (organization) records and their linked contacts (`Accounts`, `AccountContacts`, `AccountCustomFieldMeta`, `AccountCustomFieldData`).
- Resolve the ActiveCampaign account associated with a given contact (`activecampaign_api_get_account_by_contact()`).
- Track custom site events (e.g. "purchased", "signed_up") against a contact's e-mail using the event-tracking API (`EventTrackingService::track()`).
- Paginate large result sets automatically via the built-in offset/limit loop in `Endpoint::listResources()`.
- Alter outbound create/update payloads before they are sent using `hook_activecampaign_api_endpoint_createresource_alter()` / `_updateresource_alter()`.
- Forward failed create/update/delete API calls to an external reporting webhook for monitoring, with the API token redacted from the reported payload.
- Add ActiveCampaign request context to Sentry error reports via the optional Sentry Context submodule.
- Diagnose connectivity and credentials with the built-in Test form (fetch any resource by id) and List fields form under the admin UI.
- Build higher-level Drupal integrations (newsletter signup, e-commerce sync, membership sync) on top of a consistent typed client rather than raw HTTP calls.
- Support per-environment configuration by pointing different accounts at different ActiveCampaign base URLs.
