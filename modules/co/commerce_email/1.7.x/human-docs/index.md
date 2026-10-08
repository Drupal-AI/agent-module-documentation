# Commerce Email — manual setup guide

**Commerce Email** (`commerce_email`) gives Drupal Commerce a friendly admin UI for
defining the emails your store sends in response to events — an order being placed, an
order being paid, an order moving through its workflow (shipped, canceled, fulfilled), a
customer registering during checkout, and more. Instead of writing custom code for each
notification, you create **email definitions** in the UI and tie each one to a store
event.

Each email is fully configurable: a token-replaced **subject** and **body** (so you can
drop in the order number, total, customer name, and so on), **recipient rules** (a
specific address or token, or everyone with a given role), optional **Cc / Bcc /
Reply-to**, and **conditions** that limit when the email sends (for example only for
orders over a certain amount, or for a specific store or order type). You can have several
emails fire for the same event — one to the customer, one to the warehouse, one to
accounting.

Emails can be sent **immediately** or **queued** for background sending (via cron, or via
Advanced Queue if that module is installed) so high-volume mail doesn't slow down
checkout. Each definition also has a built-in **Test email** form so you can preview
delivery before going live, and can optionally log every send to the order's timeline.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Commerce.
2. [Configuration](configuration/index.md) — creating an email definition, field by
   field, and how the options work.

## Where it lives in the admin menu

Emails are managed at **Commerce → Configuration → Emails**
(`/admin/commerce/config/emails`), behind the **Administer commerce_email** permission.
There is no separate global settings page — each email is its own definition you add,
edit, and enable/disable from that list.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to **Commerce → Configuration → Emails** and click **Add email**.
3. Choose the **event** that should trigger it (for example *Order placed*), then set the
   recipients, subject, body, and any conditions.
4. Save, then use the **Test email** tab to send yourself a preview.

See [Configuration](configuration/index.md) for a full walkthrough of every field.
