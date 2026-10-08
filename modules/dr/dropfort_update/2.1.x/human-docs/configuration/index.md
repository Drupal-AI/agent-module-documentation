# Configuration

Dropfort Update's configuration connects this site to your Dropfort account so it
can report update information there.

## Open the settings form

1. Log in as a user with the module's Dropfort administration permission (grant it
   on **People → Permissions**, `/admin/people/permissions`).
2. Go to the **Dropfort Update** settings form under **Configuration** (route
   `dropfort_update.settings`).

## Settings

- **Dropfort connection / credentials** — the details that authenticate this site
  to your Dropfort account: a **site key**, a **site token**, and the **Dropfort
  URL** to report to. The site key identifies the site to the dashboard and the
  site token authorizes it to report data; get both from your Dropfort account
  after registering the site there. (The token field is masked; leaving it blank
  on a later save keeps the previously stored token.)
- **Reporting options** — any options the form offers for what is sent or when. By
  default the module reports the site's status report (installed modules/themes,
  their versions, and available updates) collected via core's Update module.

Click **Save configuration** when you're done.

## Handling the credentials

The site key and site token are saved in the module's own configuration
(`dropfort_update.settings`) and travel with a configuration export. The token is
entered through a masked field. Because these values authorize reporting on this
site's behalf, control who can edit this form and keep exported configuration out
of any location you would not want the token to appear.

## What gets sent, and why it's sensitive

Dropfort Update transmits a detailed inventory of your site: which modules and
themes are installed, their exact versions, and which updates are available. That
inventory is sensitive in its own right — it maps out the site's precise attack
surface — so:

- send it only to a **Dropfort account you trust**;
- make sure the connection is **authenticated** and carried over **HTTPS**;
- treat the credential as a secret, as above.
