# CKEditor 5 Custom Headings — manual setup guide

**CKEditor 5 Custom Headings** (`ckeditor_custom_headings`) lets you add your own
heading options to CKEditor 5's Heading dropdown, beyond the standard H2–H6. Each
custom heading is a tag plus an optional CSS class and a friendly label, so editors
can pick, say, "Custom heading (h2)" and get an `<h2 class="custom-heading-2">`
without ever leaving the editor or knowing any HTML.

This is useful when your theme has named heading styles — a section lead, an
eyebrow, a callout title — that map to a real heading tag with a class. Rather than
teaching editors to apply classes by hand, you define the options once per text
format and they appear in the same dropdown they already use for headings.

It depends only on core CKEditor 5 and has no central settings page — the custom
headings are configured per text format, in the CKEditor 5 plugin settings, once
the Heading button is on that format's toolbar. Because the headings become markup
with classes, make sure the text format's allowed HTML permits the tags and classes
you configure, and keep the allowed attributes reasonable.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — enable custom headings on a text
   format and define your heading options.

## Where it lives in the admin menu

Custom Headings has no standalone settings page. You configure it per text format
at **Administration → Configuration → Content authoring → Text formats and
editors** (`/admin/config/content/formats`), under the CKEditor 5 plugin settings,
described in [Configuration](configuration/index.md).
