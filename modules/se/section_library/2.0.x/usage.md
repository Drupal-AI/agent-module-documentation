<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Section Library lets Layout Builder editors save any single section, or a whole page of sections, as a reusable template and drop it back into any other Layout Builder layout. Templates are **content**, not config, so editors create and reuse them on the fly without config export/import.

---

Section Library adds two "Save to library" links inside the Layout Builder UI — one on each individual section and one at the top of the layout for the entire page. Saving stores the section(s) as a `section_library_template` content entity (base table `section_library_template`) with a human label, an optional preview image, a `type` of either `section` or `template`, and the serialized Layout Builder sections in a multi-value `layout_section` field. When editing another layout, a **Choose template from library** link opens a Views-powered picker (`views.view.section_library`) filtered to the matching type; importing deep-clones the stored sections — generating fresh UUIDs and new block instances for any inline (non-reusable) blocks so the copy is independent of the original. Saved templates are managed at **Admin → Content → Section library** (`/admin/content/section-library`), and the module's own settings form at **Admin → Config → Content → Section library** only renames the two type labels ("Section"/"Template"). Access is gated by six permissions (view, add, edit, delete, import, administer). It requires the core Layout Builder, Image, Options, and Views modules, and is content-based, so it complements rather than overlaps the config-based Layout Builder Library module.

---

- Save a hero section you designed once and reuse it across many landing pages.
- Capture an entire multi-section landing page as a single "Template" and stamp out new campaign pages from it.
- Build a shared library of on-brand section patterns (CTA, testimonial grid, pricing table) for content editors.
- Let non-developers reuse layouts without touching config export/import or code.
- Duplicate a section within the same page to repeat a pattern quickly.
- Give each saved template a preview screenshot so editors pick the right one visually.
- Maintain a "starter kit" of page templates for a new content type rollout.
- Rename the "Section" and "Template" labels to match your team's vocabulary (e.g. "Block group" / "Page layout").
- Curate the template list at Admin → Content → Section library, editing labels or deleting stale entries.
- Restrict who can create versus only import templates using the six granular permissions.
- Let a design team author templates while editors are limited to importing them.
- Copy a proven section from a staging node's layout into a production node's layout.
- Preview a stored template at `/admin/content/section-library/{id}/preview` before importing it.
- Seed a fresh site with a library of reusable sections via a deploy/update hook that creates `section_library_template` entities.
- Reuse sections that contain inline blocks safely — the import clones inline blocks into new independent instances.
- Standardize footers or headers as importable sections across an editorial team.
- Combine all sections currently on a page into one reusable "page" template with a single click.
- Provide a modal (via Layout Builder iFrame Modal) picking experience instead of the narrow off-canvas tray.
- Programmatically enumerate saved templates and their layouts for auditing or migration.
- Bulk-manage templates through the bundled Views listing, adding filters or columns to it.
- Give marketing a self-service catalog of pre-built section blocks to assemble pages.
- Keep design consistency across dozens of pages by importing from one canonical template.
- Roll out a redesigned section by updating the template and re-importing it where needed.
- Let authors clone a competitor-style layout structure into their own node quickly.
- Store both granular sections and full-page templates side by side, distinguished by the `type` field.
