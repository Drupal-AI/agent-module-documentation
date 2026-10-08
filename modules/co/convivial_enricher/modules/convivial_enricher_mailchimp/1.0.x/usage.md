Adds a `mailchimp` Enricher datasource that enriches a visitor from their Mailchimp list-member record (allow-listed properties and namespaced tags), looked up by unique id.

---

This submodule of Convivial Enricher registers the `mailchimp` EnricherDatasource plugin (`MailchimpEnricherDatasource`). It reuses the contrib Mailchimp module's client (`mailchimp.client_factory`, `MailchimpLists`) for credentials and transport, so this submodule stores no API key of its own — only a Mailchimp list id per enricher plus two allow-lists. At request time the datasource takes the token as the member's unique id (UNIQID) and calls `getMemberInfoById($list_id, $uniqid)`. It then walks the returned members, keeps only member properties whose names match the *Contact Properties* allow-list (`fnmatch`), and for the `tags` property splits each `namespace/tag` value and keeps those whose namespace matches the *Contact Tags* allow-list. Surviving values (arrays/objects JSON-encoded) are returned as `convivial_enricher_*` cookies. Requires the parent `convivial_enricher` module and the contrib Mailchimp module (configured with a Mailchimp API key).

---

- Enrich a visitor from their Mailchimp list-member record after an email click-through.
- Look up a Mailchimp list member by unique id (UNIQID) carried as the endpoint token.
- Target a specific Mailchimp audience/list per enricher via its list id.
- Reuse the contrib Mailchimp module's stored API key and client (no separate credential here).
- Expose allow-listed member properties as cookies (default allow-list: `tags`).
- Restrict which member properties are stored using shell-wildcard patterns.
- Emit a contact's namespaced tags, split into per-namespace cookies (`namespace/tag` → cookie).
- Restrict which tag namespaces are stored via the Contact Tags allow-list.
- JSON-encode complex member fields (arrays/objects) before writing them to cookies.
- Provide Mailchimp-derived segmentation data to downstream personalisation tools.
- Combine with other enricher datasources on the same enricher endpoint.
- Diagnose lookup failures from the site's recent log messages (exceptions are warning-logged).
- Feed Mailchimp tags into front-end content targeting or A/B tests.
- Personalise a landing page based on which Mailchimp campaigns/segments a subscriber belongs to.
