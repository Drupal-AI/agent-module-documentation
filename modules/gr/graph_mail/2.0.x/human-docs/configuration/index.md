# Configuration

Getting Graph Mail working has three parts: set up the Azure app registration, enter its
credentials on the Drupal settings form, and select Graph Mail as your mail backend. This
page covers all three, plus the automatic retry queue.

## Who can configure it

The settings form is gated by the **Administer Graph Mail configuration**
(`administer graph mail configuration`) permission. Grant it at **People → Permissions** only
to trusted administrators — the form holds your Azure client secret.

## Step 1 — Set up the Azure app registration (prerequisite)

Before Drupal can send anything, you need an app registration in Azure AD / Microsoft Entra
ID:

1. Register an application in your Azure tenant.
2. Under API permissions, add the Microsoft Graph **Mail.Send** permission as an
   **Application** permission (not Delegated), and grant admin consent.
3. Create a **client secret** and copy its value.
4. Note your **tenant (directory) ID**, the **application (client) ID**, and decide which
   **mailbox** the site will send as (its user object id or UPN, for example
   `noreply@example.com`).

Because the module sends as that mailbox using an application permission, make sure the app
is allowed to reach it — optionally scope access with an Exchange application access policy.

## Step 2 — Enter the settings in Drupal

Go to **Configuration → Web services → Graph Mail** (`/admin/config/services/graph_mail`) and
fill in:

- **Tenant ID** *(required)* — your Azure directory (tenant) GUID. Used to build the OAuth2
  token URL.
- **Client ID** *(required)* — the application (client) ID from the app registration.
- **Client secret** *(required)* — the app secret you created. (See the note below on keeping
  this out of exported configuration.)
- **User ID** *(required)* — the mailbox the message is sent as: its object id or UPN.
- **API version** — `v1.0` (the default) or `beta`. (An old value of `1.0` is auto-corrected
  to `v1.0`.)
- **Default mail** — the "from" address. Leave it blank to fall back to the site email
  configured under **Configuration → System → Basic site settings**.
- **Save to sent items** — when ticked, Microsoft keeps a copy of each sent message in the
  mailbox's **Sent Items** folder. Off by default.

Save the form.

> **Keeping the client secret out of version control.** The secret is stored in the
> `graph_mail.settings` config object, which means it can end up in exported configuration. To
> avoid committing it, leave the field blank (or use a placeholder) and override it at runtime
> in `settings.php` from an environment variable, for example:
>
> ```php
> $config['graph_mail.settings']['client_secret'] = getenv('GRAPH_MAIL_CLIENT_SECRET');
> ```
>
> Set the variable in your environment (with DDEV, `ddev dotenv set .ddev/.env
> --graph-mail-client-secret=<value>` then `ddev restart`) so the real secret never lands in
> the repository.

## Step 3 — Select Graph Mail as the mail backend

The module registers the `graphmail` mail plugin but does **not** make itself the default
sender. Choose it one of two ways:

- **Mailsystem module (recommended):** go to **Configuration → System → Mailsystem**
  (`/admin/config/system/mailsystem`) and set **Graph Mail** as the default formatter/sender —
  either site-wide, or just for specific modules and mail keys (for example only the contact
  form, leaving everything else on core mail).
- **settings.php:** set the default interface directly:

  ```php
  $config['system.mail']['interface']['default'] = 'graphmail';
  ```

## The retry queue (throttling)

If Microsoft Graph throttles a send and returns HTTP 429, the module doesn't drop the
message — it re-queues it into the `graph_mail_retry_queue` and retries on the next cron run
once Microsoft's `Retry-After` delay has elapsed (defaulting to 600 seconds if none is given).
For this to work, **cron must run regularly**. Other kinds of send failure are logged to the
`graph_mail` log channel and the message is dropped, so check that channel under **Reports →
Recent log messages** if mail isn't arriving.

## Testing

Once configured, trigger a mail your selected keys cover (for example request a password
reset) and confirm it arrives. Developers can also send an ad-hoc test from code via the
`graph_mail.helper` service — see the sibling [`agent/`](../../agent/start.md) docs for the
API.
