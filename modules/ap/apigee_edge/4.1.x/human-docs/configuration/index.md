# Configuration

Apigee Edge does nothing until it is connected to your Apigee organization. The
setup has two important halves: telling the module which Apigee org and endpoint
to talk to, and giving it credentials **without** committing a secret to
configuration. Then you set who can do what through permissions.

## Store the Apigee credentials as a secret first

The module authenticates to Apigee with credentials (for example the org
username/password or an OAuth/service-account secret, depending on your Apigee
setup). Because it depends on the **Key** module, the right place for that secret
is a **Key entity backed by an environment variable** — never plain, committed
config.

The recommended flow on this DDEV site:

1. Save the secret into the container's environment (this writes to
   `.ddev/.env`, which must stay out of version control):

   ```bash
   ddev dotenv set .ddev/.env --apigee-auth-secret='<the-secret-value>'
   ddev restart
   ```

   The flag `--apigee-auth-secret` becomes the environment variable
   `APIGEE_AUTH_SECRET`.

2. Confirm it is present in the container **without printing its value**:

   ```bash
   ddev exec 'test -n "$APIGEE_AUTH_SECRET"'   # exit status 0 means it is set
   ```

3. Create a Key that reads from that environment variable (the Key module's
   built-in `env` provider), for example:

   ```bash
   ddev drush key:save apigee_auth_secret --label='Apigee auth secret' \
     --key-type=authentication --key-provider=env \
     --key-provider-settings='{"env_variable":"APIGEE_AUTH_SECRET","base64_encoded":false,"strip_line_breaks":true}' \
     --key-input=none -y
   ```

You now have a Key you can select on the Apigee connection form instead of typing
a secret into a field that would end up in config exports.

## Connect to your Apigee organization

Go to **Configuration** and open the Apigee Edge connection settings (in the
Apigee section of the admin configuration area). On the connection form you
provide:

- the **Apigee organization** name;
- the **endpoint / instance type** (Apigee Edge public/private cloud, or Apigee X
  / hybrid), as appropriate for your account;
- the **authentication method** and the **Key** that holds the credentials —
  select the Key you created above.

Save and use the form's **test/send connection** action to confirm Drupal can
reach Apigee. Once the connection succeeds, Drupal users can be synchronised with
Apigee developers, and app/key/product management becomes available in the portal.

## Set the permissions

At **People → Permissions** (`/admin/people/permissions`), grant the module's
permissions carefully:

- **`administer apigee edge`** — full control over the integration; administrators
  only.
- **`bypass api product access control`** — this **overrides** the gate that
  decides which developers may consume which API products. Give it only to trusted
  administrators; handing it to a normal developer role effectively removes API
  product access control for those users.

Assign developer-facing capabilities (registering, creating apps, viewing
products) to your authenticated/developer role as your portal design requires.
