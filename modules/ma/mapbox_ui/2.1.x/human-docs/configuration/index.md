# Configuration

Set up the map once on the settings form, then place the block. Everything about
the map — token, style, center, marker, zoom — is configured here, site-wide.

## Open the settings form

Go to `/admin/config/mapbox_ui/config`. You need the **Administer site
configuration** permission.

> **Path note:** the module's README lists `/admin/config/mapbox/config`, but the
> working route is `/admin/config/mapbox_ui/config`. Use the latter.

## The settings

- **Access token** — your Mapbox public token (`pk.…`). See the security note
  below.
- **Style** — the Mapbox style to use, given as a style URL or id (for example a
  built-in `mapbox://styles/mapbox/streets-v11`, satellite, or your own Mapbox
  Studio style).
- **Center latitude / longitude** — the coordinates the map opens on.
- **Marker** — the coordinate where a marker is dropped.
- **Popup text** — text shown in the marker's popup.
- **Zoom** — the initial zoom level.
- **Navigation controls** — whether to show Mapbox's zoom/rotate controls.

> **Known bug in this version:** the navigation-control checkbox is saved under a
> mis-keyed config name (with leading spaces), so this toggle may not persist as
> you'd expect. If the controls don't behave as set, this is why — treat the
> toggle as unreliable until the module fixes it.

### Protect the access token

The token is a **public, client-side token** — Mapbox GL runs in the browser, so
the token appears in page JavaScript by design. That's expected, not a leak. Still:

- **Use a URL-restricted public (`pk.`) token**, restricted to your domain in the
  Mapbox dashboard. **Never** use a secret (`sk.`) token here.
- **Keep it out of version control.** Store it in an environment variable and set
  the config from there. With DDEV:

  ```bash
  ddev dotenv set .ddev/.env --mapbox-access-token=YOUR_PK_TOKEN_HERE
  ddev restart
  ```

  That exposes it as `MAPBOX_ACCESS_TOKEN` in the container (keep `.ddev/.env` out
  of version control); reference it from `settings.php` via
  `getenv('MAPBOX_ACCESS_TOKEN')` to override the stored value.
- Remember that map loads are billed against your Mapbox plan and send visitor
  requests to Mapbox — a cost and privacy consideration.

## Save, then place the block

1. **Save** the settings form.
2. Go to **Structure → Block layout** (`/admin/structure/block`) and **Place
   block** in the region you want.
3. Find and place the **Mapbox block**. It's visible to anyone with **Access
   content**.
4. Save the block.

The single site-wide map configuration is reused across every placement of the
block.
