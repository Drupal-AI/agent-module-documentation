# Leaflet More Markers — agent index

Adds a `map_marker` field (emoji / font-icon per entity) that Leaflet renders as a custom
DivIcon marker, with size / circle / offset / animation attributes. Requires **leaflet**
and **token**. No admin page (`configure` null), no permissions, no schema, no Drush.

- **Add the field, wire the Leaflet "Field (Html DivIcon)" template with tokens, the
  attribute vocabulary, icon-font loading, and anchor logic** → [configure/marker.md](configure/marker.md)

Key facts:
- Field type `map_marker` (properties `icon`, `classes`); widget `map_marker_widget`
  (with JS emoji picker `fgEmojiPicker`); formatter `map_marker_formatter`.
- No formatter of its own on the map — you use core/Leaflet's "Field (Html DivIcon)" icon
  option with an HTML template containing `[entity:field_map_marker:icon]` /
  `:classes` tokens; the element must carry `class="lmm-icon …"`.
- Hooks in `leaflet_more_markers.module` run `\Drupal::token()->replace()` on that HTML,
  lazy-attach the needed icon-font CSS (Bootstrap/Font Awesome/Line Awesome, from CDN),
  and compute `iconAnchor`/`popupAnchor` from size/`yoffset` classes.
- Font-icon CDN libraries are defined in `leaflet_more_markers.libraries.yml`.
