<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Excel Serialization Extras is a sandbox for the Excel Serialization module, adding extra serialization features.

---

Excel Serialization Extras adds extra features on top of the Excel Serialization (`xls_serialization`)
module — additional options/formats for serializing Drupal data (e.g. Views results) to Excel/XLS, developed
as a sandbox for those extras. It depends on the Excel Serialization module, in the Web services package.

Use it to extend Excel serialization/export. It is a developer/serialization feature that formats data for
Excel export; the exported data reflects what the exporting View/endpoint exposes (respecting that endpoint's
access), and it has no access-control role of its own. As with any data export, ensure the exporting
View/endpoint doesn't expose fields the requester shouldn't see. Configure the serialization options.

---

- Extend Excel serialization.
- Add extra XLS export features.
- Serialize data to Excel.
- Depend on the Excel Serialization module.
- Add serialization options.
- Export Views results to Excel.
- Reflect the endpoint's exposed data.
- Respect the endpoint's access.
- Have no access-control role of its own.
- Ensure exports don't leak fields.
- Configure serialization options.
- Format data for Excel.
- Handle XLS export.
- Extend xls_serialization.
- Export to XLS.
- Add export formats.
- Serialize to Excel.
- Configure exports.
- Handle Excel export.
- Add serialization extras.
