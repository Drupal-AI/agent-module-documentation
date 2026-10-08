# Configuration

Getting Office 365 mail working is a four-step flow — one step in Microsoft
Entra and the rest on the module's page at
`/admin/config/system/mailer/office365`.

## 1. Register your app with Microsoft Entra

In Microsoft Entra (Azure AD), register an application and give it this redirect
URL (substituting your real domain):

```
https://example.com/office365/oauth/callback
```

The registration produces the credentials — client ID and a client secret — that
you enter in Drupal. Treat the **client secret like an API key**: keep it in an
environment variable or a **Key** entity, never in exported configuration. Note
its expiry date, because when the secret lapses all site mail through this
transport stops until you renew it.

## 2. Enter the credentials in Drupal

Go to **`/admin/config/system/mailer/office365`** and enter the credentials from
the Entra app registration. Save.

## 3. Sign in to save the OAuth state

Still on `/admin/config/system/mailer/office365`, use the sign-in link the page
provides to complete the OAuth flow. This stores the OAuth state (the access and
refresh tokens) with Drupal, which is what actually authorizes the site to send.

## 4. Add the transport to your mailing policy

Add the **Office 365 – OAuth** transport to your Symfony Mailer mailing policy so
mail is routed through it. Until this is done, the module is configured but no
email is actually delivered through it.

## Keeping the token refreshed

OAuth access tokens expire, so the stored token has to be refreshed using the
refresh token. The module offers two ways to do this — pick one:

- **Drupal cron** — refreshing happens (when necessary) whenever cron runs. If
  you rely on this, make sure cron runs at least every 12 hours to stay on the
  safe side of the refresh-token lifetime.
- **Drush command** — if you would rather refresh on your own schedule,
  independent of cron, run:

  ```bash
  drush office365:refresh
  ```

  Choose an appropriate interval for this too, so the token never lapses between
  runs.

## Troubleshooting

If mail is not going out, check the status shown on
`/admin/config/system/mailer/office365`, and review the system logs (for example
the **Recent log messages** report / watchdog) for any error messages from the
transport.
