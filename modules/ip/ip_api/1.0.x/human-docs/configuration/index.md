# Configuration

IP API has one small settings form at **Configuration → System → IP API**
(`/admin/config/system/ip-api`, route `ip_api.settings_form`). Opening it
requires the restricted *Administer ip_api configuration* permission — grant it
only to trusted administrators.

## The setting

- **API key** (`ip_api_key`) — optional.
  - **Leave it blank** to use the free `ip-api.com` tier.
  - **Enter a key** to use the paid `pro.ip-api.com` host, which the module then
    targets automatically.

Click **Save configuration**.

## Important: calls are made over plain HTTP

This is the key thing to understand before setting an API key. The module
contacts ip-api.com over **unencrypted `http://`**, not HTTPS:

- With no key: `http://ip-api.com/json/<ip>`
- With a key: `http://pro.ip-api.com/json/<ip>?key=<YOUR_KEY>`

Because the transport is not encrypted, **your API key and the geolocation
results travel in clear text** and can be observed on the network. If that matters
for your deployment:

- Consider whether the free (keyless) tier is enough, so no secret is transmitted.
- If you must use a paid key, front the outbound request with your own HTTPS proxy
  so the key is not exposed on the wire, and be prepared to rotate the key if it
  leaks.

## Accuracy behind a proxy

The module looks up the client IP that Drupal computes for the request and
interpolates it into the request URL. If your site is behind a reverse proxy or
CDN, configure Drupal's **trusted‑proxy / trusted‑host** settings in
`settings.php` so the real visitor IP is used. Without that, a misconfigured proxy
could let a spoofed `X-Forwarded-For` header influence the outbound lookup.
