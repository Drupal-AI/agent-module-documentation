<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `eudonet` service and request flow

Class `Drupal\eudonet\Eudonet` (`src/Eudonet.php`), registered as service **`eudonet`**
(`eudonet.services.yml`) with args `@plugin.manager.eudonet_query`, `@config.factory`. It is a
thin factory of query plugins plus a few static helpers. Get it with
`\Drupal::service('eudonet')` or inject `@eudonet`.

## Shorthand factory methods

Each returns a configured **EudonetQuery** plugin (not yet executed) unless noted:

- `authenticate()` → runs `getAuthenticationQuery()->execute()`, returns an
  `AuthenticationQueryResult`.
- `getAuthenticationQuery($subscriber_login='', $subscriber_password='', $base_name='', $user_login='', $user_password='', $language='', $product_name='')`
  → `AuthenticationQuery`. Any empty arg falls back to the matching value in the
  `authentication` config mapping. Maps to CRM param names `SubscriberLogin`,
  `SubscriberPassword`, `BaseName`, `UserLogin`, `UserPassword`, `UserLang`, `ProductName`. If
  the stored config is partially filled and fewer than 7 args are passed, a warning message is
  shown ("Authentication probably fail due to a missing authentication parameter.").
- `catalog($additional_path)` → `CatalogQuery`. `$additional_path` = a catalog DescId (int) or
  the string `Users`.
- `metaInfos($table_list = TRUE)` → `MetaInfosQuery`.
- `search($additional_path)` → `SearchQuery`. `$additional_path` = tabId, `tabId/fileId`,
  `Fast/tabId`, or `PlanningOccupied`.
- `attachment($file_id, $tab_id, $filename, $content, $is_url = FALSE)` → `AttachmentsQuery`.
  `$content` is a base64 string (or a URL when `$is_url` is TRUE).
- `cud($additional_path = '')` → `CUDQuery`. Convenience wrappers:
  `cudCreate($tabId)` → path `{tabId}`; `cudUpdate($tabId,$fileId)` → `{tabId}/{fileId}`;
  `cudUpdateImage($tabId,$fileId,$filename)` → `Image/{tabId}/{fileId}/{filename}`;
  `cudDelete($tabId,$fileId)` → `Delete/{tabId}/{fileId}`.

## Config accessors & constants

- `getGlobalSettings()` → immutable `eudonet.eudonetconfig`; `getEditableGlobalSettings()` →
  editable version. `EUDONET_CONFIG = 'eudonet.eudonetconfig'`.
- `OPERATORS` (`=`,`<`,`<=`,`>`,`>=`,`!=`,`^`,`$`,`IN`,`CONTAINS`,`EMPTY`,`TRUE`,`FALSE`,`!^`,
  `!$`,`NOT IN`,`NOT CONTAINS`,`NOT EMPTY` → 0–17), `INTER_OPERATORS`
  (`None`=0,`AND`=1,`OR`=2,`EXCEPT`=3), `TOKEN_ERRORS` = `[100,101,102,103,104]`.

## Static helpers

- `Eudonet::trim($string)` — trim incl. non-breaking space.
- `Eudonet::cleanString($string)` — `str_replace` HTML entities (`&#039;`,`&amp;`,`&quot;`) →
  `'`,`&`,`"`, then `Xss::filter()`, then `trim()`. Use on CRM-returned text.
- `Eudonet::prepareFileForUpload(UploadedFile $file)` — returns base64 of the file contents for
  `attachment()`.

## Execution & token handling (`EudonetQueryBase::execute()`)

1. Reads `base_url` from config → Guzzle client via
   `httpClientFactory->fromOptions(['base_uri' => $base_url])`.
2. For a POST query, the plugin's `build()` array is sent as `json` with `timeout => 0`.
3. If `authentication = TRUE` in the plugin annotation: reads cached `token_info`; if `token` is
   empty **or** `expiration` is empty/within `+2 hours`, calls `authenticate()` to refresh it.
   The token is sent as the request header **`x-auth`**. An empty token logs an error via
   `logger('eudonet')`.
4. Sends `getMethod()` `getPath()`, hands the Guzzle `$response` to the plugin's `query_result`
   plugin (with the active `mapping` id) and returns that result object.

`AuthenticationQueryResult::__construct()` writes the refreshed `token_info`
(`ExpirationDate`, `ServerDate`, `Token`) back into `eudonet.eudonetconfig`.

## Minimal usage

```php
$eudonet = \Drupal::service('eudonet');
$query = $eudonet->search(200);
$query->addFields(['last_name', 'first_name', 'gender']);
$query->condition('gender', 'Masculin');
$or = $query->orGroup();
$or->condition('last_name', 'XE', '^');
$or->condition('last_name', 'A.M.B.', '^');
$query->conditionGroup($or);
$result = $query->execute();            // SearchQueryResult (Iterator)
foreach ($result as $item) {            // EudonetSearchQueryResultItemWrapper
  $fid = $item->id();                   // FileId
  $last = $item->last_name->Value ?? '';
}
```

See [queries.md](queries.md) for the full plugin catalogue and
[../config/settings.md](../config/settings.md) for connection setup.
