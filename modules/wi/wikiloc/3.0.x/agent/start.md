<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Wikiloc (wikiloc) — agent index
**Field type/widget/formatter that embeds Wikiloc trails/waypoints via an iframe.**

- **Version:** 3.0.x — core `^8 || ^9 || ^10`
- **Depends on:** field
- **Plugins:** FieldType `MapItem`, Widget `MapWidget`, Formatter `WikiLocFormatter`; theme `wikiloc_map_field` (`templates/wikiloc_map_field.html.twig` → `<iframe src="{{ url }}">`)
- **Security:** display field with no routes/permissions/services or server-side external calls. The iframe `src` is the editor-entered field value rendered into an `<iframe>`; restrict field-edit access (trusted-editor input) as with any embed field.
