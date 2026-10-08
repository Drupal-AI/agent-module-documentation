# Iframe — manual setup guide

**Iframe** (`iframe`) adds a new **field type** called *Iframe* that lets editors
embed a complete `<iframe>` into content without writing any HTML. Add the field to
a content type (or any other fieldable entity), and editors get a tidy form for the
things an iframe needs — a source URL plus, depending on how you set it up, width,
height, a title and other options — instead of pasting raw embed code.

That makes it the go‑to tool for embedding external content: a YouTube or Vimeo
video, a Google Map, a calendar or booking widget, a dashboard, or any external web
page inside a node. You control how much freedom editors have with the choice of
**widget** — URL only, URL plus height, or URL plus width and height — and how the
embed appears with the choice of **formatter** — the iframe with a title above it,
the iframe alone, or the value rendered as a plain link instead of an embed.

Sizing is flexible: widths and heights can be fixed pixels, percentages, or em/rem
and viewport units, and a special responsive class turns the width and height into
an aspect ratio so the embed scales with its container. There are also options for
the frame border, scrolling, transparency, fullscreen support, an accessible
heading level for the title, per‑iframe CSS classes, and — when the Token module is
installed — tokens in the title and URL.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — adding the field, choosing a widget
   and formatter, and the sizing and display options.

## Where it lives in the admin menu

Iframe has no central settings page. Everything is configured **per field**, in the
Field UI of the content type (or other entity) you add it to: **Manage fields**,
**Manage form display** and **Manage display** under, for example, **Structure →
Content types → _\<type\>_**.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. On a content type, add a field of type **Iframe** and set its defaults.
3. Choose the widget on **Manage form display** and the formatter on **Manage
   display** (see [Configuration](configuration/index.md)).
4. Create or edit content, paste in the URL to embed, and the iframe renders on the
   page.
