# Configuration

The settings connect the module to your Fastly service and tell it which ACL to
write into. You will need details from your Fastly account: the service ID, the ACL
name(s), and an API token that can modify the ACL.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Development → Fastly Streamline Access**
   (`/admin/config/development/fastly_streamline_access`, config route
   `fastly_streamline_access.config_form`).

## Fields

- **Standard Access Control List (ACL) name** — the name of the Fastly ACL where the
  module records the IP addresses of users who authenticate. This value must match
  the ACL name in your Fastly service exactly.
- **Long lived Access Control List (ACL) name** — the ACL where the optional admin
  submodule records addresses that have been manually tagged for a longer-than-usual
  TTL. Match it to the corresponding Fastly ACL name.
- **Fastly Service Id** — the ID of the Fastly service the module connects to.
- **Fastly API Token** — the API token used to authenticate against Fastly. This is
  a **secret** and should be controlled as tightly as possible.

Click **Save configuration**. From then on, when a user who holds the `access
protected lagoon routes` permission logs in or visits `/user`, the module attempts
to add their address to the standard ACL through the Fastly API.

## Store the API token as a secret

Do not paste the raw API token into configuration that gets committed, and do not
hard-code it. The maintainers explicitly recommend using the
[Key](https://www.drupal.org/project/key) module together with a key management
service. On this project the recommended pattern:

1. Save the token into an environment variable with DDEV's dotenv helper, keeping it
   out of version control:

   ```bash
   ddev dotenv set .ddev/.env --fastly-api-token=<value>
   ddev restart
   ```

   The flag `--fastly-api-token` becomes the environment variable
   `FASTLY_API_TOKEN` inside the web container. Never commit `.ddev/.env`.

2. Install Key if it is not already enabled (`ddev composer require drupal/key &&
   ddev drush en key -y`), confirm the variable is present *without* printing its
   value (`ddev exec 'test -n "$FASTLY_API_TOKEN"'` — exit status 0 means it is
   set), then create a Key from that environment variable and reference the Key from
   the module's settings.

## Operational notes

- **Failures are logged, not shown.** The Fastly API call is wrapped so errors are
  caught and written to the log. If a user reports they still cannot get in, check
  the Drupal logs for a failed ACL update — a misconfiguration is otherwise silent.
- **Entries do not expire.** Membership in the ACL is additive; nothing removes old
  addresses automatically. Plan a periodic review or cleanup so stale allow-listed
  IPs do not accumulate into access paths nobody is watching.
- **Restrict the permission carefully.** Only trusted users should hold `access
  protected lagoon routes`, since holding it is what lets an address be added to the
  edge ACL.
