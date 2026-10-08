# Configuration

To use Mercure you need to tell Drupal two things: **where your Mercure hub is**
(its URL) and **the JWT secret** used to sign publisher tokens. The precise
configuration keys are documented in the module's `README` on
[drupal.org](https://www.drupal.org/project/mercure) — this page focuses on the part
that matters most: handling that secret safely.

## The two things Mercure needs

- **Hub URL** — the address of your running Mercure hub, over **HTTPS/WSS** in
  production. Drupal publishes updates to this endpoint.
- **JWT secret / key** — the secret that signs the *publisher* JWT. Whoever holds
  this key can publish to **any** topic on your hub, so treat it like a password. If
  you use private topics, also make sure subscribers are properly authorised (the
  hub enforces subscriber JWTs).

## Store the JWT secret as a secret — never in code or config export

Do not paste the JWT secret into a settings form value that ends up in a
version‑controlled config export, and never hard‑code it. Keep it in an environment
variable and read it from there.

With DDEV, save it to the project's dotenv file and restart so the web container
picks it up:

```bash
ddev dotenv set .ddev/.env --mercure-jwt-secret=<value>
ddev restart
```

The flag `--mercure-jwt-secret` becomes the environment variable
`MERCURE_JWT_SECRET`. Keep `.ddev/.env` out of version control.

### Expose it to Drupal through a Key entity

Where the module accepts a [Key](https://www.drupal.org/project/key) entity for the
secret, prefer that over a raw value. Install Key if it is not already enabled:

```bash
ddev composer require drupal/key
ddev drush en key -y
```

Confirm the variable is present in the container **without printing its value**:

```bash
ddev exec 'test -n "$MERCURE_JWT_SECRET"'   # exit status 0 means it is set
```

Then create a Key backed by the environment provider:

```bash
ddev drush key:save mercure_jwt_secret \
  --label='Mercure JWT Secret' \
  --key-type=authentication \
  --key-provider=env \
  --key-provider-settings='{"env_variable":"MERCURE_JWT_SECRET","base64_encoded":false,"strip_line_breaks":true}' \
  --key-input=none -y
```

If the module does not support a Key entity for a particular value, reference the
environment variable directly from `settings.php` with `getenv('MERCURE_JWT_SECRET')`
rather than storing the literal secret in config.

## Network egress and transport

Because Drupal makes outbound requests to the hub, make sure your environment
allows that egress to the hub's host and port. Always use **HTTPS/WSS** so the
tokens and payloads are not sent in the clear.

## Save and test

Once the hub URL and secret are in place, publish a test update from your code and
confirm a subscribed client receives it in real time. If publishing is rejected,
the JWT secret Drupal is using almost certainly does not match the one your hub
expects.
