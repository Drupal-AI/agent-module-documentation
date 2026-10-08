MaxLength adds a configurable character limit and a live "characters remaining" countdown to titles, text fields, and link-field titles, enforced per widget on the Manage form display screen.

---

MaxLength is configured entirely through third-party settings on field widgets: on any content type's **Manage form display** page you open a widget's settings and enter a maximum length and an optional countdown message. It supports two modes — a *soft* limit that simply shows a negative count when the author types past the limit, and a *hard* limit that physically prevents typing beyond it. The countdown message is a template where `@limit`, `@remaining`, and `@count` are substituted live via JavaScript (`js/maxlength.js`, using core/drupal, core/once and jQuery). It works on plain string fields, formatted text fields, the summary of text-with-summary fields, and the title of Link fields, and it integrates with CKEditor 5 by attaching to the editor when present. Settings are stored as widget third-party settings (schema `field.widget.third_party.maxlength`), so they export cleanly with your form-display config. Developers can register additional widget types via `hook_maxlength_widget_settings()`. A summary of the active limit is shown on the Manage form display overview. There are no permissions, routes, or admin settings pages of its own — the whole feature lives on the field widget.

---

- Cap node titles at a set number of characters (e.g. 80) for design consistency.
- Show editors a live "characters remaining" countdown under a field.
- Enforce a hard limit that blocks typing past the maximum on a summary field.
- Apply a soft limit that shows how far over the limit the author has gone.
- Limit a meta-description-style text field to a SEO-friendly length.
- Constrain the summary of a text-with-summary body field independently of the body.
- Limit the title text of a Link field (capped at core's 255 max).
- Customize the countdown message wording per field.
- Keep teaser/lede fields concise for card-based layouts.
- Enforce Twitter/social-card length limits on a share-text field.
- Limit a string_textfield used for short headlines.
- Limit a string_textarea used for addresses or notes.
- Add a character budget to formatted (CKEditor 5) text fields.
- Give authors immediate feedback rather than a post-submit validation error.
- Standardize field lengths across content types via exported form-display config.
- Prevent overly long link titles in menus or CTAs.
- Set different limits on the same field type across different form modes.
- Encourage concise writing to match a design system's space constraints.
- Display a maximum-length summary badge on the Manage form display overview.
- Register MaxLength support for a custom widget via hook_maxlength_widget_settings().
- Limit a key_value_textarea widget's value and summary.
- Enforce a maximum length on a Linkit-enabled field.
- Show remaining characters live inside a CKEditor 5 editing area.
- Provide a gentle nudge (soft limit) without hard-blocking paste operations.
- Keep card titles from wrapping by capping their length at input time.
