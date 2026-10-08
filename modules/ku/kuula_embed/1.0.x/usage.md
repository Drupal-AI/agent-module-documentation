<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Provides a `kuula_field` field type that embeds a Kuula 360° panorama viewer on entities.

---

Kuula hosts interactive 360° photos/virtual tours that are displayed through an iframe. This module adds a Field API triplet — field type (`kuula_field`, stores the embed URL plus a `use_css` flag), widget (`kuula_widget`), and formatter (`kuula_format`) — so a site builder can add a "Kuula Embed" field to any content type and render it. The formatter emits an `<iframe>` with `allowfullscreen` and the `xr-spatial-tracking; gyroscope; accelerometer` permissions, sized either at a fixed 100%×640 or via a CSS class (`ku_embed`) when `use_css` is set.

Setup is entirely through Manage fields: add a Kuula Embed field, paste the Kuula share/embed URL per entity, and choose the display. The embed URL is author-supplied and rendered into the iframe `src`, so restrict field-edit access to trusted editors as you would any raw-embed field.

---

- Add a Kuula 360° panorama field to any content type or entity.
- Embed a virtual tour / 360° photo by pasting its Kuula share URL.
- Render the panorama in an iframe with fullscreen and motion-sensor permissions.
- Display the embed at a fixed 100%×640 size out of the box.
- Switch sizing to CSS control by enabling the `use_css` field setting (adds `ku_embed` class).
- Show multiple Kuula embeds from a multi-value field on one entity.
- Use the `kuula_widget` widget to enter/edit the embed URL in the entity form.
- Use the `kuula_format` formatter to output the panorama in a view display.
- Add the field to nodes, media, taxonomy terms, or any fieldable entity.
- Combine with view modes to show or hide the panorama per display.
- Place a Kuula panorama inside layout/paragraph structures via the field.
- Restrict who can edit the embed URL by controlling field-edit access.
- Style the embedded iframe via a theme using the `ku_embed` class.
- Provide immersive real-estate, event, or venue tours on content pages.
- Migrate/import Kuula URLs into the `kuula_field` value column.