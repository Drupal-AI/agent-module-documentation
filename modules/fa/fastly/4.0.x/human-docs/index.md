# Fastly — manual setup guide

**Fastly** (`fastly`) connects your Drupal site to the [Fastly](https://www.fastly.com)
content delivery network so the CDN's edge cache stays in step with your content.
Its core trick is mapping Drupal's cache tags to Fastly **Surrogate Keys**: every
page Drupal serves gets a `Surrogate-Key` response header describing exactly which
content it depends on, and when that content changes, the module tells Fastly to
purge precisely the affected pages — no more, no less. The result is a CDN that
serves pages fast but never shows stale content after an edit.

Beyond purging, the module is a control panel for Fastly's edge features. You can
choose **instant** or **soft** purging, serve **stale content** while revalidating
(or when your origin errors) to smooth out load and outages, optimize and resize
**images at the edge** (including automatic WebP), enable **Edge Modules** for
things like CORS headers, country blocking, redirects, and URL rewrites, receive
**webhook** notifications, and upload custom **VCL** snippets. Purges are also
available as Drush commands so you can wire them into deployments.

Credentials — your Fastly API token, Service ID, and an optional Site ID — can be
entered in the UI or, better for security, supplied through environment variables
that override the stored config. All the local configuration works without a live
connection; only the actual purging and VCL uploads need valid credentials and
network access. A bundled submodule, **Fastly Purger** (`fastlypurger`), plugs the
integration into the contrib [Purge](https://www.drupal.org/project/purge) module
so purges flow through Purge's queue and processor.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and decide about the Fastly Purger submodule.
2. [Configuration](configuration/index.md) — credentials, purge options, stale
   content, image optimizer, webhooks, and edge modules, form by form.

## Where it lives in the admin menu

All of Fastly's forms live under **Configuration → Web services → Fastly**
(`/admin/config/services/fastly`) and require the **Administer Fastly**
(`administer fastly`) permission. From the main page you reach sub‑forms for Purge
Options, Stale Content Options, the Image Optimizer, Webhooks, and Edge Modules.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Enter your Fastly API token and Service ID — ideally via environment variables
   (see [Configuration → Credentials](configuration/index.md#credentials-the-main-form)).
3. Choose your purge method and, if you want extra resilience, turn on stale
   content serving.
4. Let the site run: as editors change content, Drupal's cache‑tag invalidations
   are translated into targeted Fastly purges automatically. For manual or
   deploy‑time purges, use the Drush commands:

   ```bash
   drush fastly:purge:all                       # purge all site content
   drush fastly:purge:url https://example.com/blog
   drush fastly:purge:key 'node:12,taxonomy_term:4'
   drush fastly:purge:service                   # purge the whole service
   ```
