<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Shipping Labels provides an API for generating shipping labels with Commerce Shipping.

---

Commerce Shipping Labels provides an API for generating shipping labels within Drupal Commerce Shipping —
a framework for producing printable shipping labels for orders (including a `commerce_shipping_label_zebra`
submodule for Zebra label printers). It depends on Commerce Shipping, in the Commerce (shipping) package.

Use it to generate shipping labels for Commerce orders. It is an e-commerce/fulfillment feature. Where label
generation involves a carrier's API (rates/labels), the carrier plugin holds those **API credentials** and
makes the HTTPS calls — this module itself only orchestrates and stores results. Its label/pickup routes
require **`commerce_shipment` update access** on the specific shipment, and generated label files are stored
in Drupal's **private** file stream (served through the access-checked private-file download path). The module
defines no permissions of its own and has no configuration page; label behaviour is configured on the carrier
module you pair it with, plus the optional Zebra printer submodule.

---

- Generate shipping labels.
- Provide a label-generation API.
- Support Zebra label printers.
- Depend on Commerce Shipping.
- Produce printable labels for orders.
- Gate label/pickup routes by commerce_shipment update access.
- Store label files in the private file stream.
- Define no permissions of its own.
- Configure label generation.
- Print shipping labels.
- Handle fulfillment labels.
- Generate order labels.
- Configure the printer integration.
- Produce labels.
- Handle shipping labels.
- Configure labels.
- Generate labels.
- Print labels.
- Handle label API.
