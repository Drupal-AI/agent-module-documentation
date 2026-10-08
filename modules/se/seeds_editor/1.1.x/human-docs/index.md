# Seeds Editor — manual setup guide

**Seeds Editor** (`seeds_editor`) is the editor layer of the Seeds
distribution: a pre-assembled CKEditor 5 configuration with text formats, media
embedding, link enhancement, and right-to-left support already wired together.
Instead of installing and reconciling a dozen editor-related modules by hand, you
enable one module and get a known-good authoring experience out of the box.

Putting together a good CKEditor 5 experience in Drupal is mostly integration
work. You want Linkit for internal links, Entity Embed for media, Editor Advanced
Link for link attributes, a plugin pack for the toolbar buttons core leaves out,
responsive tables, media resizing, Blazy for lazy-loaded images, Smart Trim for
teasers, and Allowed Formats to stop editors picking the wrong text format. Each
of those is a separate module with its own configuration. Seeds Editor is that
whole assembly, done once. Its dependency list is the honest description of what
it is: **seventeen modules**, most of them contrib. Enabling it pulls in the
entire set and applies a configuration that expects them all to be present.

That is the trade to weigh. On a Seeds site — or a fresh build that wants a
known-good editor from day one — it saves real time and gives every environment
the same setup. On an existing site that already has its own text formats, it is
a large and opinionated footprint that will need reconciling with what is already
there, and seventeen dependencies means seventeen upgrade paths to keep an eye on.
The right-to-left handling (via `ckeditor_bidi`) is the piece that is genuinely
hard to retrofit later, so it is worth noting if your site has Arabic, Hebrew, or
Persian content. A single permission, **Administer Seeds editor**
(`administer seeds editor`), gates its settings page.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its
   dependencies with Composer, and enable it.
2. [Configuration](configuration/index.md) — where the settings form lives and
   what it governs.

## Where it lives in the admin menu

Once enabled, the module's own settings form sits at **Configuration → Content
authoring → Seeds Editor** (`/admin/config/content/seeds-editor`), reachable by
anyone with the *Administer Seeds editor* permission. The text formats and
CKEditor toolbar it configures appear wherever you edit rich-text content — the
body of a node, a formatted-text field, and so on.
