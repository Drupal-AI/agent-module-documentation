# Configuration

## Step 1 — set up your Azure application

If you have not already:

1. Register a new application in **Azure Active Directory**.
2. Configure the necessary **Microsoft Graph** permissions — **Mail.Send** — and
   grant admin consent if your tenant requires it.
3. Note down your **Client ID**, **Client Secret**, and **Tenant ID**.

Keep the client secret out of plaintext configuration: store it in an
environment variable and surface it through a Key entity, and scope the app
registration minimally.

## Step 2 — configure the transport in Drupal

1. Log in as a user who can administer the site.
2. Go to **Configuration → System → Symfony Mailer Lite Settings**, or navigate
   directly to `/admin/config/system/symfony-mailer-lite`.
3. Configure the Microsoft Graph API transport:
   - Enter your Azure application credentials (**Client ID**, **Client Secret**,
     **Tenant ID**).
   - Configure the **sender email address** — this must belong to your Microsoft
     365 organisation.
   - Use the **Test the connection** feature to confirm everything is wired up
     correctly.
4. Save.

## Using a DSN string

If you prefer to configure the transport as a DSN, the Microsoft Graph API
transport uses this format:

```
microsoft-graph-api://<client-id>:<client-secret>@<tenant-id>?from=<sender-address>
```

## Troubleshooting

- **Authentication failures** — check that your Azure application credentials
  are correct and that the app has the necessary permissions.
- **Email not sending** — verify the sender email address is configured properly
  and belongs to your Microsoft 365 organisation.
- **Permission issues** — make sure the Microsoft Graph API permissions are set
  correctly and admin consent has been granted if required.
