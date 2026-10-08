# Configuration

This module has no global settings page. Instead, you configure it **per webform**
by adding the Discord handler to each form that should post to Discord.

## Add the Discord handler to a webform

1. Log in as a user who can administer webforms.
2. Go to **Structure → Webforms** (`/admin/structure/webform`) and open the form
   you want to wire up.
3. Open its **Settings → Emails / Handlers** tab
   (`/admin/structure/webform/manage/<form>/handlers`).
4. Click **Add handler** and choose the **Discord** handler from the list.

## The handler settings

- **Discord Webhook URL** — paste the incoming webhook URL you copied from Discord
  (the channel's **Integrations → Webhooks → Copy Webhook URL**). This is the key
  field: it decides which Discord channel receives this form's submissions. It is a
  URL field, entered by an administrator, so it is not something a site visitor can
  tamper with. Keep it secret — anyone holding it can post to the channel.

Webform's standard handler options also apply here — for example, you can give the
handler a **Title** and **machine name**, toggle whether it is **enabled**, and (on
some Webform versions) restrict it to certain submission states. Save the handler
when done.

## How submissions are sent

Once the handler is enabled with a valid webhook URL, every matching submission is
posted to that Discord channel automatically — no further action needed. You can
add the handler to as many forms as you like, each pointing at whichever channel
suits that form.

## A note on egress and privacy

Submission data is **sent out to a third party**. Whatever fields the form
collects — which may include names, email addresses, or free‑text messages — leave
your site and land in Discord. Bear that in mind when choosing which forms post to
Discord and who can read the target channel, and keep the webhook URL out of
version control.
