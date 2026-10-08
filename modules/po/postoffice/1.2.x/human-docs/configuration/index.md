# Configuration

Postoffice has a single settings form. It stores just two values — the transport **DSN** and
the **mail theme** — in the `postoffice.site` configuration object.

## Open the settings form

1. Log in as a user with the **Administer postoffice configuration** permission. (This
   permission is marked *restrict access*, so grant it deliberately — it controls how all
   Postoffice mail is sent.)
2. Go to **Configuration → System → Postoffice settings**, or navigate directly to
   `/admin/config/system/postoffice`.

## Transport DSN

The **DSN** (Data Source Name) is a Symfony Mailer connection string that tells Postoffice
which transport to build and how to reach it. Examples:

- `smtp://user:pass@host:port` — send through an SMTP relay.
- `sendmail://default` — hand mail to the local sendmail binary.
- `native://default` — use PHP's configured mail settings.

Any Symfony Mailer transport is valid here, including third‑party bridges (for API‑based
providers) if you install them.

> **Treat the DSN as a secret.** An SMTP DSN embeds the username and password of your mail
> account. Rather than committing those credentials to exported configuration and version
> control, keep the sensitive values in an environment variable (with DDEV,
> `ddev dotenv set .ddev/.env --mail-dsn=…` then `ddev restart`) and reference the variable
> from your settings so the raw credentials stay out of the database export and the repository.

## Mail theme

The **mail theme** is the Drupal theme used to render the HTML body of your emails. Postoffice's
`Theme` middleware switches to this theme while building each message, so choose (or build) a
theme whose templates and CSS are suited to email rather than reusing your full front‑end theme.

## Save

Click **Save configuration**. New messages sent through the `postoffice.mailer` service will use
the updated transport and theme immediately.

## Beyond the form

Everything else about a message — its subject, body template, attachments, localisation, and
any custom processing — is handled in code through Postoffice's email classes and its
middleware pipeline (services tagged `postoffice.mailer_middleware`), not on this form. The
optional extension submodules (see [Installation](../installation/index.md)) add their own
behaviours, such as routing core user/contact mail through Postoffice or adding Twig helpers.
