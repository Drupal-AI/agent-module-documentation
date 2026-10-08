# Marketo JS Forms Integration — manual setup guide

**Marketo JS Forms Integration** (`marketo_forms`) displays your
[Marketo](https://www.marketo.com) marketing forms on a Drupal site using
Marketo's JavaScript Forms API. The forms themselves are hosted and designed in
Marketo; this module embeds them into Drupal so visitors can fill them in, and
submissions flow back to Marketo as leads.

It gives you three ways to place a form:

- **Blocks** — create a Marketo form block and position it like any other block.
- **A field type** — add a Marketo form field so each entity (for example each node)
  can carry its own unique form.
- **A CKEditor plugin** — editors embed a form inside body content by inserting the
  token `[marketo-form:FORM_ID]`.

It depends on core's **Block** and **Field** modules and supports Drupal 10, 11,
and 12.

Because the module loads Marketo's third‑party JavaScript and collects lead data
from visitors, it is a **privacy and consent** consideration: the Marketo script
runs in the visitor's browser and captures the data they submit. Where consent
rules apply, gate the forms behind your cookie‑consent mechanism and describe the
data collection in your privacy notice.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — connect your Marketo instance and
   place forms as blocks, fields, or CKEditor tokens.

## Where it lives in the admin menu

You connect the module to your Marketo instance from the module's settings (in the
**Marketo** group under **Configuration**). Form blocks are placed at **Structure →
Block layout** (`/admin/structure/block`), and the Marketo form field is added per
content type under **Structure → Content types → *(your type)* → Manage fields**.
