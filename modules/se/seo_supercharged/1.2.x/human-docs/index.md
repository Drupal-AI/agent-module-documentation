# SEO Supercharged — manual setup guide

**SEO Supercharged - Direct Publish Integration** (`seo_supercharged`) connects
your Drupal site to the SEO Supercharged platform so that AI-generated blog
articles and images can be published straight into Drupal nodes — no manual
copy-and-paste. The module exposes a set of REST endpoints that the platform
calls to create, update, and retrieve article nodes.

The endpoints live under clean Drupal-native paths (`/seo-supercharged/v1/...`),
and — helpfully for anyone migrating from WordPress — the same functionality is
also exposed under WordPress-style paths (`/wp-json/wp-seo-supercharged/v1/...`),
so a site moving off WordPress needs zero reconfiguration on the platform side.
Every pushed image is stored as a proper Drupal Media entity (a media type called
`seo_supercharged` is created when you install the module), so images show up and
can be managed in the Media Library. The module can also auto-create or reuse
taxonomy terms for categories and tags, write SEO metatags (title, description,
canonical URL, and Open Graph tags) when the Metatag module is present, handle a
featured image and gallery images, and import articles in bulk through a batch
endpoint.

This module requires configuration before it will accept anything: you enable it,
prepare an article content type, set (or generate) an API key on its settings
form, map your field names, and then paste the endpoint base URL and API key into
your SEO Supercharged platform settings. It depends on a number of core modules
(Node, File, Image, Media, User, System, Path, Path alias, Taxonomy — all in
core) and works on Drupal 9.3, 10, or 11 with PHP 8.1+. The **Metatag** module is
recommended if you want SEO tags written, and **Paragraphs** is auto-detected if
your body field is a Paragraphs reference.

A word on security, because this module opens write endpoints. The routes are
intentionally open at the routing layer; the real authorization happens inside
the controller. A caller is allowed if they are a logged-in Drupal user with the
`administer nodes` or `bypass node access` permission, **or** if they present the
correct API key in the `X-API-KEY` header (a legacy `Authorization: Bearer`
header also works). If no API key has been configured, anonymous callers are
rejected outright — the endpoints are not open by default. Importantly, when a
request is authorized purely by API key, content is created as **user 1**, so the
API key is an admin-equivalent credential: store it carefully and rotate it.
Image sideloading is well defended against SSRF — it is HTTPS-only, blocks
localhost, link-local, and cloud-metadata hosts and private IP ranges,
re-validates every redirect, verifies TLS, and caps size and redirects. Responses
send permissive CORS (`Access-Control-Allow-Origin: *`), and the content-index
read endpoint deliberately ignores node access, which is another reason to guard
the key.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and prepare an article content type.
2. [Configuration](configuration/index.md) — set the API key, map your fields,
   and connect the SEO Supercharged platform.

## Where it lives in the admin menu

The settings form is at **Configuration → Content authoring → SEO Supercharged**
(`/admin/config/content/seo-supercharged`, route
`seo_supercharged.settings_form`), behind the `administer seo supercharged`
permission.

## How to use it

Once the API key and field mappings are set and the platform is pointed at your
endpoints, publishing is driven entirely from the SEO Supercharged platform: it
calls your site's endpoints to create and update posts, sideload images into the
Media Library, and read a content inventory. Nothing needs clicking inside Drupal
for day-to-day use — your published articles simply appear as nodes.
