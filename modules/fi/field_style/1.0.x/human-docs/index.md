# Field Style — manual setup guide

**Field Style** (`field_style`) lets site builders and content editors apply
**advanced, responsive CSS styling to any field's output directly from the content
edit form** — no custom code, templates, or stylesheets required. You style a
field visually, the styles are saved as JSON inside the field value (so they travel
with the content through exports and migrations), and on the front end they're
rendered as scoped CSS that won't collide with other styled fields on the page.

The styling UI is rich: 70+ CSS properties organized into collapsible groups
(Typography, Color, Spacing, Background, Border, Position, Effects, Animation),
each configurable per responsive breakpoint and per pseudo‑state (hover, active,
focus, visited). It also offers container queries, a site‑wide color palette with a
swatch picker, 50‑step undo/redo, a live CSS preview you can copy, style presets
you can export and import, Google Fonts integration, and custom font uploads. Under
the hood it's built with Vue 3, protects its AJAX endpoints with CSRF tokens, and
supports a CSP nonce for its inline style tags.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it, plus optional integrations.

There is **no single settings page** you must fill in to get started. Styling
happens on the field itself — you add a Field Style field and style content from the
edit form, described in "How to use it" below.

## How to use it

1. Add a **Field Style** field to a content type, or use it on an existing
   fieldable entity, via **Structure → Content types → *(type)* → Manage fields**.
2. When editing content, open the Field Style editor for that field. Use the
   accordion groups and the property search to set CSS properties, switching
   breakpoints and pseudo‑states as needed.
3. Watch the **live CSS preview** update, use **undo/redo** (Ctrl+Z / Ctrl+Y) to
   experiment safely, and save named **presets** if you want to reuse a look.
4. Save the content. On the front end the field renders with its scoped CSS —
   Field Style writes the CSS to `public://field_style/css/` and serves it as
   static files, cleaning up stale files via cron.

The optional integrations below (Media, Token, Image) unlock background‑image
picking, tokens in selectors, and image styles respectively.
