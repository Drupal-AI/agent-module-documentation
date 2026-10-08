<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
EPT Timeline adds a Timeline paragraph type — a wrapper paragraph holding a reorderable list of dated event items — rendered as a vertical timeline, to the Extra Paragraph Types family.

---

Timelines turn up constantly on marketing and institutional sites: a company history, a project's milestones, a product roadmap, the stages of an application process. Built by hand they end up as a table or a pile of nested divs in the body field, unmaintainable and unstyleable. EPT Timeline instead installs **two Paragraphs bundles** — `ept_timeline` (the wrapper, with an optional title/text and a required nested Paragraphs field) and `ept_timeline_item` (one event, with a free-text **date**, **title**, **text**, a **"current"** highlight flag, and an optional **image** picked from the media library). The module's three Twig templates lay the events out down a central spine (alternating left/right cards on desktop, stacked on mobile) using the bundled `css/simple_vertical/simple_vertical.css`; an event's image becomes the card's header background. Install `ept_core` and `paragraphs` first, and — because the item's image field depends on it — create an **`image` media type** before enabling the module, or `hook_requirements()` will block installation. Like the rest of the family it carries an `ept_settings` field whose widget exposes ept_core's shared **Design options** (margins, padding, borders, background color/image/video, container width) per instance; its own only extra control is a fixed `simple_vertical` style selector. There is no settings page, permission, route, or Drush command — configuration is entirely per-paragraph on the edit form's Settings tab. Adoption is normally family-wide, so **pin the EPT modules together** in composer: the family shares a widget base class whose signature has changed between releases, and nothing in the individual modules' requirements enforces a matching set.

---

- Show a company history as a vertical timeline.
- Lay out project milestones chronologically.
- Present a product roadmap on a landing page.
- Describe the stages of an application or onboarding process.
- Build an event programme ordered by date.
- Add an "our story" / "how we started" section to an About page.
- Give each timeline event its own date, title, body, and image.
- Highlight the current/active step with the "current" flag.
- Pick event images from the media library (image media type).
- Let editors add, remove, and reorder events without touching markup.
- Replace a hand-built timeline in a body field with structured fields.
- Theme timeline entries with template overrides in your theme.
- Apply ept_core design options (margins, background, container width) per timeline.
- Add a timeline component to a case study or portfolio page.
- Combine a timeline with other EPT components on the same page.
- Keep timeline styling out of the WYSIWYG editor.
- Structure dated content as fields rather than free-form HTML.
- Reuse the `ept_timeline` bundle in any Paragraphs field on any content type.
- Pin EPT family module versions together in composer to avoid widget mismatches.
