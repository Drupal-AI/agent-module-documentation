Derive and display an availability state (Coming Soon / Available / Unavailable) for an entity from the start and end values of a datetime_range field, via a Twig function or a Views field.

---

Date Range Availability is a small, presentation-only helper. It computes a state for a node by comparing the current time (from the `datetime.time` service) against the start (`value`) and end (`end_value`) of a datetime_range field you name. The result is an array `{ label, label_class }` where the label is one of "Coming Soon", "Available", or "Unavailable" and the class is a matching CSS hook (`soon-label`, `available-label`, `unavailable-label`). Two consumers expose it: a Twig function `node_availability(node, field_date)` for theme templates, and a global Views field handler labelled "Node Availability" (group "Custom Global - Node Availability") that you configure with the date field's machine name. The module depends on `datetime_range` and `views`, ships no config UI, no permissions, no schema, and stores nothing — the field machine name is its only input, supplied per call or per Views field. Unpublished (or missing) nodes always resolve to "Unavailable". Note the state logic only fires when the field has an end value; a start-only range yields an empty label. The module ships no CSS, so you style the returned classes yourself.

---

- Show an "Available / Unavailable / Coming Soon" badge on an event teaser from an event date field.
- Render a status pill on a product node using a sale/availability window field.
- Display resource-booking availability (rooms, equipment) computed from a reservation window.
- Add an availability column to an admin or public View of events without writing a custom field plugin.
- Drive conditional markup in a Twig template: show a "Book now" button only when the label is "Available".
- Style each state differently by targeting `soon-label`, `available-label`, and `unavailable-label` in your theme CSS.
- Surface a "Coming Soon" ribbon on nodes whose start date is in the future.
- Grey out or hide teasers whose availability window has already ended.
- Build a "What's on now" listing by adding the Views field and filtering the display on its label.
- Present course/session availability from a session date-range field in a catalogue View.
- Show ticket-sales-window status on an event page template.
- Indicate promotion validity ("Coming Soon" / "Available" / "Ended") from a campaign date range.
- Add an at-a-glance availability marker to card-based content listings.
- Reuse the same date field for both scheduling and an availability badge without duplicating logic.
- Compute availability inside a paragraph or block template that already has the node in scope.
- Provide an accessible text label (not just a colour) for each availability state.
- Combine with Views' own date filters to list only currently-available items while still labelling each.
- Gate a call-to-action in a node template on `state.label == 'Available'`.
- Display availability in a custom entity print/PDF template.
- Quickly prototype an availability display on an existing content type by adding a datetime_range field and the Views field or Twig call.
