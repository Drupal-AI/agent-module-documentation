<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Shipping Pickup API provides a shipping method API for pickup points and parcel machines.

---

Commerce Shipping Pickup API provides a framework/API for pickup-point and parcel-machine shipping
methods in Drupal Commerce — so carriers offering locker/pickup delivery can be integrated, letting customers
choose a pickup location at checkout. It ships demo and in-store submodules and depends on Drupal Commerce
(`commerce`, `commerce_checkout`, `commerce_shipping`) and Profile (`profile`), in the Commerce (contrib)
package.

Use it as the base for pickup-point shipping integrations. It is an e-commerce/shipping API. Where a specific
carrier's pickup API is used, store any **carrier credentials as secrets** and operate over HTTPS; the chosen
pickup location becomes part of the order (address data). It has no access-control role. Configure the pickup
shipping methods.

---

- Provide a pickup-point shipping API.
- Support parcel machines/lockers.
- Let customers choose a pickup location.
- Depend on Drupal Commerce.
- Ship demo/store submodules.
- Integrate locker/pickup carriers.
- Store carrier credentials as secrets.
- Operate over HTTPS.
- Have no access-control role.
- Configure pickup shipping methods.
- Handle pickup delivery.
- Provide the shipping framework.
- Support pickup points.
- Configure pickup methods.
- Handle parcel machines.
- Integrate pickup carriers.
- Provide pickup API.
- Handle lockers.
- Configure shipping.
- Support pickup shipping.
