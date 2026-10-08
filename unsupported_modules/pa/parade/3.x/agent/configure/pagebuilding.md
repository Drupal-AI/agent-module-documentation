<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Building pages with Parade

Parade is a Paragraphs-based toolkit; the setup is content-model work rather than a single settings page.

1. Install Parade and its composer dependencies (paragraphs, view_mode_selector, classy_paragraphs, field_group, geocoder/geofield/leaflet, machine_name).
2. Optionally install `parade_demo` for demo content and `parade_pack` for extra features (both configured at `/admin/config/content/parade_demo` and `/admin/config/content/parade_pack`, requiring *administer site configuration*).
3. Create/adjust **Paragraph types** for your page sections; use Parade's widgets on the entity-reference-revisions (paragraphs) field:
   - `InlineParagraphsPreviewerWidget` / `InlineParagraphsWidget` — inline editing with preview.
   - `CallToActionWidget` + `CallToActionFormatter` — CTA fields.
   - `LinkWithSelectedAttributeWidget` — link fields carrying a selected attribute/class.
4. Use **view_mode_selector** and **field_group** to control section layout, and **classy_paragraphs** for preset styling classes.
5. Add conditional behaviour with `parade_conditional_field` (manage at `/admin/structure/paragraphs_type/<type>/parade-conditional-fields/add`, requires *administer paragraphs types*).

Integration submodules (`marketo_form`, `marketo_poll`, `linkedin_autofill`, `aggregated_leaflet_map`) add specific paragraph components; enable only the ones you need.
