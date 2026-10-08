# Address API service (`gsearch.address`)

Service id `gsearch.address` → `Drupal\gsearch\Services\Gsearch` (`src/Services/Gsearch.php`).
Autowired with `config.factory`, the core `http_client` (Guzzle), and a `gsearch` logger channel.
It is a thin client over the Dataforsyningen GSearch v2 API: each lookup queries both the
`adresse` and `husnummer` endpoints (`srid=4326` for WGS84 coords), merges + de-duplicates by
`visningstekst`, and natural-sorts by house number. The saved `token` is sent as a `token` header;
the base URL comes from `gsearch.settings.api_url` (default `Gsearch::$defaultApiUrl`). Errors are
caught, logged, and returned as an empty array.

Inject it (`#[Autowire(service: 'gsearch.address')] Gsearch $gsearch`) or
`\Drupal::service('gsearch.address')`.

## Public methods

| Method | Returns | Notes |
|---|---|---|
| `getAddresses(string $query, int $limit = 10, ?string $token = NULL): array` | `GsearchAddress[]` | Free-text search; keyed by `visningstekst`. |
| `getAddress(string $query, ?string $token = NULL): ?GsearchAddress` | one or NULL | First match (`limit 1`). |
| `getAddressById(string $id, ?string $search_query = NULL, ?string $token = NULL): ?GsearchAddress` | one or NULL | Needs `search_query`; adds a `"id"='…'` filter. Returns NULL if `search_query` empty. |
| `getFieldValue(string $input): array` | field value array | Resolves `$input` and builds a savable field array; throws `InvalidArgumentException` if nothing matches. |
| `getFieldValueById(string $id, ?string $search_query = NULL): array` | field value array | Same, by id + query; used by the widget on submit. |
| `getToken(): ?string` | token | From `gsearch.settings`. |
| `validateToken(string $token): bool` | bool | True if a lookup with `$token` returns a `GsearchAddress` (used by the settings form). |
| `static encodeSelect2Value(string $id, string $query): string` | string | base64url of `{"id","query"}`; falls back to `$id`. |
| `static decodeSelect2Value(string $value): ?array` | `{id,query}` or NULL | Inverse of the above; NULL on any malformed input. |

The field-value array returned by `getFieldValue*()` maps GSearch fields to the field columns:
`user_input`, `value` (`visningstekst`), `id`, `address`, `postal_code` (`postnummer`),
`postal_name` (`postnummernavn`), `country_code` (`'DK'`), `longitude`/`latitude` (from
`geometri.coordinates[0]`).

`GsearchAddress` (`src/GsearchAddress.php`) is a plain value object built from an API row with
public props: `id`, `kommunenavn`, `kommunekode`, `vejkode`, `vejnavn`, `husnummer`,
`etagebetegnelse?`, `doerbetegnelse?`, `supplerendebynavn?`, `postnummer`, `postnummernavn`,
`visningstekst`, `geometri`.

## Example

```php
/** @var \Drupal\gsearch\Services\Gsearch $gsearch */
$gsearch = \Drupal::service('gsearch.address');

// Suggestions (e.g. for a custom autocomplete):
$matches = $gsearch->getAddresses('Algade 1', 10);
foreach ($matches as $addr) {
  // $addr->visningstekst, $addr->postnummer, $addr->geometri['coordinates'][0] ...
}

// A savable field value (handy in custom migrations):
try {
  $values = $gsearch->getFieldValue('Rådhuspladsen 1, 1550 København');
  $node->set('field_address', $values)->save();
}
catch (\InvalidArgumentException $e) {
  // No Danish address matched the input.
}
```
