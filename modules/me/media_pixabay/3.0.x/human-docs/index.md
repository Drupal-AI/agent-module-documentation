# Media Pixabay — manual setup guide

**Media Pixabay** (`media_pixabay`) lets editors search the **Pixabay** stock‑image
service from inside Drupal and import the images they pick as reusable image media
entities. It adds a **Pixabay widget to an Entity Browser**: editors search by
keyword in a modal, choose from the results, and the selected images are downloaded
server‑side and saved into your media repository — ideal for bloggers, agencies,
and portals that need royalty‑free images without leaving the Drupal editing
experience. (All Pixabay images are released under Creative Commons CC0.)

It doesn't embed anything remotely; each chosen image is fetched and stored as a
local image media entity, attributed to the importing user. You can pick the
download resolution, restrict imported files to the media type's allowed
extensions, store files under a configurable path (tokens supported, e.g.
`public://Pixabay/[PIXABAY_SEARCH_TERM]/`), and it tags imported images' alt text
with the tags Pixabay returns. Search results are cached for 24 hours per term to
respect Pixabay's API rate limits.

To use it you need a **Pixabay API key**, entered once on the module's settings
page. A couple of practical notes: the module makes **server‑side calls out to the
Pixabay API** (over TLS, verification enabled by default), so your environment
needs outbound HTTPS to `pixabay.com`; and the images that get downloaded come from
the URLs in Pixabay's own API response, not from anything a user types, which keeps
the download surface bounded. It depends on core's **Media** module and the
**Entity Browser** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   (with its Entity Browser dependency).
2. [Configuration](configuration/index.md) — register a Pixabay API key, enter it,
   and add the widget to an Entity Browser.

## Where it lives in the admin menu

Its settings page sits at **Configuration → Media → Pixabay**
(`/admin/config/media/pixabay`), and is gated by the **Administer Pixabay
settings** permission.
