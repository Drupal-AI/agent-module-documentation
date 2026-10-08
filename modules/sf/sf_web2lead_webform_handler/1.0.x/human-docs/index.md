# Salesforce Web2Lead Webform Handler — manual setup guide

**Salesforce Web2Lead Webform Handler** (`sf_web2lead_webform_handler`) adds a new
Webform handler that turns form submissions into leads in Salesforce. When a visitor
submits a form you've attached the handler to, it posts the mapped fields to
Salesforce's **Web-to-Lead** endpoint using your Salesforce org ID — so an enquiry
form on your Drupal site becomes a lead record in your CRM without any custom code.

It works by adding a handler plugin to the Webform module: you build your form as
usual, add this handler to it, and map your form fields to Salesforce lead fields.
The module depends on the **Webform** module and lives in the Webform package. It
supports Drupal 10 and 11.

Because it sends real submitter data to a third party, there are a few things to get
right, and they're worth knowing up front:

- **You're sending PII off-site.** Submissions (names, emails, whatever the form
  collects) leave your site for Salesforce. Handle that in line with your privacy
  policy, and always post over **HTTPS**.
- **Salesforce Web-to-Lead is unauthenticated by design.** The endpoint accepts
  posts keyed only by your org ID — there's no secret. That means the *form itself*
  is the trust boundary, so add spam and bot protection (a CAPTCHA, a honeypot) to
  the webform, or it can be abused to inject junk leads.

The handler has no access-control role of its own. This guide is written for a
**human** setting the module up through the admin UI. If you want terse, token-cheap
references for an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add the handler to a webform and map
   fields to Salesforce.

## How to use it

There is no site-wide settings page — you configure the handler on each webform that
should create leads. On the webform's **Settings → Emails / Handlers** screen you
add the **Salesforce Web2Lead** handler, enter your Salesforce org ID, and map form
fields to Salesforce lead fields. See [Configuration](configuration/index.md).
