<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Ecomail connects Drupal to the Ecomail (ecomail.cz) email-marketing platform through a single service that wraps the official Ecomail PHP SDK.

---

Ecomail is a low-level integration module: it exposes the Ecomail REST API v2 to other Drupal code via one service, `ecomail.client` (`Drupal\ecomail\EcomailClientWrapper`), which wraps the bundled `ecomailcz/ecomail` PHP SDK. Through that service a site can manage subscriber lists, add and update contacts, send and track campaigns, run marketing automations, manage templates and sending domains, send transactional e-mails, record e-commerce transactions, refresh product/data feeds, track events, search contacts and import or delete discount coupons. Authentication uses a single Ecomail API key stored as a Key entity (Key module) and selected on the settings form at `/admin/config/services/ecomail`. The module ships no subscribe blocks, forms, fields, hooks or Drush commands of its own — it is a building block that other custom or contrib modules call to add user-facing behaviour (for example wiring a webform or user-registration hook to `addSubscriber()`).

---

- Store the Ecomail API key securely as a Key entity and select it on the module's settings form.
- Obtain a shared `ecomail.client` service in custom code via dependency injection or `\Drupal::service('ecomail.client')`.
- List all subscriber list collections in the Ecomail account (`getListsCollection()`).
- Create a new subscriber list (`addListCollection()`).
- Show or update the details of a single list (`showList()`, `updateList()`).
- Add a subscriber to a list from a webform or registration handler (`addSubscriber()`).
- Bulk-import many subscribers into a list at once (`addSubscriberBulk()`).
- Update an existing subscriber's data on a list (`updateSubscriber()`).
- Remove a subscriber from a list or delete them from the account entirely (`removeSubscriber()`, `deleteSubscriber()`).
- Look up a subscriber by list + e-mail, by e-mail globally, or list all their lists (`getSubscriber()`, `getSubscriberByEmail()`, `getSubscriberList()`).
- Retrieve all subscribers of a given list (`getSubscribers()`).
- List, create, update and send e-mail campaigns (`listCampaigns()`, `addCampaign()`, `updateCampaign()`, `sendCampaign()`).
- Read campaign statistics, including detailed per-campaign stats (`getCampaignStats()`, `getCampaignStatsDetail()`).
- List marketing automations and trigger an automation for a contact (`listAutomations()`, `triggerAutomation()`).
- Read automation/pipeline statistics (`getPipelineStats()`, `getPipelineStatsDetail()`).
- Create reusable e-mail templates (`createTemplate()`).
- List, create and delete sending domains for the account (`listDomains()`, `createDomain()`, `deleteDomain()`).
- Send one-off transactional e-mails or transactional-template e-mails (`sendTransactionalEmail()`, `sendTransactionalTemplate()`).
- Read transactional and double-opt-in sending statistics (`getTransactionalStats()`, `getTransactionalStatsDoi()`).
- Record e-commerce transactions individually or in bulk, and update or delete them (`createNewTransaction()`, `createBulkTransactions()`, `updateTransaction()`, `deleteTransaction()`).
- Refresh a product feed or data feed on demand (`refreshProductFeed()`, `refreshDataFeed()`).
- Send custom tracking events for a contact (`addEvent()`).
- Search for a contact by query string (`search()`).
- Import or delete discount coupons in bulk (`importCoupons()`, `deleteCoupons()`).
