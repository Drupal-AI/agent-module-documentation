<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
A Commerce Shipping method plugin that connects Drupal Commerce to the EasyPost multi-carrier shipping API for live rates, label buying, tracking, and scheduled pickups.

---

The `easypost` shipping method (`ShippingMethodBase` subclass) implements the interfaces for remote shipments, importing shipping labels, tracking, and scheduling pickups. Its configuration form stores an EasyPost API key and a test/production mode, enabled carrier services, customs defaults (tax id, description, HS tariff, signer, incoterm), and options such as dropoff type, sender phone, insurance, and a rate multiplier. `EasyPostManager` wraps the official `EasyPost\EasyPostClient` SDK: `getRates()` fetches live rates, `buyShipment()`/`createEasyPostShipment()` create and buy labels, plus tracking, pickup rate lookup, scheduling and cancellation. Two checkout panes let customers supply a carrier account number and phone. An early order processor and shipment/label event subscribers wire the method into Commerce's order and label flows.

The API key is stored as a plain textfield in the shipping-method plugin configuration (Commerce config), the standard Commerce shipping-gateway pattern — it is not encrypted or held in a Key entity, so it is readable by anyone with permission to edit shipping methods. All EasyPost calls go through the official SDK over HTTPS; the module does not disable TLS verification and does not build any raw HTTP client. There are no routes, controllers, or webhooks in this module — label purchase, refunds and pickup scheduling are triggered from authenticated Commerce admin/fulfilment flows, so there is no anonymous callback surface. Setup is: add an EasyPost shipping method to a shipping-enabled store, paste the API key, set the mode, and enable the carrier services you offer.
---
- Offer live EasyPost shipping rates at checkout
- Connect a store to multiple carriers through one API key
- Buy a shipping label for a shipment from the admin UI
- Refund/void a purchased EasyPost label
- Show tracking information/URL for a shipment
- Toggle between EasyPost test and production mode
- Enable specific carrier services to present to customers
- Apply a rate multiplier or rounding to returned rates
- Collect a customer carrier account number via a checkout pane
- Collect a customer phone number via a checkout pane
- Configure customs info for international shipments
- Set default incoterm and dropoff type
- Provide a sender phone number for carrier requirements
- Add optional insurance to shipments
- Verify delivery address and ZIP+4 through EasyPost
- Import shipping labels into Commerce shipping label workflow
- Schedule a carrier pickup and pick a pickup rate
- Cancel a previously scheduled pickup
- Calculate rates only for supported/enabled services
- Round rate amounts using the Commerce price rounder
- Store per-store EasyPost credentials on the shipping method
- Integrate EasyPost with the commerce_shipping_label manager