# SVG Icon — manual setup guide

**SVG Icon** (`svg_icon`) provides a field type for uploading **SVG icons and
sprites**, so editors can add SVG vector graphics — individual icons or icon sprite
sheets — and use them in content and theming. It also provides a selectable widget
for choosing icons from an SVG sprite. It depends on core's **File** module and
provides its own permission for controlling who may upload.

Use it wherever you want to manage SVG icons as field content rather than hard-coding
them into a theme. Because SVGs are vector graphics, they stay crisp at any size,
which makes them a natural fit for icon systems.

**Security caveat — SVG uploads are an XSS risk, so read this before allowing
untrusted uploads.** SVG files can contain embedded JavaScript (`<script>` tags,
event handlers, `<foreignObject>`). If a user-uploaded SVG is served **inline** from
your site's own origin — that is, embedded into the page rather than referenced
through an `<img src>` tag — a malicious SVG can run script in your visitors'
browsers, which is stored XSS. To stay safe:

- **Restrict SVG upload to trusted roles** using the module's permission.
- **Sanitize uploaded SVGs** (strip scripts and event handlers, for example with an
  SVG sanitizer), **or** ensure they are served in a non-executing way — as
  `<img src>`, or behind a restrictive `Content-Security-Policy`.
- **Never let untrusted users upload SVGs that are then inlined**, and watch out in
  particular for `<foreignObject>` and `onload`-style handlers.
- **Confirm your rendering path is safe** before opening uploads to untrusted users.

This guide is written for a **human** setting the field up through the admin UI. If
you are an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

1. Go to **Manage fields** for your content type (or other fieldable entity) and
   **add a field** of the SVG Icon type.
2. Configure the field, then use its widget to upload or select the SVG icons/sprites
   you want.
3. On the entity's **Manage display**, choose how the icon renders.

Before you grant the upload permission to anyone beyond fully trusted
administrators, revisit the security notes above and confirm your site serves the
uploaded SVGs in a way that cannot execute script.
