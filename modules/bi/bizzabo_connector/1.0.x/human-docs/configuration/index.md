# Configuration

All configuration forms require the **Administer site configuration** permission.

## 1. Set the API base URL and bearer key

Go to **`/admin/config/eventapi/baseUrl`**. Enter:

- **The events API base URL** — the Bizzabo endpoint the module fetches from.
- **The bearer authentication key** (`auth_key`) — used in the
  `Authorization: bearer <auth_key>` header on each API request.

Both values are saved in the `bizzabo_connector.baseurl` configuration object.

**Handle the key as a secret.** The module stores `auth_key` as a plain-text
config value, which means it will appear in exported configuration. To keep the
raw key out of version control, supply it from an environment variable instead:

```bash
ddev dotenv set .ddev/.env --bizzabo-auth-key=<value>
ddev restart
```

(Never commit `.ddev/.env`.) Then feed the value into the module's config from an
environment variable — for example via a config override in `settings.php` reading
`getenv('BIZZABO_AUTH_KEY')`, or through a Key entity — rather than typing the raw
key into the form and committing it.

## 2. Test the connection

Go to **`/admin/config/test_connection`** to validate that the base URL and key
work. The form echoes back masked response parameters so you can confirm the API
is reachable without exposing the full payload.

## 3. Surface the events listing

The rendered, paginated events listing is served at **`/bizabo/fetch/events`**
(handled by `getDisplayEvents`). Link visitors to it, or place a link to it in a
menu or landing page. Each event row maps Bizzabo fields such as start/end dates,
venue, and city/state/timezone into the display.

## Two things to review before launch

- **The listing is public.** The route `/bizabo/fetch/events` is declared
  `_access: "TRUE"`, so anyone — including anonymous visitors — can reach the
  fetched event list. The test-connection route (`/admin/config/api/param`) is
  likewise open. Confirm that exposing this data publicly is what you intend.
- **Caching.** The events listing currently renders with a max-age of 0 (no
  caching), so every request re-fetches from Bizzabo. Keep that in mind for
  performance and API rate limits on a high-traffic page.
