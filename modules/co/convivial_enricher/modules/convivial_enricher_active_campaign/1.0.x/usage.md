Adds an `active_campaign` Enricher datasource that enriches a visitor from their ActiveCampaign contact record (properties, tags and custom fields) looked up by email hash.

---

This submodule of Convivial Enricher registers the `active_campaign` EnricherDatasource plugin (`ActiveCampaignEnricherDatasource`) and a Guzzle-based REST adaptor (`ActiveCampaignPhpApiAdaptor`, service `convivial_enricher_active_campaign.api`). On each enricher, you configure the ActiveCampaign API key and account base URL, three allow-lists (contact properties, contact tags, contact fields) expressed as shell-wildcard patterns, an optional opt-in privacy property, and per-call caching. At request time the datasource takes the token (an ActiveCampaign contact `email_hash`), calls `GET {base_url}/api/3/contacts?email_hash=…` with the `Api-Token` header, then follows up with `contactTags`, account `tags` and `fieldValues` lookups, matches tag ids to names, filters every result through the allow-lists (`fnmatch`), and returns the surviving values as `convivial_enricher_*` cookies. If privacy honouring is enabled, the contact's own properties are only emitted when the configured opt-in property on the contact is truthy. A cache check compares each contact id's cached email hash against the incoming one and raises a `ContactHashMismatchException` on mismatch. Requires the parent `convivial_enricher` module and a valid ActiveCampaign account.

---

- Enrich a visitor from their ActiveCampaign contact record after they click an email-campaign link.
- Look up an ActiveCampaign contact by `email_hash` token carried in the endpoint URL.
- Expose selected contact properties (first name, last name, etc.) as cookies.
- Expose a contact's ActiveCampaign tags, resolved from tag ids to human names.
- Expose a contact's custom field values keyed by field title.
- Restrict which contact properties are stored using shell-wildcard allow-list patterns (`*`, `?`, `[]`).
- Restrict which tags are stored (e.g. `campaign*` to only keep campaign-namespaced tags).
- Restrict which custom fields are stored via a separate fields allow-list.
- Enforce GDPR-style consent by only enriching contacts whose opt-in privacy property is TRUE.
- Configure the privacy property name (default `privacy_accepted`) that gates enrichment.
- Cache the account-wide tag list to avoid repeating that lookup on every request.
- Cache per-contact tag ids and the contact record with independent, human-readable expiries.
- Stay within ActiveCampaign's 5 requests/second rate limit by tuning the three cache toggles.
- Detect a changed contact email hash for a known contact id and abort to resist hash spoofing.
- Provide segmentation cookies to downstream personalisation/profile tooling.
- Point the datasource at any ActiveCampaign account by setting its base URL and per-user API key.
