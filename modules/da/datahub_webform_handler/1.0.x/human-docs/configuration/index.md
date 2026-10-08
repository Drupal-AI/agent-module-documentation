# Configuration

Setting up Webform Datahub has two parts: a **global settings form** that holds
the API endpoint and credentials for the whole site, and a **per‑webform
handler** that decides which form's submissions are sent and how their fields map
to the Datahub attendee record.

## 1. Fill in the global Datahub settings

1. Log in as a user with the **Access administration pages** permission.
2. Go to **Configuration → Web services → Webform Datahub**, or navigate directly
   to `/admin/config/services/webform_datahub-config`.

The form has these fields:

- **Endpoint base URL** — the base address of the Datahub API. The handler
  appends its own paths to this (a token path and a registration path), so enter
  just the base, and **always use an `https://` URL**. The form only checks that a
  protocol is present; it does not force HTTPS, so the security of the connection
  is your responsibility.
- **Username** — the Datahub API username, sent when the handler requests an
  access token.
- **Password** — the matching password. Note that this value is stored in plain
  module configuration and is not masked, so restrict who can reach this form and
  who can read your site's exported configuration.

A fetched access token is cached in the same configuration after the first
successful call; re‑saving the form refreshes it. Click **Save configuration**
when done.

## 2. Add and map the handler on a webform

1. Go to **Structure → Webforms** and edit the webform whose submissions should be
   sent to Datahub.
2. Open its **Settings → Emails / Handlers** tab and click **Add handler**.
3. Choose **Webform Datahub** from the handler list.
4. In the handler settings, use the **mapping** control to connect each Datahub
   attendee field (for example first name, surname, email, company, and any event
   codes the API expects) to the corresponding element on your webform.
5. Save the handler, then save the webform.

From then on, every time someone submits that webform the handler fetches a fresh
access token, builds the attendee payload from your mapping, and POSTs it to the
Datahub registration endpoint. If a submission does not appear in Datahub, check
Drupal's log (**Reports → Recent log messages**) — the handler records the full
API request and response there for both successes and errors, which is the fastest
way to debug a failed registration.
