# Configuration

Entra ID login needs an application registered in your Azure / Microsoft Entra ID
tenant, and the resulting credentials entered into the module's settings. The
settings form requires the **Administer site configuration** permission.

## 1. Register an application in Azure

In the **Azure portal**, register an application for your Drupal site and note its:

- **Client ID** (Application ID)
- **Tenant ID** (Directory ID)
- **Client Secret** (create one under the application's certificates & secrets)

Set the application's **redirect URI** to your site's Entra ID callback (the
callback that pairs with the `/user/login/entra-id` login route). Microsoft
requires HTTPS, so your site must be served over HTTPS.

## 2. Enter the credentials in Drupal

1. Enable the module and go to **Configuration → People → Social Auth Entra ID**
   (settings route `/admin/config/services/entra-id/settings`).
2. Enter the **Microsoft Client ID**, **Tenant ID**, and **Client Secret** from
   the Azure portal.
3. Optionally, configure **allowed email domains** to restrict login and
   registration to your organization's domains — for example so only
   `@yourcompany.com` addresses can sign in or self‑register.
4. Click **Save**.

After saving, users will see a **Log in with Microsoft** option on the login page.
First‑time users are automatically registered and logged in (subject to any domain
restriction you set).

## Keep the client secret out of exported config

The Client Secret is stored in the module's configuration
(`social_auth_entra_id.settings`). On this project's convention, sensitive values
should come from an **environment variable** (for example set with
`ddev dotenv set`), be surfaced through a **Key** entity where possible, and be
**excluded from configuration export** so the secret is never committed to your
repository. Handle it accordingly rather than leaving it in exported config.

## Review account matching before going live

When Microsoft returns a user, the module matches them to a Drupal account and can
create one on first login. On a site that already has local accounts, confirm how
matching works (particularly matching by email) before enabling, so an Entra ID
identity cannot unexpectedly take over a pre‑existing Drupal account that happens
to share the same email address. Combined with the allowed‑domains restriction,
this keeps access limited to the people you intend.
