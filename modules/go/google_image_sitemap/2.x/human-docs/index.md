# Google Image Sitemap — manual setup guide

**Google Image Sitemap** (`google_image_sitemap`) generates a specialized XML
sitemap that lists your site's images, giving Google and other search engines the
metadata they need to index visual content and surface it in image search. If images
are how people find your content — think e‑commerce, travel, or photography — this
helps make sure those images aren't invisible to crawlers.

You choose which **content types** to include, so you have granular control over what
gets indexed, and you can optionally attach **license** information to the images to
document usage rights. The module follows Google Search Central's guidelines for
image sitemaps, and you can regenerate the sitemap as you add or change content.

It's a straightforward SEO feature with no unusual security surface. One thing worth
checking: make sure the content you include contains only **public** images intended
for indexing — a sitemap should not list private or access‑restricted image URLs.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — choose content types, add optional
   license info, generate the sitemap, and submit it to Google.

## Where it lives in the admin menu

The settings page is at **Configuration → Search and metadata → Google Image
Sitemap**. That's where you select content types, add license details, and generate
the sitemap.
