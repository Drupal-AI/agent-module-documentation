# Mailchimp Webform Handler — manual setup guide

**Mailchimp Webform Handler** (`mailchimp_webform_handler`) adds a **Webform
handler** that sends form submissions to a Mailchimp audience as new contacts —
so a signup form on your site can subscribe people directly to a Mailchimp list.

Its useful twist is that it works **without enabling the full Mailchimp module**.
You add the handler to a webform, give it its own Mailchimp API key and list, and
you're done. Because each handler carries its own API key, you can attach
**several handlers to one webform** — each pointing at a different Mailchimp
account or list — and use the webform's **conditions** to activate the right one.
That makes it straightforward to, say, subscribe people to different lists based on
the country or language they selected on the form.

Mailchimp Webform Handler depends on the **Webform** module and supports Drupal 10
and 11. Using it means holding a Mailchimp **API key** and forwarding submission
data (personal data) to Mailchimp, so handle both carefully — see the notes in
"How to use it" below.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (Webform is required).

This module has no central settings page — you configure it **per webform** by
adding its handler, described in "How to use it" below.

## Where it lives in the admin menu

There is no separate module settings page. You add and configure the handler from a
webform's **Settings → Emails / Handlers** tab (under **Structure → Webforms**).

## How to use it

1. Edit the webform you want to subscribe people from, and open its **Handlers**
   (Emails / Handlers) settings.
2. **Add** the Mailchimp handler.
3. In the handler's settings, provide:
   - Your Mailchimp **API key**.
   - The target **audience / list ID**.
   - The **field mapping** — which webform fields map to which Mailchimp merge
     fields (email, name, and so on).
4. Optionally add **more handlers** to the same webform, each with its own API key
   and list, and use the webform's **conditions** to choose which handler fires for
   a given submission.
5. Save the webform, then submit a test entry and confirm the contact appears in
   the intended Mailchimp audience.

## Handle the API key and submission data carefully

Two things deserve care:

- **The API key is a credential.** This handler stores the key in the webform's
  handler configuration, which means it can end up in exported configuration and
  version control. Treat the key as a secret: restrict who can edit webform
  handlers, and be mindful of where that configuration is exported and stored.
- **Submissions are personal data sent to a third party.** The handler forwards
  submission fields to Mailchimp. Capture **consent** before adding someone as a
  contact (don't silently subscribe everyone who submits), **disclose** the
  marketing use in your privacy policy, and make sure it's compatible with
  regulations such as GDPR.
