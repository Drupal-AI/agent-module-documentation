# DocRaptor — manual setup guide

**DocRaptor** (`docraptor`) connects Drupal to the **DocRaptor HTML-to-PDF API**, a
cloud service that turns HTML into high-fidelity PDFs using the well-regarded
**Prince** PDF engine. Instead of rendering PDFs on your own server, the module
sends your HTML to DocRaptor and receives a finished PDF back — useful when you need
print-quality output (precise page layout, headers/footers, CSS paged media) that
is hard to achieve with a local library.

Authentication is handled cleanly: the module stores its **DocRaptor API key via
the Key module** rather than in plain configuration, so the secret stays out of
your exported config and version control. It provides its own permission and sits
in the "PDF" package.

Two things are worth understanding before you adopt it. First, this is an
**outbound integration** — your HTML content leaves your server and is sent to
DocRaptor's cloud to be rendered. If that HTML can contain sensitive data, confirm
that sending it to a third-party service is acceptable for your situation, and
always serve your site over HTTPS. Second, DocRaptor (the company) notes that while
they appreciate this community contribution, they do **not** officially maintain or
provide technical support for this Drupal module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (it pulls in the
   Key module) and enable the module.
2. [Configuration](configuration/index.md) — store your DocRaptor API key securely
   with the Key module and understand the data-egress caveat.

## Where it lives in the admin menu

The essential setup for DocRaptor is its **API key**, which is stored as a **Key**
entity managed at **Configuration → System → Keys**
(`/admin/config/system/keys`). See [Configuration](configuration/index.md) for the
recommended, secret-safe way to create that key.
