ECA HubSpot adds 40 HubSpot CRM actions to ECA (Event–Condition–Action), letting you create, update, fetch, delete, search, associate, and inspect HubSpot contacts, companies, deals, leads, tickets, notes, tasks, and pipelines from Drupal workflows without writing code.

---

The module bridges Drupal's ECA visual workflow builder to the HubSpot CRM API. It ships a single `HubSpotService` wrapper around the official `hubspot/api-client` PHP SDK and exposes it through ECA action plugins (one class per operation, grouped under the "HubSpot" action category). Authentication and the API client are supplied entirely by the required `hubspot_api` module, so all actions transparently reuse the site's configured HubSpot Private App token or OAuth credentials — you configure credentials once at `/admin/config/services/hubspot-api` and never enter them per action. Every action supports ECA token replacement in its fields, dynamic values from earlier workflow steps, and an optional "Token name" output field that stores the API response (object id, properties, created/updated timestamps, associations) back into the ECA token environment for use in later steps. Create and update actions accept free-form YAML "Additional Properties" for custom HubSpot fields, and search actions accept YAML filter groups using HubSpot's operators (EQ, NEQ, LT/LTE/GT/GTE, CONTAINS_TOKEN, HAS_PROPERTY, IN, NOT_IN, etc.). Because everything is an ECA action, HubSpot operations can be triggered by any ECA event — form submissions, entity CRUD, cron, user registration, Webform submissions — and chained with conditions and other actions.

---

- Create or update a HubSpot contact automatically when a Drupal user registers, syncing name, email, phone, and lifecycle stage.
- Push Webform or contact-form submissions into HubSpot as new contacts with lifecycle stage set from form values.
- Look up an existing contact by email (auto-detected) before creating one, to avoid duplicates in a lead-capture flow.
- Search contacts by lifecycle stage, email domain, or custom property and iterate over the results in an ECA loop.
- Set or advance a contact's lifecycle stage (Subscriber, Lead, MQL, SQL, Opportunity, Customer, Evangelist) based on Drupal behavior or scores.
- Create a company record from a business-directory node and enrich it with domain, industry, and location.
- Fetch a company by domain (auto-detected) to link submissions to the right account.
- Create a sales deal from an e-commerce order, setting amount, pipeline, stage, and close date, and associate it with the buyer contact and company in one step.
- Update a deal's stage as an order moves through fulfillment (e.g. to "Closed Won").
- Create a HubSpot lead tied to a contact and company when a qualified inquiry arrives.
- Open a support ticket from a support-request form, setting subject, content, pipeline, stage, and priority, and link it to the reporting contact.
- Update ticket status or priority as a Drupal support workflow progresses.
- Log a note (with HTML content) on a contact, company, deal, or ticket to record an interaction or milestone.
- Create a follow-up task (TODO / EMAIL / CALL) with due date, priority, and owner, associated with the relevant CRM records.
- Assign onboarding tasks to account managers when a contact becomes a customer.
- Associate or disassociate any two CRM objects (contact, company, deal, lead, ticket, note, task) after the fact.
- Retrieve all objects of a given type associated with a record (e.g. every contact on a company) to drive further logic.
- List all pipelines and their stages for deals, tickets, leads, or custom objects to validate stage names in a workflow.
- Fetch a single pipeline by id to read its configuration and stage metadata.
- Search deals, tickets, notes, or tasks with YAML filter groups and store the total count plus matches in a token.
- Store any HubSpot API response in an ECA token and branch the workflow on returned property values.
- Set date/time fields (close dates, task due dates, note timestamps) from Drupal tokens, ISO 8601 strings, or Unix timestamps.
- Add custom or namespaced HubSpot properties on create/update via the YAML "Additional Properties" field.
- Archive (soft-delete) contacts, companies, deals, leads, tickets, notes, or tasks in HubSpot when the corresponding Drupal record is removed.
- Build bidirectional Drupal↔HubSpot synchronization flows entirely inside ECA models, with no custom module code.
