<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
OpenAgenda integrates the OpenAgenda event-management platform with Drupal, importing and displaying events from an OpenAgenda agenda.

---

OpenAgenda integrates the OpenAgenda platform — a shared event-publishing/aggregation service — with
Drupal. It connects to an OpenAgenda agenda and surfaces its events in Drupal, so a site can display
events managed in OpenAgenda (listings, single event pages, filtering) without maintaining them
separately as local content. It depends on core Node, Field and Serialization, is configured at
`openagenda.form`, and includes interface-translation support.

Use it where events are curated in OpenAgenda (common for cultural/municipal sites in its ecosystem)
and should appear on the Drupal site. Configuration includes the OpenAgenda API key/agenda identifier —
store the API key as a secret. It provides its own permissions. It is a content-integration/display
module; event data comes from the external OpenAgenda service, so display availability depends on that
service and its API.

---

- Display OpenAgenda events in Drupal.
- Import events from an OpenAgenda agenda.
- Show event listings and single pages.
- Filter OpenAgenda events.
- Connect to the OpenAgenda service.
- Configure at openagenda.form.
- Store the OpenAgenda API key as a secret.
- Depend on node, field and serialization.
- Avoid maintaining events locally.
- Surface externally-curated events.
- Provide event permissions.
- Support interface translation.
- Serve cultural/municipal event sites.
- Display events from the platform.
- Handle the OpenAgenda API key securely.
- Depend on the external service for data.
- Present curated agendas.
- Integrate event management.
- Show event details on the site.
- Aggregate events via OpenAgenda.
