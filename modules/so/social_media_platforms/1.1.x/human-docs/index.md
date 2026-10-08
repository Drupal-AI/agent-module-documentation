# Social Media Platforms — manual setup guide

**Social Media Platforms** (`social_media_platforms`) puts a site's own social
profile links into a configurable block — the familiar row of icons in a footer
pointing at the organisation's Facebook, LinkedIn, YouTube and other pages. You
set the URLs in a configuration form and place the block wherever you want the
icons to appear.

It is worth being clear about which kind of "social" module this is, because the
distinction matters. This one links **out to the organisation's own profiles** —
it does not add share buttons for a visitor to share your content. That
difference is entirely about privacy: share widgets load third-party scripts that
track visitors the moment the page loads and therefore need a consent banner,
whereas profile links are ordinary anchors that load nothing and need no consent.
The alternatives to a module like this are hard-coding the row into a template
(so changing a URL means a deploy) or a custom block of pasted HTML (editable, but
with no structure, no validation and inconsistent icons) — a configuration form
plus a block is the right size for the problem.

The module depends on core's **Block** module, runs on Drupal 10.2 and 11, and is
configured at `/admin/config/services/social-media-platforms` behind the
**administer social media platforms** permission. That permission is deliberately
*not* marked as restricted, which is reasonable here since its holder can only set
outbound profile URLs — though keep in mind those URLs appear on every page where
the block is placed, so grant it to people you'd trust with the site's public
branding.

This guide is written for a **human** setting the links up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — entering your profile URLs and
   placing the block.

## Where it lives in the admin menu

The settings form sits at **Configuration → Web services → Social Media
Platforms** (`/admin/config/services/social-media-platforms`). The icon row
itself is a block you place through **Structure → Block layout**.
