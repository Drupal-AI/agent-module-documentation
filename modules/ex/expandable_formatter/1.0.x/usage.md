<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds an "Expandable" display formatter for text fields that trims content to a fixed pixel height and reveals the rest with a JavaScript expand/collapse toggle.

---

Expandable Formatter is a small, dependency-light module (only core `field`) that registers a single field formatter plugin, `ExpandableFormatter` (label "Expandable"), for the `text`, `text_long`, `text_with_summary`, and `string_long` field types. Unlike character-count trimming, it limits the rendered field to a configurable **height in pixels** (`collapsed_height`) so the page layout stays predictable regardless of content length, then shows an optional ellipsis and a clickable trigger link that expands or collapses the text using a jQuery slide animation (or an instant show/hide when the effect is set to "none"). All behavior is configured per view-display on *Manage display*: collapsed height, whether to append an ellipsis, the expand/collapse trigger labels, extra CSS classes on the trigger, the animation effect, and the animation duration. Field text is rendered through Drupal's normal display pipeline (formatted text runs through its assigned text format; plain text is line-broken), and the collapse is purely presentational (CSS height plus `overflow: hidden`), so the full field markup is always present in the DOM. There are no routes, permissions, services, entities, or site-wide settings forms; the only stored config is the formatter's per-display settings (schema `field.formatter.settings.expandable_formatter`).

---

- Show a long body field on a node teaser or full page trimmed to a fixed height with a "read more" toggle.
- Keep a card/grid layout uniform by capping every description field at the same pixel height.
- Add a "Show more / Show less" control to a `text_long` or `text_with_summary` field without writing custom JS.
- Collapse verbose product descriptions in Commerce or catalog displays until the visitor expands them.
- Trim a plain-text `string_long` field (no text format) while preserving line breaks in the visible portion.
- Provide expand/collapse for FAQ answers or policy text rendered from a text field.
- Configure custom trigger labels (e.g. "Read more" / "Read less", "Expand" / "Collapse") per view-display.
- Style the toggle as a button by setting trigger CSS classes (defaults to `button`).
- Disable the ellipsis when a cleaner truncation look is preferred.
- Choose a smooth slide animation or an instant toggle via the "Animation effect" setting.
- Tune the animation speed with a millisecond duration setting.
- Apply different collapsed heights per display mode (teaser vs. full) for the same field.
- Only render the toggle when content actually exceeds the collapsed height (the JS skips short values automatically).
- Reduce visual clutter on landing pages that aggregate many long-text fields.
- Let editors write as much as they want while the front end keeps a controlled footprint.
- Replace character-based "Trimmed"/"Summary or trimmed" formatters when a predictable height matters more than a character count.
- Combine with an existing text format so formatted HTML (links, lists, images) is preserved inside the collapsible region.
- Add read-more behavior to bio, about, or description fields on user or taxonomy displays.
- Export the formatter choice and its settings in a view-display config for repeatable deployments.
- Enable the module and configure it entirely through the UI with no external libraries to install.
