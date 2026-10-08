<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views REST Field Format provides a views row plugin to better define REST export data format by field.

---

Views REST Field Format provides a Views row plugin for REST exports — letting you define the exported
data format on a per-field basis (rather than the default whole-row serialization), giving finer control over
the structure/naming of a REST export View's output. It depends on core Views.

Use it to shape REST export output field-by-field. It is a web-services feature affecting how a REST export
View serializes rows; the exported data reflects what the View exposes (respecting the View's access), and it
has no access-control role. As with any REST export, ensure the View doesn't expose fields the consumer
shouldn't see. Configure the field formats on the REST export View.

---

- Define REST export format per field.
- Provide a Views row plugin.
- Control export structure/naming.
- Depend on core Views.
- Go beyond whole-row serialization.
- Shape REST export output.
- Respect the View's access.
- Have no access-control role.
- Ensure the View doesn't over-expose fields.
- Configure the field formats.
- Handle REST export.
- Format export fields.
- Configure the row plugin.
- Shape export data.
- Handle Views REST.
- Format REST output.
- Configure export format.
- Control field output.
- Handle field formatting.
- Format REST exports.
