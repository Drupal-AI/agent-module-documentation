# Configuration

Configuring Email Octopus is a three‑step flow: enter your API key, confirm the
module can see your lists, and place a subscribe block for the list you want.

> **Access note:** The admin forms below are gated by a permission string
> (`administer`) that does not correspond to a real Drupal permission, so in
> practice only **user 1** can reach them. If another administrator cannot open
> the forms, this is the reason.

## Step 1 — Add your EmailOctopus API key

1. Go to `/admin/config/credentials` (the Email Octopus configuration form).
2. Paste your **EmailOctopus API key** — it is required for any integration to
   work.
3. Save.

### About storing the key

This module stores the API key in **plain configuration** (`octopus.adminsettings`)
— it does **not** integrate with the Key module. Because of that:

- **Do not commit the exported configuration** that contains the key, and exclude
  it from configuration sync, or the secret will land in version control.
- Rotate the key by returning to this form and updating it.
- Be aware the key is transmitted to EmailOctopus in request bodies/query strings
  (over HTTPS, with TLS verification on).

## Step 2 — Confirm your lists load

Go to the **Subscriber / Unsubscriber list** browser at `/admin/config/users-list`.
The module fetches your EmailOctopus lists into a select, and for the chosen list
shows its subscribed and unsubscribed contacts in a table. If the lists do not
appear, re‑check that the API key is saved correctly.

## Step 3 — Place a subscribe block

1. Go to **Structure → Block layout** (`/admin/structure/block`) and click
   **Place block** in the region you want.
2. Choose the **Email Octopus Subscribe Form** block.
3. Configure the block instance:
   - **Required list** — the EmailOctopus list this block subscribes people to.
   - **Block title**
   - **Block body**
   - **Thank you message** — shown after a successful subscription.
4. Save the block. You can repeat this to place several blocks, each targeting a
   different list.

## Protect the public subscribe form

The subscribe block is exposed to anonymous visitors and has **no built‑in CAPTCHA
or rate limiting**, so a bot could submit arbitrary addresses and consume your
EmailOctopus API quota. On a production/public site, add a spam‑protection or
CAPTCHA module and apply it to this form.

## Verify

Visit a page where you placed the block as an anonymous visitor, submit a test
email, and confirm the thank‑you message appears. Then open
`/admin/config/users-list`, select the target list, and check that the address
shows up among the subscribers.
