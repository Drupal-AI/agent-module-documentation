# Configuration

## 1. Register an application in Azure

In the Azure portal, create an **App registration** and:

- Note its **client (application) ID** and **directory (tenant) ID**.
- Create a **client secret**.
- Set the app's **redirect URI** to `https://YOURSITE/callback_azure_ad`.

## 2. Fill in the settings form

1. Log in as a user with the **`administer azure_ad_login configuration`**
   permission.
2. Go to **Configuration → Web services → Azure AD Login**
   (`/admin/config/services/azure-ad-login`).

On the form you set:

- **Client ID** and **client secret** from your Azure app registration.
- **Tenant** — your specific tenant ID for a single‑tenant app, or `common` to
  allow multi‑tenant sign‑in.
- **Endpoint hosts** — the authorize, token, and Graph endpoints.
- A **role‑to‑group map** — which Azure AD security groups (by display name) map to
  which Drupal roles. The login link only appears once at least one mapping exists.

> **Keep the client secret out of committed config.** Store it in an environment
> variable and load it from there rather than pasting the literal value where it
> could be exported. With DDEV, for example:
> `ddev dotenv set .ddev/.env --azure-client-secret=<value>` then `ddev restart`,
> keeping `.ddev/.env` out of version control, and reference it via `getenv()`.

## 3. How a login works

When a user clicks *"Login with your Azure AD account"*, the module:

1. Redirects them to Azure's **authorize** endpoint.
2. On return to `callback_azure_ad`, exchanges the `code` for an **access token**.
3. Reads their profile from Microsoft Graph `/v1.0/me`.
4. Matches an existing Drupal account by the Azure **`userPrincipalName`**, or
   **auto‑creates** one (with a random 25‑character password) if none exists.
5. Assigns Drupal roles based on the user's Azure groups, per your mapping, and
   finalizes the login.

Authentication errors are written to the *Azure login* logger channel, so check
Drupal's logs if sign‑in fails.

## Callback route

The callback route (`callback_azure_ad`) is intentionally reachable by anonymous
visitors, because a user is not yet logged in mid‑flow.
