<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
A developers-only client module that connects Drupal to the Epsilon Agility Harmony marketing/customer-data platform through a single service with pre-defined API methods.

---

Epsilon Harmony provides the plumbing to call Epsilon's Harmony REST APIs from Drupal. After you enter your Harmony account credentials (client ID, secret key, username, password, X-OUID) and pick a region on the admin configuration forms, your custom code calls the `epsilon_harmony.api_service` service to create, update, delete, retrieve and list customer profile records, and to send real-time messages (RTM) using message identifiers you map to Epsilon-issued message IDs. The service handles OAuth2 token acquisition and caching transparently, and every request/response is written to an `epsilon_harmony_log` content entity so you can inspect exactly what was sent and returned. It depends on core Views and supports Drupal 8 through 11.

---

- Push new customer profile records from Drupal into Epsilon Harmony (`createRecord()`).
- Update existing Harmony profile records keyed by CustomerKey (`updateRecord()`).
- Delete a Harmony profile record by CustomerKey (`deleteRecord()`).
- Retrieve a single Harmony profile record by CustomerKey (`retrieveRecord()`).
- Add a record to a named Epsilon list (`createListRecord()`).
- Update a record within a named Epsilon list (`updateListRecord()`).
- Trigger a real-time transactional email/message via a Harmony message template (`sendMessage()`).
- Sync Drupal user registrations or profile edits into an Epsilon CRM audience.
- Enroll newsletter or campaign sign-ups into a specific Epsilon list.
- Send order confirmation or welcome emails through Epsilon RTM instead of Drupal mail.
- Map several friendly list identifiers to Epsilon list IDs so editors reference them by name.
- Map several friendly message identifiers to Epsilon message IDs for reuse across code.
- Switch between the US and Canada (EU) Harmony API regions from configuration.
- Test the configured credentials with a live token call from the admin Test link.
- Audit and debug every Harmony API interaction through the on-site log listing.
- Clear accumulated debug logs from the admin UI when they are no longer needed.
- Batch-import customer data into Harmony from custom Drupal migration or cron code.
- Keep opt-out / preferred-channel flags in sync between Drupal and Epsilon.
- Build custom forms that write submissions straight into a Harmony profile or list.
- Integrate loyalty or membership data with Epsilon's marketing automation.
- Drive transactional messaging (password resets, receipts) through Epsilon templates.
- Restrict who can configure the integration or read its logs using dedicated permissions.
- Reuse a single cached OAuth2 access token across many API calls within its lifetime.
