Salesforce Web-to-Lead Webform Data Integration adds a Webform handler that POSTs webform submissions to a Salesforce.com Web-to-Lead endpoint, mapping webform fields to Salesforce campaign lead fields so form submissions create leads in your Salesforce org.

---

The module provides one Webform handler plugin, `sfweb2lead_post` ("Salesforce Web-to-Lead post"), which extends Webform's core `RemotePostWebformHandler`. You add it to any webform (Settings → Emails/Handlers → Add handler) and configure the Salesforce **Web-to-Lead URL** (e.g. `https://www.salesforce.com/servlet/servlet.WebToLead?encoding=UTF-8`) and your org's **OID** value. A "Webform to Salesforce mapping" table maps each webform element (including composite sub-elements) to one of the standard Salesforce campaign fields — `description`, `email`, `first_name`, `last_name`, `lead_source`, `phone` — and only mapped fields are sent. On a completed submission the handler assembles the payload (`oid` + mapped values, plus optional YAML "custom data" that can use tokens), then dispatches a `sfweb2lead_webform.submit` event so other modules can alter the data before it is posted; it posts `x-www-form-urlencoded` to the configured URL via the inherited remote-post machinery. Because it subclasses the core remote-post handler, it inherits that handler's behaviour: request/response logging, error handling, and a **debug** option that displays the posted submission on-screen. The module ships no config schema, permissions, or Drush commands of its own — configuration lives inside each webform's handler settings. Requires the Webform module. It is the standard way to feed Drupal webform leads into Salesforce without custom API code or storing Salesforce credentials (Web-to-Lead needs only the public OID, not an API secret).

---

- Send Drupal webform submissions to Salesforce as new leads.
- Capture marketing/contact-form leads directly into a Salesforce campaign.
- Map webform Name/Email/Phone fields to Salesforce lead fields.
- Populate a Salesforce `lead_source` value from a hidden or select webform element.
- Map a composite element's sub-field (e.g. address → phone) to a Salesforce field.
- Post leads to a specific Salesforce org via its OID.
- Add custom static or token-driven data to every Salesforce post (YAML custom data).
- Attach the handler to multiple different webforms feeding the same org.
- Use several handlers on one webform to post to more than one Salesforce endpoint.
- Alter or enrich the outgoing payload from a custom module via the submit event.
- Add UTM/campaign metadata to leads through the event subscriber before posting.
- Only send selected fields to Salesforce (unmapped fields are excluded).
- Debug integration by displaying the posted data on-screen during setup.
- Log Salesforce post requests/responses using the inherited remote-post handler.
- Replace brittle custom cURL-to-Salesforce code with a configured handler.
- Route sandbox vs production leads by changing the Web-to-Lead URL per environment.
- Feed newsletter/contact/quote-request forms into a shared lead pipeline.
- Integrate Salesforce without storing an API key or OAuth secret (Web-to-Lead uses the OID).
- Keep lead capture inside Webform's normal submission workflow (results still stored).
