# Configuration

NetForum xWeb API needs the credentials and endpoint for your NetForum xWeb
environment before any integration code can authenticate. These values are
administered through the module's settings and must be treated as **secrets**.

## What you will need from NetForum

From your NetForum / xWeb environment, gather:

- The **xWeb service endpoint / WSDL location** for your NetForum installation.
- The **xWeb authentication credentials** (for example the API username and
  password) issued for your integration.

Exact field labels depend on your NetForum environment; enter the values NetForum
provided for xWeb access.

## Store the credentials securely

The xWeb credentials grant access to your association's member and event data, so
handle them with the same care as any API secret:

- **Never commit them** to your repository or into exported configuration.
- Prefer storing the sensitive values in **environment variables** and referencing
  them from `settings.php`, or use the **Key** module if your setup stores the
  credential as a Key entity.
- Always connect to xWeb over **HTTPS**.

With DDEV you can set an environment variable without committing it:

```bash
ddev dotenv set .ddev/.env --netforum-xweb-password=<value>
ddev restart
```

Then reference it from `settings.php` with `getenv('NETFORUM_XWEB_PASSWORD')` (and
keep `.ddev/.env` out of version control), or override the module's setting there:

```php
$config['netforum.settings']['password'] = getenv('NETFORUM_XWEB_PASSWORD');
```

Adjust the config key and variable name to match your environment.

## Confirm the connection

Once the endpoint and credentials are in place, exercise the module's service from
your integration code — run a simple xWeb query and confirm it authenticates and
returns data. An authentication failure usually means the endpoint/WSDL or the
credentials are wrong, or that a customized NetForum implementation needs custom
proxy classes generated from your own WSDL (see
[Installation](../installation/index.md)).
