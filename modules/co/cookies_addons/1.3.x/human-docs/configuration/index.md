# Configuration

Cookies Addons has no single settings page. Instead, each submodule is configured in
its own place, so first enable the submodule you need (see
[Installation](../installation/index.md)), then set it up as below. In every case the
consent gating works together with the **COOKiES** module, so make sure the matching
service is defined in your COOKiES configuration.

## Submodules with their own settings page

These are configured at **Configuration → System**:

- **Blocks** (`cookies_addons_blocks`) — at `/admin/config/system/cookies-addons-blocks`.
  Choose which Drupal blocks (by block ID) to gate; they load once consent is given.
- **Paragraphs** (`cookies_addons_paragraphs`) — at
  `/admin/config/system/cookies-addons-paragraphs`. Choose which paragraphs (by
  paragraph ID) to gate.
- **Views** (`cookies_addons_views`) — at `/admin/config/system/cookies-addons-views`.
  Choose which views (by view ID and display ID) to gate.

## Submodules configured in text formats

- **Embed Iframe** (`cookies_addons_embed_iframe`) — enable the plugin in the
  settings of the **text format** where you want iframes blocked until consent
  (Configuration → Content authoring → Text formats and editors).
- **Embed Video** (`cookies_addons_embed_video`) — enable the plugin in your text
  format to block video iframes such as YouTube and Vimeo.

## Submodule configured per field

- **Fields** (`cookies_addons_fields`) — configure this per field in the **display
  settings** of the entity (for example on a content type's *Manage display*). Use it
  to gate an individual field such as a map field or an external widget.

## How consent gating behaves

Until the visitor consents to the matching service, the gated content is replaced by
a placeholder with a consent overlay; once consent is given, the content loads. This
keeps third‑party content — and the cookies and trackers it brings — from loading
before consent, which is the module's whole privacy purpose. As with COOKiES itself,
no legal‑compliance guarantee is implied; verify each gated item behaves as you
expect for a non‑consenting visitor.
