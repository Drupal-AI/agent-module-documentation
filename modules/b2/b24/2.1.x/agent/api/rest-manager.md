<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# b24 — RestManager / ReferenceManager API, events & hooks

## `b24.rest_manager` — `Drupal\b24\Service\RestManager`

The REST client for the Bitrix24 `crm.*` API. Reads config `b24.settings`/`b24.default_settings`
and tokens from `state`. All methods are no-ops returning `FALSE`/`[]` when no `site` is configured.

Low-level:
- `get($method, array $params = [])` — POSTs `form_params` (with `auth` = current access token) to
  `https://<site>/rest/<method>/`; calls `refreshAccessToken()` first, then reads the token; decodes
  JSON; logs `ClientException` `error_description` and returns `FALSE` on error.
- `getAuthorizeUri(): string` — see [../config/credentials.md](../config/credentials.md) (issues the
  OAuth state token).
- `refreshAccessToken()` — refresh-token grant against `https://<site>/oauth/token/`; skips when the
  stored token has >1800s left; stores new `b24_access_token`/`b24_refresh_token`/`b24_token_expires`.

Entity operations (thin wrappers over `crm.<entity>.<op>`):
- `addEntity($name, $fields, $params)` — invokes `hook_b24_push_alter($fields, {op:insert, entity_name})`,
  sets `ASSIGNED_BY_ID` from the configured assignee, calls `crm.<name>.add`, on success invokes
  `hook_b24_<name>_insert`, logs a deep link, and dispatches `B24Event::ENTITY_INSERT`. Returns the
  new external id or `FALSE`.
- `updateEntity($name, $id, $fields, $params)` — alter hook (`op:update`) + `crm.<name>.update` +
  `B24Event::ENTITY_UPDATE`.
- `deleteEntity($id, $name, $external = FALSE)` — `crm.<name>.delete` + `B24Event::ENTITY_DELETE`;
  with `$external` it first resolves the id from Bitrix24 via `getId()`.
- Lead: `addLead($fields, $params)` (defaults `SOURCE_ID=WEB`, `OPENED=Y`, and sets `CONTACT_ID`
  from the current user's mapped contact), `updateLead`, `getLead`.
- Deal: `addDeal`, `updateDeal`, `getDeal`. Contact: `addContact`, `updateContact`,
  `deleteContact` (also clears the reference), `getContact`. Product: `deleteProduct`.
- `getFields($entity)` — `crm.<entity>.fields` (used to build mapping forms).
- `getList($entity, $params)` — `crm.<entity>.list` with recursive pagination via `next`.
- `getId($drupalId, $entity)` — looks up a Bitrix24 id by `XML_ID` filter.
- `setLeadProducts($id, $items)` / `setDealProducts` / `setProductRows` — `crm.<entity>.productrows.set`.
- CRM mode: `retrieveCrmMode()` (`crm.settings.mode.get`), `setCrmMode()` (persists to
  `b24.default_settings.crm_mode`), `getCrmMode(): int`.

Default `$params` on lead/deal/contact ops is `['REGISTER_SONET_EVENT' => 'Y']`.

## `b24.reference_manager` — `Drupal\b24\Service\ReferenceManager`

CRUD over the `b24_reference` table (all via the DB query builder, no raw SQL):
- `getReference(EntityInterface $entity, string $extType)` → `['ext_id','hash']` for a bundle.
- `addReference($entityId, $entityType, $extId, $extType, $hash = '')`.
- `deleteReference($extType, $id, ?$type = NULL)` → affected rows.
- `updateHash($entity, $extType, $hash)`; `getHash(array $fields)` → `Crypt::hashBase64(serialize())`.
- `getExistingEntities($extType, $bundle)` → `[entity_id => ext_id]`.

Submodules use `getHash()`/the stored `hash` to skip Bitrix24 updates when mapped values are
unchanged.

## `b24.form_helper` — `Drupal\b24\Service\FormHelper`

- `getMappingFields(&$form, $b24Entity, Config $config)` — adds a textfield/textarea per writable
  string/`crm_multifield`/double Bitrix24 field.
- `getMappingSelects(&$form, ?$config, $elements, $parentElement, $extraTokens)` — adds a select
  (Drupal element → Bitrix24 field) plus a `<field>_custom` textarea with a `token_tree_link`;
  filters out `webform_actions`/`uuid`/`language`/`entity_reference` element types.

## Events — `Drupal\b24\Event\B24Event`

Constants `ENTITY_INSERT = 'b24.entity.insert'`, `ENTITY_UPDATE = 'b24.entity.update'`,
`ENTITY_DELETE = 'b24.entity.delete'`. Accessors `getName()`, `getOperationName()`, `getResponse()`.

## Hooks (`b24.api.php`)

- `hook_b24_push_alter(array &$fields, array $context)` — alter fields before an add/update;
  `$context` has `op` and `entity_name`. (b24_utm implements this to inject UTM marks.)
- Dynamic `hook_b24_<entity>_<op>_insert` invoked via `moduleHandler->invokeAll()` after an add.
