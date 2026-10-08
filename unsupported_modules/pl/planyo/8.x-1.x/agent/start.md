<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Planyo Reservation System — agent index

**Embeds the Planyo.com online reservation system** into Drupal (Planyo hosts availability/bookings/payments;
Drupal renders the widget). Project `planyo_reservation_system`, module `planyo`. Version **8.x-1.6**. Core
`^8||^9||^10||^11`.

Third-party integration — reservation logic and **payment run on Planyo** (server-authoritative there). Handle
the Planyo **API key** as a secret, HTTPS; booking/customer data processed externally (privacy). No access
role.
