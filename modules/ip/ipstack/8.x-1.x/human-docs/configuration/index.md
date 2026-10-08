# Configuration

Configuring IPstack comes down to one thing: giving it your ipstack.com **API
access key**. Because that key is a secret, the safest approach is to keep it in an
environment variable and reference it, rather than typing it straight into a form
that gets exported to `config/sync`.

## Get an access key

Sign in at [ipstack.com](https://ipstack.com/), create an account if you do not
have one, and copy your **API Access Key** from the dashboard.

## Store the key securely (recommended)

Keep the secret out of version control. If you run **DDEV**, save it into DDEV's
dotenv file (which is not committed) and restart:

```bash
ddev dotenv set .ddev/.env --ipstack-access-key=<your-access-key>
ddev restart
```

That exposes `IPSTACK_ACCESS_KEY` inside the container. Confirm it is present
**without printing its value**:

```bash
ddev exec 'test -n "$IPSTACK_ACCESS_KEY"'   # exit status 0 means it is set
```

You can then reference the variable from `settings.php` when setting the module's
config value, so the literal key never enters exported configuration:

```php
$config['ipstack.settings']['access_key'] = getenv('IPSTACK_ACCESS_KEY');
```

## Enter the settings

Go to **Configuration → System → IPstack** (`/admin/config/system/ipstack`), which
requires the module's administer permission. The key setting is:

- **Access key** — your ipstack.com API access key. If you set it from an
  environment variable in `settings.php` as above, you can leave the stored value
  empty; otherwise paste the key here (understanding it will then live in the
  database and any config export).

The module supports **HTTPS** and **caching** of lookup results — leave HTTPS on so
IP data is not sent in the clear.

## Test it

Use the built-in testing page to confirm lookups work:

```
/admin/config/system/ipstack/test/page?ip=134.201.250.155
```

Replace the IP with any address you want to check. A successful response shows the
geolocation data ipstack returns for that address.

## Privacy note

Every lookup **sends the IP address to ipstack.com**. An IP address can be personal
data under regimes such as the GDPR, so make sure this third-party data sharing is
covered by your privacy policy and any consent requirements that apply to your site.
