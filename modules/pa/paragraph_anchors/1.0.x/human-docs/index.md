# Paragraph Anchors — manual setup guide

**Paragraph Anchors** (`paragraph_anchors`) automatically gives each paragraph on a
page a stable, URL‑safe **anchor ID**, so individual sections can be deep‑linked.
On a long landing page built from paragraphs, that means you can link straight to
"#pricing" or "#faq" instead of just to the top of the page — and, if you turn it
on, visitors and editors get a small **"copy link" button** on each section that
copies a direct link to that paragraph to the clipboard.

The anchor is generated for you. When a paragraph is saved, the module looks
through a prioritised list of "title‑like" source fields (by default
`field_title`, `field_heading`, `field_name`, `field_label`, `title`) and turns the
first one that has a value into a URL slug, storing it in a read‑only tracking
field called **Generated Anchor ID**. If none of those fields has a value it falls
back to the paragraph's UUID, so an anchor always exists. If two paragraphs on the
**same page** would produce the same slug, a numeric suffix (`--2`, `--3`, …) is
added to keep the HTML IDs unique; identical titles on unrelated pages are left
alone, since those are not real ID collisions.

Editors never type the anchor by hand — the Generated Anchor ID field is shown on
the paragraph edit form but is greyed out and disabled, with a hint like *"Use
#your-slug-here to link here."* Each paragraph also gets a small **Copy anchor link
button** selector (*Use site default / Always show / Always hide*) so an editor can
force the copy‑link button on or off for one specific component regardless of the
site‑wide default.

The module depends only on **Paragraphs** and supports Drupal 10, 11 and 12.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — choose which paragraph bundles get
   anchors, set the source‑field priority, and control the copy‑link button.

## Where it lives in the admin menu

Paragraph Anchors adds a settings form at **Configuration → Content → Paragraph
Anchors** (`/admin/config/content/paragraph-anchors`), reached by users with the
**Administer Paragraph Anchors settings** permission. Anchors themselves show up on
your paragraph **edit forms** (the read‑only Generated Anchor ID field) and, when
enabled, as the copy‑link button on rendered paragraphs on the front end.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Open the settings form and tick the **paragraph bundles** that should get
   anchors. This attaches the Generated Anchor ID field and the per‑instance copy
   button override to those bundles.
3. Adjust the **source fields** list if your title fields differ from the defaults,
   and decide whether the copy‑link button should show by default.
4. Review the two **permissions** (settings access, and who sees the copy‑link
   button) at **People → Permissions**.

Full field‑by‑field detail is in [Configuration](configuration/index.md).
