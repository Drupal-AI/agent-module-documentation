# Slack Webform Handler — manual setup guide

**Slack Webform Handler** (`slack_webform_handler`) extends the popular
[Webform](https://www.drupal.org/project/webform) module by posting a message to
a Slack channel whenever one of your webforms is submitted. It works through a
Webform *handler*: you attach the handler to a form, give it a Slack incoming
webhook URL, and from then on every submission of that form sends a notification
into the chosen Slack channel — handy for keeping a team on top of contact-form
enquiries, sign-ups, and the like.

The module depends on the Webform module. It has no global settings page of its
own — configuration happens per form, on the form's **Emails / Handlers** screen,
which is where you paste the webhook URL. It carries no access-control role.

Two things to keep in mind, because the module sends data out to an external
service:

- **The webhook URL is a secret.** Anyone who has it can post into your Slack
  channel, so treat it like a password — ideally store it via an environment
  variable or the Key module rather than committing it into exported
  configuration, and always use the HTTPS webhook URL Slack gives you.
- **Submission data leaves your site.** The handler sends submission content to
  Slack, and form submissions can contain personal data (PII). Send only what you
  need and make sure this is disclosed in line with your privacy policy.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

First, create a Slack incoming webhook and copy its URL:

1. In your Slack workspace, open **Browse apps** and select (or create) an app.
2. Choose the **Incoming Webhooks** feature and, under *Webhook URLs for your
   workspace*, **Create new webhook**. Pick the channel where submissions should
   appear (create a channel first if you need to).
3. Click **Allow** to grant the app permission, and copy the unique **Webhook
   URL** it gives you.

Then attach the handler to a form in Drupal:

1. Go to your form's build screen — **Structure → Webforms →** *your form* **→
   Settings → Emails / Handlers**.
2. Choose **Add handler** and select the **Slack** handler this module provides.
3. Paste your Slack webhook URL into the handler configuration and save.

Now, each time that form is submitted, a message is posted to your Slack channel.
