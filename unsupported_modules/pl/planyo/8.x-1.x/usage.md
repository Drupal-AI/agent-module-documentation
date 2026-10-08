<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Planyo Reservation System embeds the Planyo.com online reservation system.

---

Planyo Reservation System **embeds the Planyo.com** online reservation/booking service into Drupal — so a
site can offer Planyo's hosted reservation flow (availability, bookings, payments handled by Planyo) without
building booking logic in Drupal. You configure your Planyo site/API details and it renders the Planyo widget.
The project machine name is `planyo_reservation_system`; the module is `planyo`, in the Custom package.

Use it to add Planyo-hosted reservations. It is a third-party integration feature — the reservation logic and
any **payment** run on **Planyo's** side (server-authoritative there), and Drupal embeds the widget. Security
notes: handle any Planyo **API key** as a secret (env/Key module), use HTTPS, and understand booking/customer
data is processed by the external Planyo service (a data-processing/privacy consideration). It has no
access-control role. Configure the Planyo site and API details.

---

- Embed the Planyo reservation system.
- Offer Planyo-hosted bookings.
- Render the Planyo widget.
- Let Planyo handle availability/payments.
- Configure Planyo site/API details.
- Avoid building booking logic in Drupal.
- Handle the Planyo API key as a secret.
- Use HTTPS.
- Note booking/customer data is processed by Planyo.
- Have no access-control role.
- Configure the integration.
- Handle reservations.
- Embed bookings.
- Configure Planyo.
- Add reservations.
- Handle the widget.
- Configure the API.
- Embed the service.
- Handle booking integration.
- Provide reservations.
