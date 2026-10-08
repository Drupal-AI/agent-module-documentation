<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform Booking Price Element — agent index

Adds one Webform element, `webform_booking_price_element` ("Booking Extra Items"): a title + price line
item for booking forms. No permissions/routes/config of its own; prices feed the parent's server-side
`BookingPrice`. Depends on `webform` + `webform_booking`.

- **The element plugin** → [plugins/price_element.md](plugins/price_element.md)

Parent module docs: [../../../../1.2.x/agent/start.md](../../../../1.2.x/agent/start.md)
