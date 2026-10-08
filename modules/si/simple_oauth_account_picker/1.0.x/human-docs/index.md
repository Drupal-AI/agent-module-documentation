# Simple OAuth Account Picker — manual setup guide

**Simple OAuth Account Picker** (`simple_oauth_account_picker`) adds an "account
picker" to the OAuth authorization step — the kind of "choose an account" chooser you
see from large identity providers like Google. When a user authorizes a client
application through the Authorization Code Grant on a Simple OAuth site, this module
presents them with a friendly choice rather than a bare login form. It depends on the
**Simple OAuth** module and improves the authorization user experience without you
having to build that flow yourself.

The picker offers the user three options:

- **Log in using the currently logged‑in account** — instant, no re‑entry.
- **Log in using another account they have used before** — this pre‑fills the
  username on the login form (the previously used accounts are remembered via a
  cookie).
- **Log in using a completely different account** — takes the user to an empty login
  form.

It is designed to look at home in Drupal's default **Olivero** theme, and it
automatically generates a simple avatar from the first letter of an account's title
when no image is provided. You can fully customise each account element — its title,
subtitle, avatar, and the text on the right — through an alter hook, and it works with
Simple OAuth's *Automatic authorization* and *Remember previous approval* consumer
options.

Because this module sits on the **OAuth authorize endpoint** — a genuinely sensitive
surface — it is worth being clear about the trust boundary. The picker should only
ever let the **currently authenticated user** authorize a client for **their own**
account. It must never become a way to select or grant access on behalf of a
**different** account that the browser is not actually authenticated as — that would
be an authorization bypass. In practice this means: switching to another account must
require proper re‑authentication (a real login), and the tokens issued must correspond
to the authenticated session, not merely to whichever account was clicked in the
picker. Keep your Simple OAuth keys and secrets stored securely as usual. The module
works on **Drupal 10.3 and 11**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (and Simple OAuth) with
   Composer and enable it.

## How to use it

There is no settings form to configure — once installed alongside a working Simple
OAuth setup, the account picker appears automatically on the OAuth authorize page:

1. Make sure **Simple OAuth** is installed and configured (consumers, keys, and
   scopes) as you would for any OAuth provider.
2. Enable this module. The next time a user authorizes a client application through
   the Authorization Code Grant, they see the account picker with the three options
   above instead of a plain login form.
3. Optionally, developers can use the provided **alter hook** to customise each
   account element's title, subtitle, avatar, and right‑hand text, and to supply a
   real avatar image in place of the auto‑generated letter avatar.

If you customise or extend the flow, verify the trust‑boundary point above: switching
accounts should require real authentication, and issued tokens should bind to the
authenticated session.
