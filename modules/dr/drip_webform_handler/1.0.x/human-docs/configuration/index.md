# Configuration

Drip webform handler is configured **per webform**, not on a global admin page.
You add the Drip handler to each form you want to connect and set its options
there. You will need your Drip **API key** and **account ID** ready before you
start.

## Where the credentials live

The handler stores the Drip API key and account ID in its own settings, which are
part of the webform's exported configuration. Treat that configuration the way you
treat any config that carries a credential: control who can edit webform handlers,
and keep exported config out of any location you would not want the key to appear.

## Add the Drip handler to a webform

1. Go to **Structure → Webforms** (`/admin/structure/webform`) and edit the form
   you want to connect.
2. Open **Settings → Emails / Handlers**
   (`/admin/structure/webform/manage/{webform}/handlers`).
3. Click **Add handler**, choose **Drip**, and give it a title.

## Handler settings

- **Drip API credentials** — supply your Drip API key (referencing the Key entity
  above where possible) and, if the form asks for it, your Drip account ID. These
  authenticate the requests this handler sends to Drip.
- **Field mapping** — map the webform's fields (email address, name, and any other
  data you collect) to the corresponding Drip subscriber fields, so each
  submission creates or updates the right record in Drip.
- **When it fires** — the handler runs on matching submissions; review the
  handler's conditions if you only want certain submissions sent to Drip.

Save the handler, then submit a test entry and confirm the subscriber/record
appears in your Drip account.

## A note on outbound traffic

This handler makes an outbound HTTPS request to Drip's API on each qualifying
submission. If your environment restricts egress, allow the Drip API endpoint so
submissions can reach it.
