Leaflet More Markers lets each mapped entity carry its own emoji or font-icon marker (Bootstrap Icons, Font Awesome, Line Awesome) on Leaflet maps, with size, circle background, vertical-offset and animation options, instead of one uniform blue pin.

---

The module adds a `map_marker` field type (widget `map_marker_widget`, formatter `map_marker_formatter`) with two properties: `icon` (an emoji, single Unicode character, or a font-icon code) and `classes` (a free-text list of attributes/font-icon codes such as `large`, `center`, `circle-red`, `bi bi-shop`, `fas fa-bed`, `pulse`, `jump-5`). You add this field beside a Geofield on any entity, then in the Geofield's Leaflet formatter you set the *Map icon* to "Field (Html DivIcon)" with an HTML template that references the marker via tokens, e.g. `<div class="lmm-icon [node:field_map_marker:classes]">[node:field_map_marker:icon]</div>`. The module's hooks (`hook_entity_display_build_alter`, `hook_views_post_render`, `hook_leaflet_formatter_feature_alter`, `hook_leaflet_views_feature_alter`) run token replacement on that HTML, detect which icon font each marker needs, and lazy-attach only the required CSS library (Bootstrap Icons / Font Awesome / Line Awesome, loaded from CDN). `_leaflet_more_markers_feature_alter()` parses the `lmm-icon` element's classes to compute size-dependent `iconAnchor`/`popupAnchor` offsets so icons and popups line up correctly at any zoom. The widget provides a JS emoji picker (bundled `fgEmojiPicker`) for choosing the emoji. Requires the Leaflet and Token modules; it has no admin settings page, no permissions and no config of its own.

---

- Give each location on a Leaflet map its own emoji marker instead of a generic pin.
- Mark spots with a single plain character (e.g. "X") when an emoji isn't wanted.
- Use Bootstrap Icons, Font Awesome, or Line Awesome font glyphs as map markers.
- Set marker size per location: small, medium (default), or large.
- Wrap a marker icon in a coloured circle (`circle-black`, `circle-white`, `circle-red`).
- Adjust a marker's vertical baseline with `center`/`ground` or a `yoffset±N` class.
- Add playful marker animations (`pulse`, `jump`, `flip-1`, `rock`, `somersault`, `sky-drop`, …).
- Colour a font-icon marker via a `style="color:…"` attribute or a per-entity colour field token.
- Show distinct markers per content type or category by varying the marker field value.
- Render custom markers on single-entity maps and on Views-based Leaflet maps alike.
- Auto-load only the icon-font CSS a given page actually needs (no unused libraries).
- Fall back automatically to the default blue Leaflet pin when no marker is set.
- Let editors pick emojis from a built-in picker on the entity edit form.
- Build an emoji-coded points-of-interest map (restaurants, hotels, shops) from one content type.
- Keep icon/popup anchors aligned across zoom levels without manual offset tuning.
- Reuse the same `field_map_marker` field across nodes, users, terms, paragraphs and media.
