# Configuration

Setting up Dynamic Image Generator has three parts: connect the external image API,
build one or more templates, and assign each template to an image or media field.
After that, editors pick templates when they edit content, and you can review results
in the image report.

## Step 1 — Connect the external image API

The module renders images through the external HTML/CSS‑to‑Image API, so it needs
your API credentials before it can generate anything.

1. Log in as a user with the appropriate administration permission.
2. Open the module's settings under **Configuration** and enter your **image‑API
   credentials** (the API key / user id for the HTML/CSS‑to‑Image service).
3. As covered in [Installation](../installation/index.md), prefer supplying the key
   from an environment variable / **Key** entity rather than pasting the raw secret,
   and make sure traffic is over HTTPS.
4. Save.

> **Reminder:** template content — including token‑replaced site and entity data — is
> sent to this external service (egress), and generating images may incur usage
> costs. Confirm both are acceptable for your site before generating at scale.

## Step 2 — Build one or more templates

A template is HTML/CSS that describes the image you want to produce.

- Write the template using **HTML and CSS**, with **Twig syntax** and **Drupal
  tokens** (for example `[node:title]`, `[node:content-type]`) so each generated image
  reflects the node it belongs to.
- **Background images:** upload an image and reference it in the template's HTML/CSS
  via tokens to use it as a backdrop.
- You can create **multiple templates for the same field** — every active template
  becomes a selectable option in the node edit form.

## Step 3 — Assign templates to fields

Assign each template to a specific **Image** or **Media image** field on the content
types where you want automatic generation. Once assigned, that field's node edit form
offers the template(s) as choices.

## How editors generate an image

When creating or editing a node that has a field with assigned templates, the editor
**selects the desired template and saves** the node. The module renders that template
(with tokens filled from the node) into an image via the external API and stores the
result in the field automatically.

## The image report

The module provides an **Image Report** listing all dynamic images that have been
generated. You can **filter** it by template name, content type, or node — useful for
auditing what's been produced and for spotting regenerations that may be running up
API usage.

## Verify it worked

Create a small test template, assign it to an image field, edit a node of that type,
pick the template, and save. Confirm the image appears in the field and that a new
row shows up in the image report.
