# Configuration

You configure Zammad for Helpdesk Integration as a **Zammad integration inside the
Helpdesk Integration framework** — this module adds no settings page, routes,
permissions, or forms of its own. Everything below is entered on the Zammad
integration's configuration form, which the framework surfaces when you pick the
Zammad platform.

## 1. Get your Zammad URL and API token

In your Zammad instance, generate an **API token** (a personal or dedicated
integration token) that can create tickets, add articles, change ticket state, and
manage customers, as your workflow requires. Note the instance's **base URL** too.

## 2. A word on how the token is stored

Be aware that this module stores the Zammad **API token as plain text** on the
integration configuration entity — it is a normal text field, not a password field,
and there is **no Key‑module integration** for it. Practical consequences:

- **Restrict who can edit helpdesk integrations**, since anyone with that access can
  read the token.
- Because it lives in configuration, be careful with **configuration exports** — the
  token can end up in exported YAML. Avoid committing that to a public repository.
- Scope the Zammad token to the **least privilege** it needs.

On the reassuring side, the module does **not** disable TLS verification when talking
to Zammad — it leaves your HTTP client's normal certificate checking in place — so
keep your Zammad instance on **HTTPS** and the connection is verified.

## 3. Create the Zammad integration in Drupal

1. Log in as an administrator.
2. Go to **Configuration → Web services → Helpdesk**
   (`/admin/config/services/helpdesk`).
3. Create a new integration and choose **Zammad** as the platform.
4. Fill in the configuration fields:
   - **URL** — your Zammad instance's base URL (for example
     `https://support.example.com`).
   - **API token** — the token you generated in step 1.
   - **Group** — the default Zammad group that new tickets are filed under.
   - **Closed state** — which Zammad ticket state represents "closed"/resolved. The
     options are fetched live from your Zammad instance's ticket states.
5. Save the integration.

You can repeat this to add **more than one Zammad instance**, each as its own
integration entity.

## 4. Optional: the Zammad chat widget

The integration form includes a **chat** section. To embed Zammad's live‑chat widget
on your site, set a **chat id** (from Zammad) — when a chat id is present, the module
injects Zammad's chat script (loaded from `<your-zammad-url>/assets/chat/chat.min.js`)
into the page. You can also tune:

- **Chat label** — the text on the chat launcher.
- **Font size** — the widget's font size.
- **Auto‑show** — whether the widget opens automatically.
- **Debug** — enable verbose logging while you are setting it up.

Leave the chat id empty if you only want ticket sync and no on‑site chat widget.

## 5. Grant permissions and expose the helpdesk

Permissions and the user‑facing `/helpdesk` page come from the **Helpdesk
Integration** framework, not from this module. Grant the framework's helpdesk
permission to the appropriate roles at **People → Permissions**
(`/admin/people/permissions`), and add a menu link to `/helpdesk` — see the
[Helpdesk Integration configuration guide](../../../../helpdesk_integration/3.0.x/human-docs/configuration/index.md)
for details.

## 6. Test the sync

As a permitted user, create a test issue from the `/helpdesk` page and confirm a
matching **ticket appears in Zammad** (in the group you chose), that a Drupal comment
becomes a ticket article, and that resolving the Drupal issue moves the ticket to your
chosen closed state. If you enabled chat, load a front‑end page and confirm the chat
widget appears.

## How the sync behaves

Behind the scenes the plugin maps Drupal and Zammad both ways: it creates tickets on
behalf of the issue owner, appends comments as articles, sets the closed state on
resolve, upserts the Zammad customer record for the Drupal user, and pulls tickets
(with their articles and attachments) back into Drupal — optionally only those updated
since a given date, for efficient incremental syncing.
