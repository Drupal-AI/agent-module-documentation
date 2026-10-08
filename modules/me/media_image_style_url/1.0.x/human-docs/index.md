# Media Image Style URL — manual setup guide

**Media Image Style URL** (`media_image_style_url`) provides a **route** that
returns a media item's image rendered through a chosen image style. In other words,
you can build a URL that asks for, say, a particular media entity in the
`thumbnail` or `large` style and get the styled derivative back. That's handy for
decoupled/front‑end consumers and for building dynamic image links where you don't
want to hard‑code derivative paths.

The route resolves a **media item plus an image style** and can trigger image‑style
derivative generation on demand. Access to it is governed by the module's own
permission, so you decide which roles may use the endpoint. Because the endpoint
serves images for a given media item, make sure it is used in a way that respects
**media access** — a user should only be able to retrieve images for media they are
allowed to view.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and grant the permission.

There is **no settings form** for this module. The only thing to configure is the
permission that gates the route, covered below and in Installation.

## How to use it

1. Grant the module's permission (on **People → Permissions**) to the roles that
   should be allowed to request styled media images through the route.
2. Make sure the image styles you intend to reference exist at **Configuration →
   Media → Image styles** (`/admin/config/media/image-styles`).
3. Build URLs that request a media item in the desired image style from your
   front‑end or integration code. The route returns the media's image rendered in
   that style, generating the derivative if it doesn't exist yet.

> **Access reminder:** the permission controls *who may use the route*. Keep media
> access in mind so the endpoint is not used to surface images from media a user
> could not otherwise view.
