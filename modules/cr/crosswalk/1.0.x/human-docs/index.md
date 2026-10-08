# Crosswalk — manual setup guide

**Crosswalk** (`crosswalk`) integrates Drupal with the external **crosswalk** CLI
tool to convert scholarly metadata between formats. If your site handles citations
or bibliographic data — the sort of work academic, library, and repository sites do
— Crosswalk lets you transform that metadata using the crosswalk tool rather than
hand-rolling conversions.

The two primary things it's built for are:

- **Rendering schema.org JSON-LD** in your node view HTML, so your scholarly content
  carries structured metadata that search engines and other tools understand.
- **Rendering citations** for scholarly content.

Because it drives an external command-line tool, Crosswalk has an important
environment prerequisite: the **crosswalk CLI binary must be installed and on your
web server's PATH**. It also needs RDF mappings for the content you want to render —
or, alternatively, a crosswalk profile you create manually for your content
type(s). It depends on core's **Serialization** module (`serialization`) and
supports Drupal 10 and 11.

This is developer/integrator-oriented plumbing rather than a point-and-click
feature: there's no settings form to fill in, and the real work is in getting the
CLI binary in place and defining the mappings or profiles.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and put the crosswalk CLI binary in place.

There is no configuration page for this module. Setup is a matter of the CLI binary
and your RDF mappings/profiles, described under "How to use it" below.

## How to use it

1. Install the **crosswalk CLI binary** on your web server and make sure it's on the
   server's PATH (so PHP can invoke it). This is an external, non-Drupal dependency.
2. Provide **RDF mappings** for the content you want to render — or manually create a
   **crosswalk profile** for the relevant content type(s).
3. With the module enabled, Crosswalk can then render schema.org JSON-LD into your
   node view HTML and produce citations for your scholarly content using the CLI
   tool.
