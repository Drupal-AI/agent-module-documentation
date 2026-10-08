# Configuration

Setting up Scaleflex DAM means two things: connecting the module to your Filerobot
account with your API credentials, and making sure those credentials are stored
securely rather than in exported, committed configuration.

## Connect to your Filerobot account

1. Log in as an administrator (a user with permission to administer the module's
   settings and **Administer media**).
2. Open the module's settings from the **Extend/module list** (its **Configure**
   link) or under **Configuration → Media**.
3. Enter the **Filerobot account/API credentials** issued by Scaleflex so the module
   can connect to your DAM and list assets, then save.

With the connection in place, the Filerobot asset picker becomes available to users
who hold **Administer media**, letting them browse the DAM and insert assets as
Drupal files/media.

## Store the API credentials securely

Filerobot credentials are secrets. Do not paste a live secret into configuration
that will be exported to code and committed to version control. Instead, keep the
value in an **environment variable**, and reference it from Drupal.

With DDEV, for example, store the secret in your (git‑ignored) environment file and
restart so it is available to the container:

```bash
ddev dotenv set .ddev/.env --filerobot-api-key=<value>
ddev restart
```

Where the module supports it, prefer a **Key** entity backed by the environment
provider (install the [Key](https://www.drupal.org/project/key) module if it isn't
already), so the secret is read from the environment at runtime and never stored in
config. Otherwise, reference the environment variable from `settings.php` with
`getenv()`. Either way, the goal is the same: the credential lives in the
environment, not in exported configuration.

## Keep asset insertion restricted

Asset insertion runs server‑side and is gated by the core **Administer media**
permission. Grant it only to trusted content administrators, and review who holds it
at **People → Permissions** (`/admin/people/permissions`). Because the server fetches
assets on the site's behalf when inserting them, limiting this permission is part of
running the integration safely.
