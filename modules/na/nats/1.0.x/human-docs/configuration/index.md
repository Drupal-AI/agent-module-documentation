# Configuration

NATS Integration is configured entirely in **`settings.php`** — there is no admin
settings form. You define one or more **named client configurations**, each
describing how to reach a NATS server, and your code then asks the module's
service for a client by name.

## Define named client configurations

Add your NATS connection settings to `settings.php`. Each named entry holds the
connection details (such as the server host/URL, port, and any authentication)
for one NATS server or profile. Using named configurations means a single site
can connect to several NATS servers, or keep separate profiles, and select the
right one by name in code.

Because the exact array shape belongs to the module and the underlying
`basis-company/nats.php` library, follow the module's own README for the precise
keys. The important principle for this guide is **where** the configuration lives
(in `settings.php`) and **how to keep its secrets safe**, covered next.

## Keep credentials out of code

NATS server URLs and credentials are secrets — do not hard‑code them in a file you
commit. Store them in **environment variables** and read them into your
`settings.php` configuration with `getenv()`.

With DDEV, save the values with the built‑in dotenv command:

```bash
ddev dotenv set .ddev/.env --nats-server-url=<value> --nats-password=<value>
ddev restart
```

Keep `.ddev/.env` out of version control. Then, in `settings.php`, reference the
variables rather than literal values, for example:

```php
$settings['nats']['default']['host'] = getenv('NATS_SERVER_URL');
$settings['nats']['default']['password'] = getenv('NATS_PASSWORD');
```

(The exact setting keys come from the module's README — the point is that the
sensitive values are pulled from the environment, never written inline.)

## Verify

After defining a client in `settings.php` and restarting so the environment
variables are loaded, request that named client from the module's service in
custom code and confirm it connects and can publish or subscribe to a subject on
your NATS server.
