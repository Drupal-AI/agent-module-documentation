# Configuration

Configuration is a single field — the API key — but getting the key's *restrictions*
right matters as much as entering it.

## 1. Get a Google Maps API key

1. In the [Google Cloud console](https://console.cloud.google.com/), create (or
   reuse) a project and enable the specific web service APIs you plan to call
   (Geocoding, Directions, Distance Matrix, Elevation, Geolocation, Time Zone).
2. Create an **API key** under **APIs & Services → Credentials**.

## 2. Enter the key in Drupal

1. Go to **Configuration → Web services → Google Maps Services**
   (`/admin/config/services/google-maps-services`).
2. Paste your key into the **API key** field.
3. **Save**.

## 3. Restrict and protect the key

Each Google Maps request is billed, so a leaked, unrestricted key can be abused and
run up your quota. Protect it:

- **Restrict the key in the Google Cloud console** — limit it by HTTP referrer or IP
  address, and restrict it to *only* the APIs this integration actually uses. This is
  especially important for any key that could be exposed client‑side.
- **Operate over HTTPS** for all requests.
- Prefer keeping the key in an **environment variable** rather than committing it into
  version‑controlled configuration. With DDEV you can store such a value out of the
  repository using its dotenv support:

  ```bash
  ddev dotenv set .ddev/.env --google-maps-api-key=<your-key>
  ddev restart
  ```

  Then reference `getenv('GOOGLE_MAPS_API_KEY')` from `settings.php` when overriding
  the module's configuration, so the secret stays out of the database export and the
  repo.
- If the key is ever exposed, **rotate it** in the console.

Once saved, other code on your site can use the module's service to call the Google
Maps web services with this key.
