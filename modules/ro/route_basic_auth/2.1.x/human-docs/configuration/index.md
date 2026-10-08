# Configuration

Everything is set up on one page: **Configuration → System → Route Basic
Authentication settings**. You need the **Change the Route Basic Authentication
settings** permission to open it.

Before you begin, two ground rules that matter for every option below:

- **Serve protected routes over HTTPS.** Basic auth transmits the username and
  password base64‑encoded on every request — encoded, not encrypted — so on plain
  HTTP they are effectively exposed.
- **Prefer the Key module for the password.** Storing the password directly in the
  form puts it in plain text in site configuration, and therefore in the database,
  in config exports, and in backups. With [Key](https://www.drupal.org/project/key)
  installed you can point the password at an environment variable or a file
  outside the web root instead.

## Site‑wide credentials

- **Username** — the default username required for any protected route that does
  not define its own.
- **Password** — the default password. If you have the Key module installed you
  can instead select a **password key**; when you do, the plain password field is
  hidden and any previously stored password value is removed from configuration.
  Use a key whenever you can.

These site‑wide credentials are the fallback: any protected route without custom
credentials uses them.

## Protected routes

The routes to protect are managed in a compact table on the same page:

- **Route name** — enter the Drupal route machine name, not a URL path. For
  example `user.login` for the login form. (This is the "machine name" from
  Drupal's routing system.)
- **HTTP methods** — tick a checkbox for each method the prompt should cover
  (GET, POST, PUT, DELETE, and so on). Only the methods you check are gated.
- **Add another route** — adds a further row so you can protect several routes.
- **Custom credentials** — check this on a route to give it its own username and
  password (and, with Key, its own password key) instead of using the site‑wide
  pair.

### Defining routes in YAML instead

Routes can also be defined directly in the `route_basic_auth.settings.yml`
configuration file. As of 2.1 the format is a list; the per‑route `credentials`
mapping is optional, and without it the site‑wide credentials apply:

```yaml
protected_routes:
  - name: 'user.login'
    methods:
      - 'GET'
  - name: 'user.login.http'
    methods:
      - 'POST'
    credentials:
      username: 'login-http-user'
      password: 'login-http-password'
      password_key: ''
```

If you are upgrading from before 2.1, the stored format changed; existing
configuration is converted automatically when you run database updates
(`drush updb`).

## Flood protection

The module reuses core's `user.flood` IP limit (by default 50 failed attempts per
hour per IP). Only requests that actually supply credentials count as failed
attempts. Once an IP hits the limit, further requests from it are denied with a
403 — even with valid credentials — until the window expires, mirroring how core
handles login flooding.

If your site sits behind a reverse proxy or load balancer, configure Drupal's
reverse proxy settings in `settings.php` so the real client IP is seen. Otherwise
every request appears to come from the proxy, and the flood limit would apply to
all visitors together.

## Save

Save the form. Protected routes now present the browser's Basic auth prompt for
the methods you selected. Test one from a private/incognito window to confirm the
prompt appears and your credentials let you through.
