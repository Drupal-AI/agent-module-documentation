# Configuration

Klaviyo CRM's setup is short: give it your Klaviyo API key (stored securely),
then point your forms and events at Klaviyo. You need the module's administration
permission (an administrator has it by default) to reach the settings form, which
lives in the **Web services** area under **Configuration**.

## Get your Klaviyo API key

In your Klaviyo account, create a **private API key** with permission to create
contacts (profiles) and events. Copy it for the next step.

## Store the API key securely (recommended)

The Klaviyo API key is a secret. Rather than pasting it directly into the form —
where it can end up in a configuration export and in git — store it in an
environment variable and reference it from Drupal.

With DDEV, save it into the project's dotenv file and restart so the container
picks it up:

```bash
ddev dotenv set .ddev/.env --klaviyo-api-key=<your-key>
ddev restart
```

That makes the value available as `KLAVIYO_API_KEY` inside the container. Never
commit `.ddev/.env`. Where the module accepts a
[Key](https://www.drupal.org/project/key) entity, create one backed by that
environment variable and select it on the settings form; otherwise reference the
variable from `settings.php` with `getenv('KLAVIYO_API_KEY')`. Either way, the key
stays out of your git history, and requests to Klaviyo travel over HTTPS.

## Enter the settings

On the module's settings form, provide the **Klaviyo API key** (or the
Key/environment reference you set up). This authenticates every request the module
makes to Klaviyo. Save the form.

## Connect your forms and events

- **Webform → Klaviyo** — with the API key in place, Webform submissions can be
  synced to Klaviyo as contacts/events, so a sign‑up or contact form populates
  your Klaviyo lists.
- **Klaviyo form blocks** — go to **Structure → Block layout**
  (`/admin/structure/block`), place a Klaviyo form block in a region, and it will
  render your Klaviyo‑hosted form on the page.

## A note on data egress

This module sends **contact information (PII) and events to the Klaviyo API** —
data leaves your site to reach a third‑party service. Make sure this is reflected
in your privacy policy and that you are comfortable with the data flow.
