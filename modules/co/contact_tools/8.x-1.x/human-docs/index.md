# Contact Tools — manual setup guide

**Contact Tools** (`contact_tools`) is a developer‑oriented toolkit for working
with Drupal's core **Contact** module forms. Its headline feature is easy **AJAX
support for contact forms on demand** — so you can drop a contact form into a modal
window or embed it inline and have it submit without a full page reload. It depends
only on core's Contact module.

Rather than a click‑through configuration UI, Contact Tools gives developers and
themers a set of building blocks: a service to render a contact form (with or
without AJAX), helpers to generate a link that opens the form in a modal (with or
without AJAX), a text filter that turns simple markup into modal‑form links, Twig
functions to embed a modal link or a whole form straight from a template, and hooks
to modify the form data at each step. There is deliberately **no global settings
page** — these tools are meant to be called on demand where you need them, not
switched on site‑wide.

Because the underlying forms are still core contact forms, they remain governed by
core's own contact permissions; Contact Tools adds no access‑control layer of its
own. The project *is* covered by Drupal's security advisory policy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside core Contact.

There is **no configuration page** — Contact Tools is a developer toolkit used from
code, Twig, and the text filter. See "How to use it" below and the module's
external documentation.

## How to use it

Contact Tools is used in code and templates rather than an admin form. In broad
strokes:

- Use its **service** to render a contact form programmatically, choosing whether
  it uses AJAX.
- Generate a **link that opens a contact form in a modal** (with or without AJAX).
- Enable its **text filter** on a text format to write simple modal‑form links in
  body content.
- Call its **Twig functions** to embed a modal link or an entire form directly in a
  template.
- Use its **hooks** to alter the form or its data at each step.

The maintainers keep fuller developer documentation at
`http://contact-tools.readthedocs.io/`.
