# Configuration

GGL Map comes with a full set of default map settings, so the **only setting you
have to provide is a Google Maps API key**. Everything else about a given map is
controlled per map through the render array's `#overrideSettings`, not through a
central admin form.

## Get a Google Maps API key

In the Google Cloud console, create a project, enable the **Maps JavaScript API**
(and any related APIs you use, such as Places for location search), and create an
API key. Before using it in production, **restrict the key**:

- Set an **HTTP‑referrer (website) restriction** to your own domain(s). This is
  important — an unrestricted key that leaks can be used by anyone and billed to
  your account.
- Restrict the key to only the Google Maps APIs you actually need.

## Open the configuration page

1. Log in as a user with permission to administer site configuration.
2. Open the module's configuration page — use the **Configure** link next to GGL
   Map on the **Extend** page (**Administration → Extend**), or find it under
   **Configuration**.

## The setting

- **Google Maps API key** — paste the key you created above. This is what lets the
  map load Google's Maps JavaScript. Without a valid key the map area stays blank.

Because this key is billable, avoid committing it to your repository in exported
configuration. Keep it in an environment variable and reference it, and restrict
the key by HTTP referrer as described above so a leaked value can't be abused.
With DDEV you can store it out of version control:

```bash
ddev dotenv set .ddev/.env --google-maps-api-key=<your-key>
ddev restart
```

That makes it available as `GOOGLE_MAPS_API_KEY` in the container for you to
reference. Keep `.ddev/.env` out of version control.

> **Third‑party JavaScript:** rendering a GGL map loads Google's Maps JavaScript
> into the page. Bear that in mind for privacy, consent, and content‑security‑policy
> purposes.

## Per‑map settings

Beyond the API key, you tune each individual map when you render it — passing an
`#overrideSettings` array to the `ggl_map` theme to change zoom controls,
clustering, "fit to markers", popup behaviour, current‑location search, and so on.
The **GGL map examples** module (see [Installation](../installation/index.md))
shows these override options in a working context.
