# Configuration

Infomaniak Connect has no settings page of its own — it preconfigures a client on
the **OpenID Connect** module, and you finish the setup there. The steps below
cover creating the Infomaniak application, entering its credentials, and enabling
the login button.

## Step 1 — create an Infomaniak OAuth application

In the **Infomaniak Manager**, create an authentication application at
`https://manager.infomaniak.com/v3/ng/profile/user/applications/list`. Infomaniak
gives you a **Client ID** and a **Client secret** for that application — you will
enter both in Drupal. You will also need to tell Infomaniak the **redirect URI**
your site uses; Drupal shows that URI at the bottom of the OpenID Connect client
settings page (Step 2), so you may want to complete Step 2 first and then come
back to paste the redirect URI into Infomaniak.

## Step 2 — enter the credentials in Drupal

1. Go to **Configuration → People → OpenID Connect**
   (`/admin/config/people/openid-connect`).
2. Find the **Infomaniak OAuth 2.0** client, which is already present and
   preconfigured with the correct Infomaniak endpoints.
3. Enter the **Client ID** and **Client secret** from Step 1.
4. Note the **redirect URI** shown at the end of the client settings and register
   that exact URI back in your Infomaniak application.
5. Save.

### Keep the Client secret out of plain config

The Client secret is sensitive. Rather than committing it, store it in an
environment variable and reference it. In a DDEV project, for example:

```bash
ddev dotenv set .ddev/.env --infomaniak-client-secret=<your-secret>
ddev restart
```

That exposes it inside the container as `INFOMANIAK_CLIENT_SECRET` (never commit
`.ddev/.env`). Consult the OpenID Connect module's documentation for the
supported way to pull a client secret from an environment variable in your version
so the value stays out of exported configuration.

## Step 3 — show the "Log in with Infomaniak" button

By default the OpenID Connect buttons may not appear on the user login form. To
let visitors use Infomaniak, change the **"OpenID buttons display in user login
form"** setting on the OpenID Connect page so the **Log in with Infomaniak**
button is displayed.

## Verify

Log out (or use a private window) and visit the user login form. You should see a
**Log in with Infomaniak** button; clicking it should send you to Infomaniak to
authenticate and then return you to Drupal, signed in. If the redirect fails,
re-check that the redirect URI registered in Infomaniak matches the one Drupal
displayed exactly.
