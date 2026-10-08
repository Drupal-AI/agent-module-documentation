<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# section_library — agent start

Save Layout Builder sections (one section, or a whole page) as reusable **content**
entities and import them into other layouts. The unit of storage is the
`section_library_template` content entity (base table `section_library_template`),
holding a `label`, a `type` (`section` | `template`), the serialized layout in a
multi-value `layout_section` field, an optional preview `image`, plus `entity_type`/
`entity_id` recording where it was captured. Managed at **Admin → Content → Section
library** (`/admin/content/section-library`, Views `section_library`). Depends on
`layout_builder`, `image`, `options`, `views`.

- The `section_library_template` entity, save/reuse flow, settings form, config keys → [configure/section_library.md](configure/section_library.md)
- Create/load/inspect templates in PHP; the `layout_section` field & deep-clone import → [api/section_library.md](api/section_library.md)
- The six permissions and what each gates → [permissions/section_library.md](permissions/section_library.md)
