# Sightengine — manual setup guide

**Sightengine** (`sightengine`) connects your Drupal site to the **Sightengine**
content-moderation service so that user-submitted images, videos, and text are checked
for objectionable content automatically when an entity is saved. Rather than staffing a
manual review queue, you let Sightengine's models score each submission and Drupal
blocks the save if something crosses the line.

The moderation is turned on **per field**. On any string, text, image, file, or entity
reference field, the module adds a **"Sightengine validate"** checkbox to the field's
edit form; tick it and that field is moderated from then on. When an entity is saved,
the module sends the field's value to Sightengine — text is posted as a string, images
and files are uploaded — and reads back the model scores. If a score for a category you
have enabled crosses the threshold, the save fails with a message naming the offending
category, so the bad content never gets published. You choose which models run: for
images and video, **nudity**, **weapons/alcohol/drugs**, **gore**, and **offensive**
content; for text, you can flag or ignore **profanity**, **personal data** (email,
phone, IP addresses), and **links**.

This module needs configuration before it does anything: you enter your Sightengine app
credentials and the API endpoint URLs, choose your models, and then enable moderation on
the specific fields you care about. It provides a single admin settings route gated by
the **administer sightengine** permission.

A few things to know about how it behaves. Moderation runs **synchronously on every
save** of a moderated field, which means each such save makes a blocking outbound API
call — so API latency and your Sightengine quota are the main operational
considerations. On the security side, the endpoint URLs are admin-configured (not taken
from any request, so there is no SSRF exposure) and outbound calls use TLS with
certificate verification on. Your Sightengine `client_secret` is stored in the module's
configuration in cleartext and sent with each request — standard for this kind of
integration, but worth knowing when you think about who can read your site config.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — enter your credentials, pick models, and
   turn moderation on per field.

## Where it lives in the admin menu

The settings form is at **`/admin/config/people/sightengine`** (route
`sightengine.settings`), behind the **administer sightengine** permission. Per-field
moderation is switched on by editing each field and ticking "Sightengine validate". See
[Configuration](configuration/index.md).
