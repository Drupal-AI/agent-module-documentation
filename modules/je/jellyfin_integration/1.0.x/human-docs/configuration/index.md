# Configuration

You configure Jellyfin Integration by pointing it at your Jellyfin server and
giving it an API key. Everything happens on one settings form.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Media → Jellyfin Integration**, or navigate directly
   to `/admin/config/media/jellyfin`.

## The fields

- **Server URL** — the base URL of your Jellyfin server (for example
  `https://media.example.com`). This value comes only from trusted admin input, so
  make sure it points at the server you intend.
- **API key** — a Jellyfin API key you generate in the Jellyfin admin dashboard.
  The module sends it as an authorization header on every request, and also embeds
  it in the direct stream URLs it builds.
- **Test connection** — a button that verifies the server is reachable with the
  values you entered *before* they're committed. If the test fails, your previous
  settings are kept.

Enter the values, run **Test connection**, then save.

## Browsing your media

Once connected, use the sub‑pages under the same section (all requiring
**Administer site configuration**):

- **Libraries** (`/admin/config/media/jellyfin/library`)
- **Movies** (`/admin/config/media/jellyfin/movies`)
- **TV shows / series** (`/admin/config/media/jellyfin/series`)
- **Items in a library** (`/admin/config/media/jellyfin/library/{library_id}`)
- **Item detail** (`/admin/config/media/jellyfin/item/{item_id}`)

## Notes for operators

- All pages are **administrators‑only**.
- **Outbound network access (egress):** the module makes HTTPS requests from your
  Drupal server to your Jellyfin server. If you run behind an egress firewall,
  allow outbound access to your Jellyfin host, otherwise connection tests and
  browsing will fail. TLS certificate verification is left at Drupal's secure
  default (enabled).
