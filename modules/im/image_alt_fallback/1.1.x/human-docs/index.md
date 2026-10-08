# Image Alt Fallback — manual setup guide

**Image Alt Fallback** (`image_alt_fallback`) fixes empty `alt` attributes on
image fields so screen-reader users are not left with images that have no
alternative text at all. For each field you configure, it can either **fill the
empty alt with the parent entity's label** (a node title, taxonomy term name, and
so on) or **mark the image as decorative** by adding `role="presentation"`. Images
that already have a non-empty alt value are never touched.

The fix is applied at render time in a post-render callback, so **no Twig templates
need changing** and your stored content is not modified. Processing is scoped to
exactly the field wrappers you configure, so unrelated image fields on the same page
are left alone. It works with both raw image fields and entity-reference fields
pointing to Media entities, and across content types (nodes) and taxonomy terms.

A word of honesty built into the module's own docs: a label fallback is better than
an empty `alt=""` (which screen readers skip entirely), but it is **not a substitute
for meaningful, image-specific alt text**. Treat this as a safety net or a
transitional measure while you backfill real alt text at the source — ideally stored
on the File or Media entity so it travels with the asset.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside its core dependencies.
2. [Configuration](configuration/index.md) — the settings form, field by field,
   for choosing which images get a label fallback and which are marked decorative.

## Where it lives in the admin menu

Once enabled, the settings form sits at **Configuration → Media → Image Alt
Fallback** (`/admin/config/media/image-alt-fallback`). The module also ships a
**Media Alts** view at **Content → Media Alts** (`/admin/content/media-alts`) — a
tab alongside the core Media list that lets editors browse all media, filter by alt
status (empty / not empty), type, language and published status, and jump straight
to editing any item.

## How to use it

The intended workflow is: enable the module, open the settings form, pick a global
default behavior, and then choose per-field how each image field should be handled.
See [Configuration](configuration/index.md) for the details.
