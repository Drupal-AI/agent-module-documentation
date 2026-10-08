# Configuration

Bigin CRM authenticates to Zoho Bigin with **OAuth credentials** and sends contact
and lead data to Zoho's API. The credentials are secrets and the data flow is
outbound personal information — handle both carefully.

## 1. Create a Zoho OAuth application

In your Zoho account, register an OAuth application (the Zoho API console) to obtain
the client ID, client secret and any related credentials Bigin requires. Keep these
values private.

## 2. Store the OAuth credentials as secrets

Do not paste OAuth secrets into plain configuration that gets exported or committed.
Store them in the environment instead. With DDEV:

```bash
ddev dotenv set .ddev/.env --bigin-client-id=YOUR_CLIENT_ID --bigin-client-secret=YOUR_CLIENT_SECRET
ddev restart
```

Those flags become the environment variables `BIGIN_CLIENT_ID` and
`BIGIN_CLIENT_SECRET` inside the web container. Never commit `.ddev/.env`. You can
confirm they are set without printing their values:

```bash
ddev exec 'test -n "$BIGIN_CLIENT_SECRET" && echo set || echo missing'
```

Reference the values from `settings.php` via `getenv('BIGIN_CLIENT_SECRET')`, or,
where the module accepts a Key entity, store them as Key entities backed by these
environment variables under **Configuration → System → Keys**
(`/admin/config/system/keys`).

## 3. Connect the module

In the module's configuration, supply the OAuth credentials (via the environment /
Key entity as above) and complete the Zoho authorization so the module can reach the
Bigin API. Always connect over HTTPS.

## 4. Grant the administration permission

Under **People → Permissions** (`/admin/people/permissions`), grant the module's
permission only to the roles that should manage the CRM integration.

## Privacy and security notes

- The module **sends personal data (contacts and leads) to Zoho Bigin**, an external
  service. Disclose this data transfer in your privacy policy and only sync the data
  you are permitted to share.
- OAuth credentials are secrets — keep them in the environment, reference them through
  a Key entity or `getenv()`, and never commit them.
- Connect to the Bigin/Zoho API over HTTPS.
