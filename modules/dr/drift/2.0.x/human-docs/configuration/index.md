# Configuration

Drift's configuration is short: you connect the module to your Drift account and
control where the chat widget loads. Most of the widget's appearance and behavior
is configured on Drift's side, not here.

## Before you start

Create your Drift account at [drift.com](https://www.drift.com) and complete their
setup. Customize the widget's look and feel from Drift's widget‑customization
page. Drift will give you an **account identifier** (embed code / account ID) that
tells the widget which Drift account to connect to — you'll paste that into
Drupal.

## Open the settings form

1. Log in as a user with the module's Drift administration permission (grant it on
   **People → Permissions**, `/admin/people/permissions`).
2. Go to the **Drift** settings form under **Configuration** (route
   `drift.config`).

## Settings

- **Drift account identifier / embed code** — the identifier Drift assigned to
  your account. This is what links the on‑page widget to your Drift account;
  without it the widget has nothing to load. Note that this identifier is embedded
  in the page's JavaScript and served to every visitor, so it is a public embed
  key rather than a secret — you don't need to treat it as a credential.
- **Enable the widget** — turn the chat widget on so it renders on the front end.
- **Where the widget loads** — control which parts of the site show the widget
  (for example front‑end pages only, excluding admin pages). Use this to keep the
  chat off of pages where it isn't wanted.

Click **Save configuration** when you're done.

## Privacy and consent

The Drift widget loads Drift's third‑party JavaScript, which can track visitors
and set cookies, and any chat content is processed by Drift under their terms.
Pair the widget with a cookie‑consent mechanism and disclose the tracking in your
privacy policy so visitors know Drift is in use.
