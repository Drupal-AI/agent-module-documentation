<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Ymaps Geolocation renders Geolocation field values as a Yandex Map.

---

**Yandex map geolocation field formatter** adds a field formatter and widget for the Geolocation module's field type that display coordinates on a Yandex Map (Ymaps). Latitude/longitude, map center, zoom, controls, behaviours and a token-replaceable balloon content are passed to a JS init library via `drupalSettings`. It depends on core Field, Field UI and the contrib `geolocation` module.

Use it to show location fields as interactive Yandex maps, optionally with node-token balloon content.

---

- Render a Geolocation field on a Yandex Map.
- Provide a Yandex map field formatter.
- Provide a Yandex map field widget.
- Show latitude/longitude as a placemark.
- Configure map center, zoom and type.
- Set map controls and behaviours.
- Use node tokens in balloon content.
- Pass map config to JS via drupalSettings.
- Depend on the Geolocation module.
- Display interactive maps in content.
- Set map width and height.
- Support auto-centering and auto-zoom.
- Show a balloon popup on the placemark.
- Add Yandex maps without custom code.
- Present address/location fields visually.
- Configure the formatter per display.
- Attach the Ymaps init library.
- Map multiple location fields.