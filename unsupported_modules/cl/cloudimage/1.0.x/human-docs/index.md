# Cloudimage by Scaleflex — manual setup guide

**Cloudimage by Scaleflex** (`cloudimage`) routes your site's images through the
Cloudimage CDN so they are resized, compressed and optimized on the fly. Instead
of serving the original files straight from your server, the module rewrites image
URLs (or attaches Cloudimage's JavaScript) so each visitor receives an
appropriately sized, well-compressed image from a global content delivery network —
which usually means faster page loads and lighter bandwidth.

It solves a common performance problem: large, unoptimized images that slow pages
down and hurt Core Web Vitals. Cloudimage handles the heavy lifting remotely, so
you don't generate and store dozens of image derivatives locally. The module can
work in two ways — a **standard (no-JavaScript) mode** that rewrites `<img>` URLs
server-side, or a **JavaScript mode** that loads the Cloudimage library to
transform images in the browser (with responsive sizing, lazy loading and retina
support).

The module does **need configuration before it does anything useful**: you must
create a Cloudimage account, obtain a token (or set up a CNAME), and enter it on
the settings form, then turn optimization on. It has no other module dependencies
and no submodules. Note that image processing happens on Scaleflex's Cloudimage
service, so your image URLs are handled by a third party.

One security note worth keeping in mind: the settings form includes advanced
fields (a custom JavaScript transform function and custom library parameters) that
inject admin-provided JavaScript and parameters into the front end. Only trusted
administrators should have access to the Cloudimage configuration.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — enter your Cloudimage token and tune
   how images are optimized, field by field.

## Where it lives in the admin menu

Once enabled, Cloudimage's settings form sits at
`/admin/config/cloudimage-by-scaleflex` (permission: **Administer site
configuration**). Nothing is optimized until you enter a token there and enable the
module.
