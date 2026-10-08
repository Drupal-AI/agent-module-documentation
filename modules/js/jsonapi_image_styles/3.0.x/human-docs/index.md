# JSON:API Image Styles — manual setup guide

**JSON:API Image Styles** (`jsonapi_image_styles`) exposes the URLs of Drupal's
image-style derivatives (thumbnail, medium, large, cropped styles, and so on) on
your JSON:API `file--file` resources. That lets a decoupled front end — React,
Vue, Next.js, Gatsby, a mobile app — request pre-sized image renditions without
having to know or reconstruct Drupal's internal `/sites/default/files/styles/...`
URL scheme.

Under the hood the module adds a single read-only computed field,
`image_style_uri`, to every File entity. When a file is an image, that field is
filled in at read time with a map of `image_style_name → absolute_url` for each
exposed style, and JSON:API serializes it straight into the file resource's
attributes. Your front end includes the image file in a JSON:API request and reads
the ready-made URLs — no hard-coded paths, and the URLs stay valid across dev,
stage, and production because Drupal builds them server-side.

By default *every* image style you've defined is exposed. An optional settings
form lets you narrow that to an allow-list — for example only `thumbnail` and
`large` — to keep API payloads small. The module adds no permissions of its own
(the settings form uses core's "Administer image styles" permission) and no Drush
commands.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside core JSON:API and Image.
2. [Configuration](configuration/index.md) — the optional allow-list of which
   image styles get published to the API.

## Where it lives in the admin menu

There's nothing you must click to make it work — once enabled, the
`image_style_uri` field appears on every image file in your JSON:API output. The
optional settings form lives at **Configuration → Web Services → JSON:API Image
Styles** (`/admin/config/services/jsonapi/image_styles`).

## How to use it

From a decoupled client, include the image file in your JSON:API request and read
`image_style_uri` off the returned file resource:

```
GET /jsonapi/node/article/{uuid}?include=field_image
```

The included `file--file` resource carries an `attributes.image_style_uri` map like:

```json
"image_style_uri": {
  "thumbnail": "https://example.com/sites/default/files/styles/thumbnail/public/cat.jpg",
  "large": "https://example.com/sites/default/files/styles/large/public/cat.jpg"
}
```

For media fields, walk to the underlying file — for example
`?include=field_media_image` on a `media--image` request — then read
`image_style_uri` on the included file. The field is read-only; requesting one of
these URLs is what triggers Drupal to generate the derivative, exactly as it would
for a normal image-style URL.
