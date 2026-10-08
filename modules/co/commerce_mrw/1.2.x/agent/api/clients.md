<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SAGEC clients, request builder & the alter event

## SAGEC client (`commerce_mrw.sagec_client`)

`src/SagecClient.php` implements `SagecClientInterface`. Constructor arg: `@http_client` (Guzzle).
Builds SOAP 1.1 envelopes by hand with `\XMLWriter` (no PHP `SoapClient`), posts them, and parses
responses with `simplexml_load_string()` under `libxml_use_internal_errors()`; the `mrw`
namespace (`http://www.mrw.es/`) is registered for XPath. 30s timeout. Every envelope carries a
SOAP `AuthInfo` header with the `SagecCredentials` fields
(`CodigoFranquicia`/`CodigoAbonado`/`CodigoDepartamento`/`UserName`/`Password`). Values are written
with `\XMLWriter::writeElement()`/`writeAttribute()`, which XML-escapes them; empty optional fields
are skipped by `writeOptional()`.

Methods (all throw subclasses of `SagecException`):

- `transmEnvio(SagecCredentials, TransmEnvioRequest): TransmEnvioResponse` — SOAP action
  `TransmEnvio`. Reads `Estado`, `Mensaje`, `NumeroSolicitud`, `NumeroEnvio`, `Url`. Throws
  `SagecResponseException` when `Estado === '0'` or no `NumeroEnvio`.
- `etiquetaEnvio(SagecCredentials, string $numero): EtiquetaEnvioResponse` — SOAP action
  `GetEtiquetaEnvio` (`TipoEtiquetaEnvio=0`, report margins). `EtiquetaFile` is base64-decoded
  (strict) into `pdfContent`; bad base64 → `SagecTransportException`.
- `cancelarEnvio(SagecCredentials, string $numero): CancelarEnvioResponse` — SOAP action
  `CancelarEnvio` (`NumeroEnvioOriginal`). `Estado === '0'` → `SagecResponseException`.

Exceptions (`src/Exception/`): `SagecException` (base `\RuntimeException`),
`SagecResponseException` (service rejected the request), `SagecTransportException` (unreachable /
invalid XML).

## TransmEnvio request (`src/Sagec/Request/`)

`TransmEnvioRequest` — public mutable fields for the `DatosEntrega` (delivery) + `DatosServicio`
(service) blocks plus an optional `?TransmEnvioPickup $recogida` (`DatosRecogida`). Empty strings
are omitted from the envelope. Notable service fields: `retorno` (`N`/`D`/`S`/`R`),
`codigoServicioRetorno` (return-leg service), `numeroBultos`, `peso` (kg, ceil, min 1).

`TransmEnvioRequestBuilder` (`commerce_mrw.transm_envio_request_builder`, args `@event_dispatcher`,
`@datetime.time`) maps the shipment's shipping-profile address → delivery fields
(`via`/`resto`/`codigoPostal`/`poblacion`/`codigoPais`/`nombre`), sets `fecha` (today, `d/m/Y`),
`referencia` (order number or order id), `codigoServicio` (from the plugin), `numeroBultos=1`, and
`peso` from the shipment weight converted to kg. Postal codes are normalized by
`Sagec\PostalCode::normalize()` (ES/AD → 5 digits zero-padded, PT → first 4, GI → `00010`).

## Alter event

`TransmEnvioRequestEvent` (`EVENT_NAME = 'commerce_mrw.transm_envio_request'`,
`src/Event/`) — dispatched by the builder after mapping, before the client serializes. Subscribers
use `getRequest()` / `getShipment()` to fill optional SAGEC fields (NIF, phone, COD, insurance),
attach a `TransmEnvioPickup` for return pickups, or set `retorno`/`codigoServicioRetorno` for
exchanges. Example:

```php
public function onTransmEnvioRequest(TransmEnvioRequestEvent $event): void {
  $request = $event->getRequest();
  $request->nif = '12345678Z';
  $request->telefono = '600123123';
  // Return pickup: collect at customer, deliver to store.
  $pickup = new TransmEnvioPickup();
  $pickup->via = 'Rua do Cliente 9';
  $pickup->codigoPostal = '4970';
  $pickup->poblacion = 'Arcos de Valdevez';
  $pickup->codigoPais = 'PT';
  $request->recogida = $pickup;
  // Exchange (delivery + simultaneous return leg):
  $request->retorno = 'S';
  $request->codigoServicioRetorno = '0205';
}
```

## Tracking client (`commerce_mrw.tracking_client`)

`src/TrackingClient.php` implements `TrackingClientInterface`; arg `@http_client`. SAGEC has no
status operation, so this hits MRW's separate **TrackingServices** WCF endpoint
(`SagecEnvironment::trackingEndpointUrl()`, namespace `http://tempuri.org/`, SOAP action
`ITrackingService/GetEnvios`) authenticating with the same SAGEC `username`/`password` as
`login`/`pass` in the body. 30s timeout, TLS via `http_client`.

`getEnvios(SagecCredentials, TrackingQuery): TrackingResult` — builds a query from
`TrackingQuery` (static `forShipmentNumber()` / `forClientReference()`, or set `filterType`,
`valueFrom`/`valueTo`, `dateFrom`/`dateTo`, `languageCode` ES/PT, `detailed`). Parses
`SeguimientoAbonado/Seguimiento` rows into `TrackingStatus[]` (via `local-name()` XPath, namespace-
agnostic) plus the `MensajeSeguimiento` message. `TrackingResult::lastStatus()` returns the newest
row; `TrackingStatus::isDelivered()` tests `estado === '00'`.

The module ships this client only — no cron, UI or workflow automation. A typical site integration
loads its in-transit MRW shipments, calls `getEnvios()`, and applies its own workflow transition:

```php
$method = $shipment->getShippingMethod()->getPlugin();
$query = TrackingQuery::forShipmentNumber($shipment->getTrackingCode());
$query->detailed = TRUE;
$result = \Drupal::service('commerce_mrw.tracking_client')
  ->getEnvios($method->getCredentials(), $query);
if ($result->lastStatus()?->isDelivered()) { /* your workflow */ }
```
