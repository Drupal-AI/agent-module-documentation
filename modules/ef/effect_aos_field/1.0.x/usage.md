<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Effect AOS Field provides a field type that lets editors apply AOS (Animate On Scroll) effects to other fields on the same content type or paragraph, configured per entity instance from the edit form.
---
The module solves per-content animation control (unlike bundle-level alternatives) by storing, per entity, a JSON list of which sibling fields receive which AOS effect. The `effect_aos` field type stores JSON in one text column; the widget lets editors pick an allowed target field, effect, duration, easing, delay and anchor placement. On render, `hook_entity_view` reads the JSON and stashes effects onto each target field's render array, and `hook_preprocess_field` writes the `data-aos-*` attributes onto the field wrapper (at preprocess time so AOS registers triggers on first paint). Effect/easing/anchor option lists are discovered from any module or theme `*.options.yml` file.

The module has no routes, permissions or request handling. Widget input is JSON-decoded and sanitized field-by-field in `massageFormValues` to a whitelist of keys, and `data-aos-*` values render through Drupal's attribute system (auto-escaped), so there is no stored XSS. Note: the AOS library CSS/JS is loaded from a public CDN without an SRI integrity hash (a supply-chain/availability consideration, not an exploitable bug). Set up by adding the field to a content type, choosing allowed target fields in widget settings, then configuring effects while editing content.
---
- Add an "AOS Animation Effects" field to a content type or paragraph
- Choose which sibling fields may receive animations (widget settings)
- Give two nodes of the same type different animations
- Apply a fade/flip/slide/zoom effect to a specific field
- Set animation duration in ms per effect
- Set an easing function per effect
- Set a start delay per effect
- Set anchor-placement (trigger point) per effect
- Remove or replace an effect entry from the edit form
- Animate fields on first scroll without writing custom JS
- Extend available effects via a module/theme *.options.yml
- Override default effect options from a theme
- Store animation config inline as JSON (no extra tables)
- Apply animations to paragraph fields
- Keep animation choices with content authors, not site builders
- Render data-aos-* attributes server-side for correct trigger registration
