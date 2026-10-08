<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Wikiloc makes Wikiloc trails and waypoints available as a Drupal field, embedding the interactive map from the Wikiloc service.

---

It defines a field type (`MapItem`), a widget (`MapWidget`) for entering the Wikiloc embed URL and dimensions, and a formatter (`WikiLocFormatter`) that renders a themed `wikiloc_map_field` template — an `<iframe>` pointing at the stored URL with configured width/height. Content editors add the field to a content type and paste the Wikiloc embed reference; visitors then see the trail map inline.

Operationally it is a display field with no routes, permissions, services, or external server-side calls (the browser loads the Wikiloc iframe). The iframe `src` comes from the field value entered by editors with field-edit access; as with any embed field, restrict who can populate it since the URL is rendered into an iframe src.
---
- Add a Wikiloc field to a content type
- Embed a Wikiloc trail on a node
- Show waypoints from Wikiloc inline
- Configure iframe width and height
- Paste a Wikiloc embed URL in the widget
- Display an interactive trail map to visitors
- Use for hiking/cycling route pages
- Combine with other geospatial fields
- Render the map via the wikiloc_map_field template
- Override the template in a theme for custom markup
- Provide trail context on event or location content
- Reuse the field across multiple content types
- Keep map embedding declarative via a field
- Set responsive iframe dimensions per display
- Add multiple trail fields to one content type
- Show a trail map on a landing page
- Document a route with an embedded Wikiloc map
