# Configuration

Setting this module up happens in two places: your **Microsoft Entra** (Azure
AD) app registration, and the transport form in Drupal. Pick the method that
fits your use case — Application, Delegated, or both.

Both transports are edited under **Configuration → System → Mailer transport**
(`/admin/config/system/mailer`), and both store the client secret through a
**Key** entity. The safest pattern is to keep the secret in an environment
variable and read it via Key rather than typing it into a form that ends up in
exported configuration. Remember that Azure client secrets **expire** — note the
expiry date somewhere, because when a secret lapses all site mail using it stops.

## Application method — send as a shared/system mailbox

Choose this when you want to send mail as a shared or system mailbox with no
end-user sign-in — automated notifications, transactional email, cron-triggered
mail. It is simpler than Delegated because there is no OAuth consent step and no
refresh token to maintain.

1. **In Microsoft Entra:** grant your app registration the **Application**
   permission **Mail.Send**, and have an administrator grant admin consent for
   it.
2. **In Drupal:** go to **Configuration → System → Mailer transport** and edit
   the **Microsoft Graph (Application)** transport (created automatically when
   the module was installed).
3. Enter the shared mailbox's **Email address**, the **Client ID** and the
   **Tenant ID** from the app registration.
4. Select the **Key** entity that holds the client secret. If you leave the
   default, the module reads the secret from the `OAUTH2_APPLICATION_CLIENT_SECRET`
   environment variable.
5. **Save.**
6. Decide how the transport is used: set it as the **default transport** in
   Symfony Mailer's configuration to route all site email through it, or attach
   it to a **Mailer Policy** to send only selected email types this way.

## Delegated method — send as a specific person's mailbox

Choose this when mail needs to look like it genuinely comes from a named
Microsoft 365 mailbox — for example a specific staff mailbox that authorizes the
app once by signing in, rather than a generic service account. In exchange for
that per-mailbox authenticity it requires an initial OAuth consent step and an
ongoing (automatic) refresh-token renewal.

1. **In Microsoft Entra:** grant your app registration the **Delegated**
   permission **Mail.Send**, and add the **offline_access** scope — that scope is
   what causes Microsoft to issue a refresh token.
2. **In Drupal:** go to **Configuration → System → Mailer transport** and edit
   the **Microsoft Graph (Delegated)** transport.
3. Enter the mailbox's **Email address**, the **Client ID** and the **Tenant ID**.
4. Select the **Key** entity holding the client secret, or leave the default,
   which reads the `OAUTH2_CLIENT_SECRET` environment variable.
5. **Save.**
6. Copy the **Redirect URI** shown on this same form into the Entra app
   registration's **Authentication** settings.
7. Back on this form, click **Authorize with Microsoft** and sign in as the
   mailbox that should send the mail. This completes the one-time consent; the
   module then keeps the authorization alive by renewing the refresh token
   automatically via cron.
8. As with the Application method, set the transport as the default or attach it
   to a Mailer Policy.

## Running both together

The two transports are independent, so you can configure and use both — for
example, send transactional/system mail through the Application transport and
staff-authored mail through the Delegated one — using Symfony Mailer's own
Mailer Policy system to decide which email types go where.
