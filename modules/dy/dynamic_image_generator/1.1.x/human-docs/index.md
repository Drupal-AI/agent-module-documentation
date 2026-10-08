# Dynamic Image Generator — manual setup guide

**Dynamic Image Generator** (`dynamic_image_generator`) creates images from
**HTML/CSS templates**. You design a template in HTML and CSS using **Twig syntax and
Drupal tokens** (like `[node:title]` or `[node:content-type]`), assign it to an image
or media field, and when an editor picks that template and saves a node, the module
renders the template into an image and stores it in the field. It's a fast way to
auto‑generate styled images such as social‑share cards, without a designer touching
every node.

The key thing to understand is that the rendering is done by an **external
image‑generation service** — specifically the HTML/CSS‑to‑Image API — which is a
**required dependency** for the module to function. Your template's HTML/CSS (with
tokens already replaced by real site/entity data) is sent to that API, and the
returned image is saved back into Drupal as media. You can create **multiple
templates per field**, each of which shows up as a choice in the node edit form, and
there's an **Image Report** listing every dynamic image generated, filterable by
template, content type, or node.

The module depends on core **File**, **Image**, and **Media** (plus Node, User,
Views, Field, and System), and it provides its own **permission**.

> **Security, cost, and privacy note:** because template content is sent to a
> third‑party API, treat two things carefully. First, **egress** — token‑replaced
> data (which may include site or entity content) leaves your server for the external
> service; confirm that's acceptable for your data. Second, **the API key** — store
> it as a secret (environment variable / Key entity), never hard‑coded or committed,
> and always over HTTPS. Generating images via an external, metered API can also
> incur **usage costs**, so factor that into how freely images are regenerated.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   store the image‑API key securely.
2. [Configuration](configuration/index.md) — connect the image API, build templates,
   assign them to fields, and read the image report.

## Where it lives in the admin menu

You configure the external image API, build your HTML/CSS templates, and view the
generated‑image report from the module's admin pages under **Configuration** (see
[Configuration](configuration/index.md)). Templates are then chosen per node in the
**node edit form** for the fields they're assigned to.
