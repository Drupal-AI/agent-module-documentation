# Configuration

Setting up CKEditor file to media swapper has two parts: enabling the **Convert to
Media** button in a text format, and tuning the module's **security settings**.
Both are optional to *view*, but the text‑format step is required before the
button appears to editors.

## 1. Add the button to a text format

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`).
2. Edit a text format that uses **CKEditor 5** (for example *Full HTML*).
3. In the toolbar configuration, drag the **Convert to Media** button from the
   available buttons into your active toolbar.
4. Make sure the format **allows** the tags the module needs:
   - `<img>` with `src`, `alt`, `width`, and `height` attributes.
   - `<drupal-media>` with `data-entity-type`, `data-entity-uuid`, and
     `data-view-mode` attributes (this is what conversions produce).
5. Click **Save configuration**.

Editors using that format now see the **Convert to Media** button in CKEditor 5.

## 2. Security settings

Open **Configuration → Media → File to Media Swapper**
(`/admin/config/media/file-to-media-swapper/settings`). This form controls how
the module handles conversions — especially the riskier remote‑URL imports:

- **Remote downloads** — whether the module may import images from external URLs
  at all. Leave this off unless you specifically need to pull in remote images.
- **Require HTTPS** — when enabled, only `https://` remote URLs are accepted,
  rejecting plain‑HTTP sources.
- **Allowed domains** — an allow‑list restricting which external domains remote
  files may be downloaded from. Anything not on the list is refused.
- **Allowed extensions / blocked types** — the file extensions and MIME types
  permitted on import; dangerous types are rejected.
- **Size, redirect, and timeout limits** — caps on remote file size, the number of
  redirects followed, and how long a download may take, to keep imports safe and
  bounded.
- **Disable batch processing** — a global switch that turns off the bulk batch
  tool site‑wide.

Adjust the values to match your policy and click **Save configuration**.

## 3. Permissions

Grant the module's permissions at **People → Permissions**
(`/admin/people/permissions`) to the appropriate roles:

- The conversion API needs the core **create media** and **update media**
  permissions, so editors who convert content should have those.
- The bulk batch tool is gated behind the restricted **access batch media
  swapper** permission — give it only to trusted administrators.

## Running conversions

Once the button and permissions are in place, editors convert images (and, with
Linkit, file links) directly in CKEditor. For existing content, use the batch tool
under **Content → Media** — but **back up your database first**, since it rewrites
the markup stored in your fields.
