# Configuration

Configuration is short: enter your Mapbox access token, choose a default map
style, and check the preview. These values are then available to every module
that builds on the base Mapbox module.

## Open the settings form

Go to **Configuration → Web services → Mapbox**
(`/admin/config/services/mapbox`). You need the **Access administration pages**
permission.

## Access token

Paste your **Mapbox access token** here. This is the credential Mapbox GL JS uses
to load map tiles and styles in the browser.

### About the token and how to protect it

The token is a **publishable, client-side token** — Mapbox GL JS runs in the
visitor's browser, so the token is placed into the page's JavaScript by design.
That is expected and is not a server secret being leaked; this module makes no
server-side HTTP calls. Even so, treat it with care:

- **Use a public token scoped to what you need**, and restrict it (for example
  with URL restrictions) in your Mapbox account dashboard, so it can't be reused
  elsewhere to run up your usage.
- **Never commit a token to version control.** Store it in an environment
  variable and set the config from there. With DDEV:

  ```bash
  ddev dotenv set .ddev/.env --mapbox-access-token=YOUR_TOKEN_HERE
  ddev restart
  ```

  That exposes it as `MAPBOX_ACCESS_TOKEN` inside the container (keep
  `.ddev/.env` out of version control); reference it from `settings.php` via
  `getenv('MAPBOX_ACCESS_TOKEN')` to override the stored value.
- Remember that loading maps sends visitor requests to Mapbox, and that map loads
  are billed against your Mapbox plan — a privacy and cost consideration for
  high-traffic pages.

## Map style

Choose the default **map style** from the built-in list:

- **Streets**, **Outdoors**, **Light**, **Dark**, **Satellite**, **Satellite
  Streets**, and **Navigation Day / Night**.

If you don't choose one, the module falls back to Mapbox **Streets**
(`streets-v11`). This becomes the default style that dependent modules use unless
they override it.

## Live preview

The settings page renders a **live preview** of the selected style using your
token, so you can see the result immediately — and confirm the token is valid —
before saving for good.

## Save

Click **Save configuration**. The token and style are stored in `mapbox.config`
and become available through the `mapbox` service to any module built on it. When
your token rotates, update it here in one place and every dependent map picks up
the change.
