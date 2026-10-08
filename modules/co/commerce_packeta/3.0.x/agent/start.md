<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Packeta (commerce_packeta) — agent index

**Commerce Shipping method that adds Packeta/Zásilkovna pickup-point selection and submits packets to Packeta's SOAP API.**

- **Version:** 3.0.x
- **Core:** ^9 || ^10 || ^11
- **Dependencies:** commerce, commerce_checkout, commerce_shipping, profile
- **Submodule:** `commerce_packeta_views` (helper views, requires views_bulk_edit).
- **Plugin:** `Plugin/Commerce/ShippingMethod/Packeta`; pickup point stored via `$shipment->getData('packeta_pickup_point')`.
- **Service:** `commerce_packeta.packeta_api_client` (`PacketaApiClient::submitShipmentToPacketa()`) → PHP `SoapClient` to `https://www.zasilkovna.cz/api/soap.wsdl`, auth via configured `api_password`, returns packet id; SOAP faults logged.

**Security:** Outbound SOAP over HTTPS with PHP `SoapClient` (default certificate verification, not disabled); API password read from gateway config, not request input; no public/mutating endpoints of its own. No security findings.

See [configure/shipping.md](configure/shipping.md).