# Yext Search — manual setup guide

**Yext Search** (`search_api_yext`) provides a Search API backend that pushes your
Drupal content to **Yext's Knowledge Management platform**, keeping the two in
sync. When items are indexed, the module automatically pushes them to Yext; when
Drupal content is deleted, it deletes the matching items from Yext. It uses Yext's
Connector (Push) API for efficient bulk indexing and deletion.

The module is aimed at organisations that want their Drupal content available in
Yext for enhanced search experiences and knowledge management across multiple
digital properties. Each Search API index can specify its own Yext connector name,
so different indexes can push to different connectors, and the field mapping and
transformations are handled by the Yext Push API connectors themselves. It works
with any Drupal entity type — nodes or custom entities — and handles multilingual
content with proper language tagging.

Two scope limits are important to know up front: this module supports **only the
Yext Push API, not the Yext Search API**, and there is **no Views integration** —
its role is to push content to Yext, not to render Yext search results inside
Drupal.

This module does **not** work on enable alone. It depends on **Search API** and on
the **Key** module (`key`), which it uses to store the Yext API credentials, and
it requires **Drupal 10.2 or 11**. Note that this module's stable release is not
covered by Drupal's security advisory policy — factor that into your risk
assessment. Because it sends your content and queries to the Yext API over HTTPS,
confirm that external egress to Yext is acceptable for your content, and respect
Search API access so indexed content is not exposed unintentionally.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   pull in Search API and Key, and enable it.

## How to use it

After enabling, first store your Yext API credentials as a **Key** entity
(**Configuration → System → Keys**). Then create a Search API **server** on the
Yext backend and a Search API **index** under **Configuration → Search and metadata
→ Search API**, choosing which content types and fields to push. Set the Yext
connector name on the index. When you index content it is pushed to Yext; deleting
content in Drupal removes it from Yext. The module's own `README.md` carries the
detailed field-mapping and connector configuration instructions.
