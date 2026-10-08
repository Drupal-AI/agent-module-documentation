<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ActiveTickets client service — inject and call

Everything lives in `Drupal\activetickets_client\Client\ActiveTicketsClient` (interface
`ActiveTicketsClientInterface`, both in `src/Client/`). It is a plain service, not a plugin/entity.

## Install / enable

- `drush en activetickets_client`. Needs the **ext-soap** PHP extension (constructor throws
  `\Exception('Error during initialization SOAP object.')` if the WSDL can't be loaded).
- Configure WSDL URLs + token first (see [../config/settings.md](../config/settings.md)); with unset
  config the `\SoapClient(null)` call fails at construction, so the service is unusable until configured.

## The two services (`activetickets_client.services.yml`)

- `activetickets_client.client` — args `['@logger.factory', '@config.factory', '@cache.default']`; uses
  the public `wsdl_url`.
- `activetickets_client.member_client` — same plus a literal `'true'` 4th arg → constructor
  `$memberClient = TRUE` → `initSoapClient()` swaps in `wsdl_member_url`. Member methods
  (`setVisitorNew`, `createVisitorIfNotExistsAndGetLoginKey`) build params via `getMemberRequestParams()`
  (`ClientName`/`LanguageCode`) vs the public `getRequestParams()` (`Clientname`/`LanguageCode`).

Inject by id, e.g. constructor arg `@activetickets_client.client`, or (discouraged)
`ActiveTicketsClient::create()` which pulls the same deps from `\Drupal` with `$memberClient = FALSE`.

## How a call works

- Constructor: `$this->logger = loggerFactory->get('activetickets_client')`, `$this->config =
  configFactory->get('activetickets_client.settings')`, stores the cache backend, then `initSoapClient()`.
- `initSoapClient(bool $memberClient=FALSE)`: reads `wsdl_url` (or `wsdl_member_url`) and `token`, builds
  `\SoapClient($wsdl, ['exceptions'=>0, 'trace'=>1, 'stream_context'=>stream_context_create(['http'=>
  ['header'=>'x-api-key: '.$token]])])`. On `\SoapFault` it logs the message and throws.
- `getRequestParams()` returns `['Clientname'=>client_name, 'LanguageCode'=>langcode]`; most methods start
  from this array and `+=` their own params, then call `get()` or `set()`.
- `get(array $params, string $method)`: `$this->soapClient->{$method}($params)`, then
  `parseXmlResult($response->{$method.'Result'})`. On `\SoapFault` logs and returns `[]`.
- `parseXmlResult(string $xml)`: `simplexml_load_string()` under `libxml_use_internal_errors(TRUE)`; on
  parse failure returns `['error'=>$xml_string]`; otherwise each child node is `json_encode`/`json_decode`
  round-tripped into `['result'=>[...assoc arrays...]]`.
- `set(array $params, string $method)`: same dispatch; when the `<method>Result` string is `'True'`
  returns `['result'=>TRUE]`, else tries to parse it as XML (`['error'=>...]` on failure). `\SoapFault` →
  `['error'=>message]` + log.
- `DATEFORMAT = 'Y-m-d\TH:i:s'` — every `\DateTime` argument is `->format(self::DATEFORMAT)`d (birth dates
  use `'Y-m-d'`).

## Method groups (all return `array`)

- **Programs / events:** `getProgramList`, `getProgramListBig`, `getProgramListLight`,
  `getProgramListWithCapacities`, `getProgramListWithCapacitiesAndSold`, `getProgramListWithCustomKey`,
  `getProgramListWithCustomKeyIffr`, `getProgramDeletedAndinActives`, `getProgramCapacitiesByRang`,
  `getProgramDetail`, `getProgramStatus`, `getProgramConfirmed`, `getProgramPresale`,
  `getProgramKijkwijzer` (last two need ActiveTickets-side permission per the interface docblocks).
- **Taxonomy of content:** `getGenreList`, `getSubGenreList`, `getLocationList`,
  `getCharacteristicsList`, `getProgramIdsViaSubgenresList`, `getSubgenresViaProgramList`.
- **Caching:** `getCachedProgramList($from,$to,$genreId)` — cache id
  `activetickets_client:programlist:<genreId>` in `cache.default`; permanent, no cache tags/expiry, so you
  must clear it yourself when data changes.
- **Visitors (read):** `getVisitor`, `getVisitorBig`, `getVisitorByEmail(2/Big)`,
  `getVisitorByCredentials(2)` (email + password), `getVisitors`, `getVisitorsLight`,
  `getVisitorsWithin{Modification,Creation}Period(2)`, `getVisitorsLightWithinCreationPeriod(2)`,
  `getVisitorOrderHistory`, `getAllVisitorIdsWhoOrderedLast48Hrs`,
  `getAllVisitorIdsWhoOrderedLastnMinutes` (minutes clamped to ≤1440), `getVisitorCharacteristicsList`,
  `getCharacteristicsForVisitorList`, `getVisitorInterestsList`, `getVisitorPassesList`, `getPassList`.
- **Visitors (write, via `set()`):** `setVisitorNew`, `setVisitorNewGender`, `setVisitorUpdate`,
  `setVisitorUpdateGender`, `setVisitorDelete`, `setVisitorNewsLetterByEmail`, `addInterestToVisitor`,
  `removeInterestsFromVisitor`, `saveCharacteristicToVisitor`, `removeCharacteristicsFromVisitor`,
  `getVisitorWebserviceLoginKey`, `getVisitorWebserviceLoginKeyByEmail`,
  `createVisitorIfNotExistsAndGetLoginKey`.
- **Routes:** `getRouteList`, `getRoutesWithShowsList`.
- **Not implemented (return `[]`):** `eventAndShowsImport`, `savePassToVisitor`, `removePassFromVisitor`.

## Caveats grounded in source

- With `exceptions=>0` the SOAP client returns `\SoapFault` objects; the wrapper catches them and returns
  `[]` (get) or `['error'=>…]` (set) — callers should treat an empty array as "call failed", not "no
  results". Read `['error']`/`['result']` keys rather than assuming shape.
- `createVisitorIfNotExistsAndGetLoginKey()` sends a **hardcoded `'password'=>'test'`** to the member
  service — the created account is not given a real password by this method.
- The service is stateful/eager: constructing it performs a network WSDL fetch, so it fails fast if
  ActiveTickets is unreachable or config is empty.
