<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
A field type for embedding CodePen pens on any fieldable entity, with a widget to enter a pen URL and formatters to render the embed or a link.
---
The `codepen` field type (`CodepenItem`) stores the pen URL plus parsed identifiers (pen id, user id) and which default tabs to show (HTML/CSS/JS/result). The default widget (`CodepenDefaultWidget`) accepts a CodePen URL, and formatters render either the embed (`codepen_embed`, via the `codepen-embed` Twig template and the module's JS library) or a plain URL (`CodepenUrlFormatter`). Formatter settings control the embed size (including a responsive option) and custom height. Module-wide defaults are set at `/admin/config/media/codepen` (`administer codepen`). A Feeds target (`CodepenItem` under `src/Feeds/Target`) allows import mapping.

This is a content-display/field module: the only route is the admin settings form, gated by the `administer codepen` permission (`restrict access: true`). Embeds load CodePen's external embed script on the front end, so the usual third-party-embed privacy considerations apply. Setup: add a Codepen Embed field to a bundle, configure the widget/formatter, and enter pen URLs.
---
- Add a CodePen embed field to a content type or other entity.
- Let editors paste a CodePen URL to embed a pen.
- Render a live CodePen embed with the embed formatter.
- Render a plain link to the pen with the URL formatter.
- Choose which tabs (HTML/CSS/JS/result) are shown by default.
- Set the embed size or use a responsive size option.
- Set a custom embed height.
- Configure module-wide defaults at `/admin/config/media/codepen`.
- Show multiple pens via a multi-value field.
- Import pens through the Feeds target mapping.
- Display code demos in articles or documentation pages.
- Embed interactive front-end examples in tutorials.
- Attach the module's CSS/JS library only where needed.
- Theme the embed markup via `codepen-embed.html.twig`.
- Restrict configuration with the `administer codepen` permission.
- Store the pen and user identifiers alongside the URL.
- Reuse the field across nodes, users or custom entities.
- Present a portfolio of CodePen demos on a profile.
- Toggle the result-only preview per field value.
- Provide a lightweight alternative to manual iframe embeds.