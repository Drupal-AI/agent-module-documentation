# Grout Image — manual setup guide

**Grout Image** (`grout_image`) provides automatic fallback images — avatars and
placeholders — for media fields that are empty. It integrates with the Grout
on‑demand image API so that content with no image still shows a consistent,
generated avatar or placeholder instead of a broken or blank space. It's built for
sites that do bulk content imports (movies, books, people) where posters, covers,
or headshots aren't always available.

The module gives you three ways to use it. There's a **field formatter**, "Grout
Fallback", for entity‑reference fields that point to media entities: it shows the
real image when one is present, and a Grout‑generated image when the field is empty.
The fallback is sized to match the output dimensions of the Drupal image style you
choose, so your layout doesn't shift when a real image is missing. There are also a
Twig **filter** (`grout_avatar`) and **function** (`grout_placeholder`) you can call
directly in templates. And there's a site‑wide **settings page** for the defaults
(base URL, colours, size, format).

Grout Image uses two Grout endpoints — an avatar endpoint that draws initials, and a
placeholder endpoint that draws a solid colour with optional text. **No API key is
required.**

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — the site‑wide settings, the field
   formatter, and Twig usage.

## Where it lives in the admin menu

Grout Image's settings form is at **Configuration → Media → Grout Image**
(`/admin/config/media/grout-image`). The field formatter is configured per field on
each entity's **Manage display** screen.
