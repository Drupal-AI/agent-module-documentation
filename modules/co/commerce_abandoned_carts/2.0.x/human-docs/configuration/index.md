# Configuration

Everything the module does is controlled from one settings form.

## Open the settings form

1. Log in as a user with the **Administer commerce abandoned carts** permission.
2. Go to **Commerce → Configuration → Abandoned carts**, or navigate directly to
   `/admin/commerce/config/abandoned_carts`.

## Timing: when a cart counts as abandoned

- **Timeout** — how many minutes a cart must sit idle before a reminder is sent.
  The default is **1440** minutes (one day). Lower it to chase carts sooner, raise
  it to give shoppers more time.
- **History limit** — how far back the module looks for abandoned carts, in
  minutes. The default is **21600** (fifteen days). Carts older than this are
  ignored, so you don't email people about long-dead carts.

## Volume control

- **Batch limit** — the maximum number of reminder emails sent per cron run
  (options 5, 10, 25, 50, 75, 100; default **5**). This keeps a single cron run
  from sending a flood; the oldest abandoned carts are handled first.

## The sender and the message

- **From email** — the sender address. Leave it blank to fall back to the store's
  email, and then the site email.
- **From name** — the sender name. Blank falls back to the store name.
- **Subject** — the email subject line (default "Your order is incomplete.").
- **Customer service phone number** — an optional phone number shown in the email
  so a shopper who had trouble at checkout can call for help. Leave blank to omit
  it.

The email body itself comes from a Twig template
(`commerce_abandoned_carts_email.html.twig`). To customize the wording, copy that
template from the module into your theme, edit it, and clear the cache. The
template has access to the `order`, `order_number`, `site_name`, and `phone`
variables.

## BCC (optional oversight copy)

- **BCC active** — when turned on, every reminder is blind-copied to an internal
  address so you can monitor what's going out.
- **BCC email** — the address to BCC. The form requires this when BCC is active.

## Test mode — read this before going live

- **Test mode** — **on by default.** While it's on, *every* reminder is
  redirected to the **test mode email** address instead of the customer, and
  orders are **not** marked as sent. That means the same carts re-send on each
  cron run, which is exactly what you want while tuning the timing and the
  template — but it also means no real customer is emailed yet.
- **Test mode email** — the single address that receives all mail while test mode
  is on. The form requires this when test mode is active. (If test mode is on but
  this address is empty, cron simply aborts the send with a log notice.)

## Save

Click **Save configuration**.

## Going live checklist

1. Set a real **From email** / **From name** (or rely on the store defaults).
2. Set a real **Subject** and review the email template.
3. Confirm reminders look right by letting cron run with **test mode on** — they'll
   arrive at your test address.
4. Turn **test mode off**. From now on reminders go to customers, and each order is
   recorded as notified so it is never emailed twice.
5. Make sure real **cron** runs on a schedule — sending only happens on cron, and
   each run logs "Sent N abandoned cart emails."
