# Configuration

Konfhub Integration's setup has two parts: give Drupal your KonfHub credentials
(stored securely), and register your site's webhook endpoint in KonfHub so booking
events are posted to it. You need the **Administer site configuration** permission
(an administrator by default) to reach the settings form, which lives under
**Configuration**.

## Get your KonfHub credentials

In your KonfHub account, obtain the **API credentials** for the event(s) you want
to integrate. Copy them for the next step.

## Store the credentials securely (recommended)

The KonfHub credentials are secrets. Rather than pasting them straight into the
form — where they can end up in a configuration export and in git — store them in
an environment variable and reference them from Drupal.

With DDEV, save the value into the project's dotenv file and restart so the
container picks it up:

```bash
ddev dotenv set .ddev/.env --konfhub-api-key=<your-key>
ddev restart
```

That makes the value available as `KONFHUB_API_KEY` inside the container. Never
commit `.ddev/.env`. Where the module accepts a
[Key](https://www.drupal.org/project/key) entity, create one backed by that
environment variable and select it here; otherwise reference the variable from
`settings.php` with `getenv('KONFHUB_API_KEY')`.

## Enter the settings

On the module's settings form, provide your **KonfHub API credentials** (or the
Key/environment reference you set up). Save the form.

## Connect the webhook

The module provides a **webhook listener** that receives POST events from KonfHub
when tickets are booked. In your KonfHub account, register your site's webhook
endpoint so those events are delivered to it. A couple of practical points:

- Make sure the endpoint is served over **HTTPS** so ticket data isn't sent in the
  clear.
- The endpoint accepts inbound POSTs from KonfHub — configure only KonfHub to post
  to it, and confirm bookings are arriving before relying on it in production.

## View the ticket data

The ticket details the module stores are exposed to **Views**. Go to **Structure →
Views** (`/admin/structure/views`) to build attendee lists, reports, or any custom
listing over the received data.
