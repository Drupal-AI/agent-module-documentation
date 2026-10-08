# Configuration

Setting up Page Notifications has four parts: place the subscribe block, grant the
admin permissions, tune the settings and email templates, and (recommended) add
CAPTCHA to the public form.

## 1. Place the subscribe block

The subscribe form is a block. Go to **Structure → Block layout**
(`/admin/structure/block`), place the **Page Notifications** subscribe block in a
region, and set its visibility so it appears on the content you want visitors to be
able to watch (for example, article, documentation, or policy pages). Save.

## 2. Grant permissions

Under **People → Permissions** (`/admin/people/permissions`):

- **Access protected page notifications** — a **restricted** permission that grants
  access to the admin tooling under `/admin/page-notifications/*` (settings,
  message templates, subscription lists, and migration forms). Give it only to
  trusted administrators.
- **View page notifications reports** — lets a role view the per‑node and site‑wide
  subscriber lists for reporting.

The public subscribe, confirm, and self‑service unsubscribe flows are available to
anonymous visitors by design (they are keyed by the tokens in the emailed links),
so subscribers do not need any account or permission.

## 3. Settings and email templates

Open the admin area at **`/admin/page-notifications`** (settings config route
`page_notifications.tabs`). From its tabs you can:

- Adjust the module's settings.
- Customize the **notification** and **confirmation** email templates that
  subscribers receive.
- Browse per‑node and site‑wide **subscription lists** for reporting.
- Use the **migration** forms to import legacy subscriptions or convert existing
  nodes into the subscription content type.

Subscriptions themselves are stored as nodes of a `page_notify_subscriptions`
content type, each carrying the subscriber email, the target node/term, and the
tokens that power the self‑service links.

## 4. Add CAPTCHA (recommended)

On a public, anonymous subscribe form, bot protection matters. Install and enable
the **CAPTCHA** and **reCAPTCHA** modules — Page Notifications detects reCAPTCHA
automatically once it is enabled and applies it to the subscribe form, with no
extra wiring needed.

## Sending notifications

When an editor saves a watched node and ticks the notify checkbox, the module emails
subscribers immediately with an optional short note about the change. There is
nothing to schedule for immediate delivery.
