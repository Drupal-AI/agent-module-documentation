# Configuration

All of the module's behaviour is set on one form. Before you point it at live
customers, read the "Sending responsibly" note at the bottom of this page.

## Open the settings form

1. Log in as a user with permission to administer the module's settings.
2. Go to `/admin/config/commerce/cart-reminder/settings`.

## Reminder timing

- **Enable Cart Reminder** — the global on/off switch. Leave it off until you have
  finished configuring and tested in test mode.
- **Send reminder after (hours)** — how many hours after a cart is created (and
  left without checkout) the reminder email is sent. Reminders are dispatched
  automatically via cron/queue, so make sure cron runs on a sensible schedule.

## Email content

- **Subject** — the reminder email's subject line.
- **Body** — the email body, edited with a rich‑text editor so you can build a
  visually appealing template.
- **Tokens** — personalize both subject and body with tokens such as
  `[user:name]`, `[user:mail]`, and the secure **`[cart:link]`** token that
  becomes the customer's cart‑restore link. Include `[cart:link]` in the body so
  the recipient has something to click.

## Copies and testing

- **CC / BCC** — optional administrative addresses that receive a copy of each
  reminder, useful for monitoring what is going out.
- **Test mode** — when enabled, **all** reminder emails are diverted to a single
  test address instead of reaching customers. Always use this while you are
  building and previewing the template, and switch it off only when you are
  confident the emails and restore links work.

## Cart cleanup

- **Automated cart deletion** — configure a timeframe after which old, abandoned
  carts are automatically deleted, keeping the database clean. Set this with your
  reminder window in mind, so carts aren't deleted before a reminder has had a
  chance to work.

## Bulk sending and referral links

- **Bulk operations** — from the Commerce **order listing** page you can send
  reminders to multiple carts at once. There is an option to **resend** reminders
  to carts that already received one during a bulk run, so use it carefully to
  avoid over‑emailing.
- **Referral links** — from an individual **order's detail page** you can generate
  a secure referral link. Copy and share it with a customer, or let the customer
  share it; anyone who clicks it gets that order's items added to their cart. Ideal
  for reorders, referrals, and promoting bundles.

## Sending responsibly

The reminder and referral emails contain **customer personal data** (cart
contents, name, email). Handle it accordingly:

- Only email customers who have a **lawful basis / marketing consent** to receive
  reminders, per the privacy rules that apply to you.
- Respect **unsubscribe** expectations and provide a way to opt out.
- Keep the **send frequency and timing sane** — a single well‑timed nudge recovers
  carts; repeated emails read as spam.
- Because restore and referral links grant access to a cart's contents, treat them
  as sensitive and rely on the secure, per‑cart links the module generates rather
  than exposing cart data any other way.
