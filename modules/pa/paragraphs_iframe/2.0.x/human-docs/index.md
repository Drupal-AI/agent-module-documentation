# Paragraphs Iframe — manual setup guide

**Paragraphs Iframe** (`paragraphs_iframe`) is a **configuration-only** add-on
for the Paragraphs module. Rather than shipping code, it installs a ready-made
**"iframe" paragraph type** together with a required **Source** link field
(`field_iframe_source`) and its form and view displays. The idea is to give
editors a standard, reusable paragraph for capturing the URL of external content
they want to embed — a video, a map, a document viewer — without you having to
hand-build the field every time.

It's worth being clear about what this version actually renders. The Source is a
core **link** field shown through the core **link** formatter, so by default the
value is output as an ordinary, core-sanitized hyperlink — the module itself does
**not** generate any `<iframe>` markup, despite its name. If you want the URL to
render as an actual embedded iframe, you supply that formatter or theming
yourself.

That distinction matters for security. As long as you rely on the shipped link
formatter, there is no custom markup sink to worry about. But the moment you add
a formatter that drops the editor-supplied URL into a real `<iframe src="…">`,
you are embedding arbitrary external content in your pages — an admin-trust and
potential XSS consideration. In that case, treat the source URL as untrusted and
restrict who may create or edit these paragraphs to people you trust. It depends
on the core **field**, **language**, **link** and **paragraphs** modules and
supports Drupal 8 through 10.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   import the optional config that provides the iframe paragraph type and field.

There is **no configuration page** for this module — it is delivered entirely as
config (a paragraph type, a field and its displays). Setup is described below.

## Where it lives in the admin menu

The module adds no settings screen. The paragraph type it provides appears at
**Structure → Paragraph types**, and the **Source** field and its displays are
managed there under **Manage fields**, **Manage form display** and **Manage
display**.

## How to use it

1. Make sure the **Paragraphs** module is enabled.
2. Enable Paragraphs Iframe and import the optional config it ships, so the
   **iframe** paragraph type and its **Source** link field are created (see
   [Installation](installation/index.md)).
3. Add a Paragraphs field to a content type (for example a landing page) and
   allow the **iframe** paragraph type.
4. When editing content, add an **iframe** paragraph and paste the URL of the
   external content into the required **Source** field.
5. If you want the URL to display as a real embedded iframe rather than a link,
   add your own formatter/theming on the paragraph's **Manage display** — and see
   the security note above before you do.
