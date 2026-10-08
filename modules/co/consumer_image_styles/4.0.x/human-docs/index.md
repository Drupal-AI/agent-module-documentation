# Consumer Image Styles — manual setup guide

**Consumer Image Styles** (`consumer_image_styles`) is for decoupled Drupal
sites. It lets each **Consumer** — a registered front end such as a React app, a
mobile app, or a smart‑TV client — declare exactly which image styles it needs,
and then adds the matching derivative (image‑style) links to image files in that
consumer's JSON:API responses. Instead of hardcoding derivative URLs in your
front end, each client discovers the resized image variants it asked for, with
absolute URLs and `width`/`height`/`type` metadata ready for a `srcset`.

Under the hood, the module adds an **Image Styles** field to the consumer entity
(an unlimited entity reference to image styles), so on each consumer's edit form
you simply tick the styles that client should receive. When JSON:API serves a
response to that consumer, the module decorates the link output so every image
file gains one derivative link per selected style. Optionally, using
[JSON:API Extras](https://www.drupal.org/project/jsonapi_extras), you can attach
its `image_styles` field enhancer to a single image field and narrow the styles
just for that field.

Because styles are scoped per consumer, you avoid shipping every image derivative
to every client: your web front end, mobile app, and TV app can each request
their own set. The module has **no admin settings page of its own** — you
configure everything on the consumer entities themselves — and it requires the
Image, [Consumers](https://www.drupal.org/project/consumers), and JSON:API
modules.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent — the provider service, the
normalizer, and the field‑enhancer plugin — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Consumers and JSON:API.

## Where it lives in the admin menu

The module adds no settings page. You configure it on each consumer at
**Configuration → Web services → Consumers** (`/admin/config/services/consumer`)
— edit a consumer and tick the image styles it needs. The consumers listing also
gains an **Image Styles** column so you can see each client's selection at a
glance.

## How to use it

1. Create your image styles as usual under **Configuration → Media → Image
   styles** (for example `thumbnail`, `medium`, `large`).
2. Go to **Configuration → Web services → Consumers**, edit (or create) the
   consumer that represents your front end, and check the image styles that
   client should receive. Save.
3. When that consumer requests content through JSON:API, each image file in the
   response now carries a derivative link for every style you selected — with the
   absolute URL and image dimensions — so the client can pick the right variant.
4. To limit the styles to one particular image field instead of all images,
   install JSON:API Extras and attach the `image_styles` field enhancer to that
   field, choosing the subset of styles you want.

Adding a newly created image style to a consumer rolls it out to that client;
removing one stops those links from being emitted.
