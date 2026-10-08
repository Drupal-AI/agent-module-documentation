# Configuration

Big Blue Button connects to your BigBlueButton server, whose API is authenticated
with a **shared secret**. The secret authenticates every API call, so treat it as a
credential and keep it out of plain, committed configuration.

## 1. Open the settings form

Go to the module's settings form (`bigbluebutton.settings`) as a user with the
rights to administer it. This is where you enter the connection details for your BBB
server.

## 2. Enter the server URL and shared secret

- **Server URL** — the base URL of your BigBlueButton server. Use **HTTPS** so the
  connection to the server is encrypted.
- **Shared secret** — the secret from your BBB server. The module uses it to build
  signed API URLs (the standard BigBlueButton SHA-checksum signing) so that calls to
  the server are authenticated.

### Keep the shared secret out of committed config

Because the secret is a credential, prefer supplying it from an environment variable
rather than pasting it into configuration that gets exported or committed. With DDEV:

```bash
ddev dotenv set .ddev/.env --bbb-shared-secret=YOUR_SECRET_HERE
ddev restart
```

The flag `--bbb-shared-secret` becomes the environment variable `BBB_SHARED_SECRET`
inside the web container. Never commit `.ddev/.env`. You can then reference it from
`settings.php` via `getenv('BBB_SHARED_SECRET')`, or, where the field accepts a Key
entity, store it as a Key backed by that environment variable under **Configuration →
System → Keys**. Confirm the variable is present without printing it:

```bash
ddev exec 'test -n "$BBB_SHARED_SECRET" && echo set || echo missing'
```

## 3. Set permissions

Under **People → Permissions** (`/admin/people/permissions`), grant the module's
permissions — creating meetings and managing recordings — only to the roles that
should have them.

## 4. Add the field to content

Add the BigBlueButton field to the content types that should host meetings, under
**Structure → Content types → (your type) → Manage fields**.

## Security notes

- The shared secret authenticates all BBB API calls — store it securely and never
  commit it.
- Always operate over HTTPS to the BigBlueButton server.
- The module's use of signed API URLs was reviewed and found sound; the security of
  the integration rests on keeping the secret confidential.
