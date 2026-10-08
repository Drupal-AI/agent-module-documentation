# Configuration

Localization Client works as soon as the `l10n_client_ui` submodule is enabled and
the right permissions are set — most of the "configuration" is just those
permissions plus a small settings form. If you enabled the contributor submodule,
there's also an API key to handle carefully.

## Open the settings form

1. Log in as a user with the **Administer languages** permission (an administrator
   by default).
2. Go to **Configuration → Regional and language → User interface translation →
   Localization client**, or navigate directly to
   `/admin/config/regional/translate/client`.

This form (route `l10n_client_ui.settings`) holds the client's options. If you
enabled the contributor submodule, this is also where the connection to a
localization server is configured.

## Permissions recap

The behaviour is driven by permissions at **People → Permissions**
(`/admin/people/permissions`):

- **Use localization client UI** — who gets the on‑page translation pane while
  browsing the site in a non‑English language.
- **Administer languages** — who can reach this settings form.
- **Contribute translations to localization server** — who can push translations
  upstream (contributor submodule only).

Grant the translate permission to your translators, and keep the settings and
contribute permissions to trusted roles.

## Contributing to a localization server (optional)

If you enabled **`l10n_client_contributor`**, you can share your translations with
a remote localization server such as `localize.drupal.org`. This requires an **API
key** for that server, which you obtain from your account there.

### Store the API key securely (recommended)

The localization‑server API key is a secret. Rather than pasting it into committed
configuration, store it in an environment variable and reference it from Drupal.
With DDEV:

```bash
ddev dotenv set .ddev/.env --l10n-server-api-key=<your-key>
ddev restart
```

Never commit `.ddev/.env`. Where the module accepts a
[Key](https://www.drupal.org/project/key) entity, create one backed by that
environment variable; otherwise reference the variable from `settings.php` with
`getenv('L10N_SERVER_API_KEY')`. The goal is to keep the key out of your git
history.

## Everyday translating

With permissions set, switch the site to a non‑English language and open a page.
Use the on‑page pane to see every interface string on that page (green =
translated, white = untranslated), filter to find one, and enter or edit its
translation — it saves to the local translation store immediately. Remember to
avoid the Overlay module while translating admin pages, since the pane cannot
translate through it.
