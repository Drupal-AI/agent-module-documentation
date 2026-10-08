# Configuration

This module isn't configured from a central settings page — you configure it
per-webform, by adding its handler to each form that should create Salesforce leads.

## Add the handler to a webform

1. Go to **Structure → Webforms** (`/admin/structure/webform`) and edit the webform
   you want to connect (or build a new one).
2. Open the webform's **Settings → Emails / Handlers** tab.
3. Click **Add handler** and choose the **Salesforce Web2Lead** handler.

## Configure the handler

In the handler's settings:

- **Salesforce org ID** — enter your Salesforce organization ID. This is what the
  Web-to-Lead endpoint uses to route the lead to your org.
- **Field mapping** — map each of your webform's fields to the corresponding
  Salesforce lead field, so the submitted values land in the right places on the
  lead record.

Save the handler, then save the webform.

## Add spam and bot protection

This step is not optional in practice. Salesforce Web-to-Lead is an
**unauthenticated** endpoint — it accepts any post that carries your org ID — so the
form is the only thing standing between the internet and your CRM. Add protection to
the webform, such as:

- a **CAPTCHA** element, and/or
- a **honeypot** anti-spam measure.

Without it, bots can submit the form repeatedly and flood Salesforce with junk
leads.

## Privacy and transport

The handler sends submitter data (names, emails, and whatever else the form
collects) to Salesforce — an external service. Make sure this is reflected in your
site's privacy policy, and serve the form (and therefore the post to Salesforce) over
**HTTPS** so the data isn't exposed in transit.

## Test it

Submit the form yourself and confirm a matching lead appears in Salesforce, with the
fields landing where your mapping said they should. Adjust the mapping if anything is
off.
