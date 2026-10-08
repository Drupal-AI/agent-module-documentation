<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds a Packeta (Zásilkovna) shipping method to Drupal Commerce, letting customers pick a pickup point at checkout and submitting the packet to Packeta's API.

---
The module provides a `Packeta` shipping method plugin (`Plugin/Commerce/ShippingMethod/Packeta`) built on Commerce Shipping. At checkout it renders Packeta's pickup-point selector widget; the chosen pickup point id is stored on the shipment (`$shipment->getData('packeta_pickup_point')`). Gateway configuration holds the API password, e-shop identifier, and mappings such as which profile field carries the customer phone number.

`PacketaApiClient::submitShipmentToPacketa()` assembles the packet payload — recipient name/email/phone from the order's billing profile, order number, total/COD value, currency, weight (converted to kg), the pickup point id and e-shop id — and calls Packeta's SOAP endpoint `https://www.zasilkovna.cz/api/soap.wsdl` via PHP `SoapClient`, authenticating with the configured API password and returning the created packet id. SOAP faults are caught and logged to the `commerce_packeta` channel. The bundled `commerce_packeta_views` submodule adds helper views (e.g. a product-variation view with Views Bulk Edit to set weights).

Typical setup: enable the module and Commerce Shipping, add a Packeta shipping method with your API password and e-shop URL, map the phone field, ensure products have weights, and place the pickup-point widget in the checkout flow.
---
- Offer Packeta/Zásilkovna pickup-point delivery in checkout.
- Let customers choose a pickup point via the Packeta widget.
- Submit completed orders as packets to Packeta's API.
- Authenticate to Packeta with a configured API password.
- Send cash-on-delivery (COD) value for COD orders.
- Map a customer phone-number field for the packet payload.
- Convert product/shipment weight to kilograms for Packeta.
- Store the selected pickup-point id on the shipment.
- Identify the store to Packeta via the e-shop URL/id.
- Return and record the created Packeta packet id.
- Log Packeta SOAP faults for troubleshooting.
- Bulk-set product variation weights via the helper view (submodule).
- Combine with Commerce Shipping rate options at checkout.
- Populate recipient details from the order billing profile.
- Send order number and currency with each packet.
- Provide pickup-point delivery alongside other shipping methods.
- Configure per-shipping-method Packeta settings.
- Handle multi-currency orders (currency code sent to Packeta).
- Use the profile module's billing profile for recipient data.
- Prepare orders for Packeta label/packet generation.