# Configuration

## Open the settings form

1. Log in as a user with **Administer site configuration**.
2. Go to **Configuration → People → GSIS OAuth2 Login**
   (`/admin/config/people/gsislogin`).

## Fields on the form

- **GSIS consumer ID** — the OAuth 2 client ID issued to your service by GSIS.
  Stored as `gsislogin.GSISID`.
- **GSIS consumer secret** — the matching client secret issued by GSIS. Stored as
  `gsislogin.GSISSECRET`. This is a credential: only site administrators should be
  able to reach this form, and you should keep it out of any publicly readable
  configuration export.
- **Test server** — a toggle that switches the GSIS base URLs between the staging
  and production endpoints. Stored as `gsislogin.GSISTEST`. Leave it on while you
  validate the integration, then turn it off for go‑live.

Obtain the ID and secret by registering your service with GSIS, and make sure the
redirect/allowed URL you register there matches your site's `/gsis` route (for
example `https://www.example.com/gsis`).

### Handling the client secret safely

The client secret is a shared credential. Following this project's conventions,
prefer storing it in an environment variable rather than committing it in
exported configuration. With DDEV:

```bash
ddev dotenv set .ddev/.env --gsis-secret=YOUR_SECRET_HERE
ddev restart
```

(Never commit `.ddev/.env`.) You can then surface the value through a **Key**
entity so the raw secret never lands in version control. At minimum, keep this
admin form restricted to fully trusted administrators.

## Placing the login button

The module offers several ways for users to start the GSIS sign‑in:

- An icon is added automatically to the core **login and registration** forms.
- A dedicated login form lives at **`/gsis/login`**.
- A **"Login with GSIS"** block is provided — add it through **Structure → Block
  layout** and place it in any region you like, then theme it to match your site.
- You can also link users directly to **`/gsis`** to begin the flow from anywhere.

## Security notes

The public sign‑in routes (`/gsis`, `/gsis/login`) are open to anonymous users by
necessity — they are the entry points for people who are not yet logged in. The
sensitive part, the OAuth callback, is protected: the module stores a one‑time
**state** value in the session when the flow starts and verifies it on return,
which guards the callback against cross‑site request forgery. Credential
management stays locked to administrators via the **Administer site
configuration** permission.
