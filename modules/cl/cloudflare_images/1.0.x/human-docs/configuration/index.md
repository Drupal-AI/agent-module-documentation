# Configuration

The settings form tells the module which Cloudflare account to talk to and, just
as importantly, *which environment* should do the offloading.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → Cloudflare Images → Settings**, or navigate directly to
   `/admin/config/cloudflare_images/settings`.

## The fields

- **Site host** — the Drupal host that turns the functionality on (for example
  `example.pantheonsite.io`). The module only uploads images and rewrites URLs
  when the current request host matches this value. This is the switch that keeps
  offloading limited to production: on any other host, images are served locally
  as normal.
- **Site name** — used as an image‑namespace prefix. Combined with each image's
  path it forms a stable Cloudflare image ID (`{site_name}/{image_path}`), giving
  each site its own namespace within your Cloudflare account.
- **Cloudflare Account ID** — your Cloudflare account identifier.
- **Account Hash** — the account hash used in the delivery URL
  (`https://imagedelivery.net/{hash}/…`).
- **API Token** — a Cloudflare API token with permission to manage Cloudflare
  Images.

## Save

Click **Save configuration**. From then on, when an `image`‑bundle media entity is
saved on the matching host, the file is POSTed to the Cloudflare Images API (over
HTTPS, with a bearer token), and its rendered URL is rewritten to the
`imagedelivery.net` delivery URL requesting the `public` variant. Deleting the
entity removes the image from Cloudflare.

## Important cautions

- **The API token is stored in plain module configuration**
  (`cloudflare_images.settings`), together with the account hash. Before you export
  and commit configuration, review it — those secrets will be in it. Consider
  overriding the values per environment in `settings.php` (for example with
  `getenv()` reading a DDEV‑managed environment variable) so the real token does
  not land in the repository.
- **There is no local fallback.** If the delivery URL is wrong or the asset is
  missing on Cloudflare, the image 404s rather than falling back to a local copy.
- **Only the `public` variant is served** — this version does not support signed /
  private image URLs or other Cloudflare variants.
- **No bulk migration UI.** Only images saved after configuration are offloaded;
  syncing is incremental, one entity save at a time.
