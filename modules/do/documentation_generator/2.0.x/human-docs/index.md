# Documentation generator — manual setup guide

**Documentation generator** (`documentation_generator`) helps you produce a
written user guide that describes how your site is set up. Instead of
hand-writing an onboarding or handover document every time the site changes, it
walks the site's configuration — content types, fields, enabled modules and
other structural details — and assembles that information into a single reference
page. From there it can export the result to a Word (`.docx`) or PDF file.

The heavy lifting is done by a set of plugins, each of which contributes one part
of the generated document. Because the output is plugin-based, developers can add
their own plugins (modelled on the samples that ship with the module) to cover
extra areas they want documented. Out of the box you get a combined view that
makes it easier for a new team member to understand the site's content
architecture.

One thing to keep in mind: the generated documentation intentionally reveals
sensitive operational detail about the site — which content types and fields
exist, which modules are enabled, and how things are configured. That is exactly
what makes it useful for a handover, and exactly why you should treat it as
internal. The module gates the generation with its own permission, so grant that
permission only to trusted administrators and never publish the generated files
somewhere public. It has no role in controlling access to your content; it simply
reads configuration to describe it.

The module works as soon as it is enabled — there is no settings form to fill in
first. You enable it, grant the permission, and generate.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no settings form.
You generate documentation from its own admin page (see below) rather than
configuring behavior in advance.

## Where it lives in the admin menu

Once enabled, the module adds an administration page from which you trigger
generation and then export the result. Because generating and viewing the
documentation exposes the site's structure, the page is protected by the
module's own permission — grant it only to administrators you trust with that
detail.

## How to use it

1. Enable the module and grant its documentation permission to the administrator
   role (see [Installation](installation/index.md)).
2. Open the module's generation page from the admin menu.
3. Generate the documentation. The module reads the current configuration and
   assembles the combined reference.
4. Export the result to Word (`.docx`) or PDF if you want a portable copy to
   store with your project's handover records.
5. Keep the exported file somewhere private — it describes how the site is built.
