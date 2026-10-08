<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Ecomail — the `ecomail.client` service (EcomailClientWrapper)

## Service definition

- `ecomail.services.yml` defines service **`ecomail.client`** = `Drupal\ecomail\EcomailClientWrapper`,
  implementing `EcomailClientWrapperInterface`. Constructor args: `@config.factory`,
  `@key.repository`, `@logger.factory`.
- Get it via DI (constructor-inject `ecomail.client`) or `\Drupal::service('ecomail.client')`.

## Construction & authentication

- The constructor stores `config->get('ecomail.settings')`, the `KeyRepositoryInterface` and the
  logger factory, then immediately does `new \Ecomail($this->getApiKey())` — i.e. it builds the SDK
  client (class `\Ecomail` from `ecomailcz/ecomail`) at instantiation time.
- `getApiKey()` (protected) reads the Key entity name from `ecomail.settings:api_key`, then returns
  `keyRepository->getKey($key_name)->getKeyValue()`. If no key is configured, `getKey()` can return
  null and the `->getKeyValue()` call will error — configure a valid Key before using the service.
- The SDK sends requests to `https://api2.ecomailapp.cz` (Ecomail REST API v2).

## Response handling

- Every public method delegates to the matching `\Ecomail` method and passes the result through
  `processResponse()`: returns arrays/objects as-is; JSON-decodes strings (`Json::decode`); on an
  undecodable/empty response it logs `Response from API: <json>` to the `ecomail` logger channel and
  returns `NULL`. Callers should handle a `NULL` return as failure.

## API surface (methods, all thin wrappers over the SDK)

Lists
- `getListsCollection()`, `addListCollection(array $data)`, `showList($list_id)`,
  `updateList($list_id, array $data)`.

Subscribers
- `getSubscribers($list_id)`, `getSubscriber($list_id, $email)`, `getSubscriberList($email)`,
  `getSubscriberByEmail($email)`.
- `addSubscriber($list_id, array $data)`, `addSubscriberBulk($list_id, array $data)`,
  `updateSubscriber($list_id, array $data)`, `removeSubscriber($list_id, array $data)`,
  `deleteSubscriber($email)`.

Campaigns
- `listCampaigns($filters = NULL)` (note: the `$filters` arg is accepted but **not** forwarded to the
  SDK call), `addCampaign(array $data)`, `updateCampaign($campaign_id, array $data)`,
  `sendCampaign($campaign_id)`, `getCampaignStats($campaign_id)`,
  `getCampaignStatsDetail($campaignId, $queryParams = [])` (`$queryParams` also not forwarded).

Automations / pipelines
- `listAutomations()`, `triggerAutomation($automation_id, array $data)`, `getPipelineStats($pipelineId)`,
  `getPipelineStatsDetail($pipelineId, $queryParams = [])` (`$queryParams` not forwarded).

Templates & domains
- `createTemplate(array $data)`, `listDomains()`, `createDomain(array $data)`, `deleteDomain($id)`.

Transactional e-mail & stats
- `sendTransactionalEmail(array $data)`, `sendTransactionalTemplate(array $data)`,
  `getTransactionalStats()`, `getTransactionalStatsDoi()` (calls SDK `getTransactionalStatsDOI()`).

E-commerce transactions
- `createNewTransaction(array $data)`, `createBulkTransactions(array $data)`,
  `updateTransaction($transaction_id, array $data)`, `deleteTransaction($transaction_id)`.

Feeds, events, search, coupons
- `refreshProductFeed($feedId)`, `refreshDataFeed($feedId)`, `addEvent(array $data)`,
  `search($query)`, `importCoupons(array $data)`, `deleteCoupons(array $data)`.

## Usage pattern

- The module ships no forms/blocks/hooks that call these methods — it is a building block. A typical
  integration injects `ecomail.client` into a webform handler, `hook_user_insert()`, or an
  EventSubscriber and calls e.g. `addSubscriber($list_id, ['email' => $mail, 'name' => $name])` on
  registration. `$data` shapes follow the Ecomail REST API v2 (the interface docblocks in
  `EcomailClientWrapperInterface` link each apiary reference).
