# Aweber Block — manual setup guide

**Aweber Block** (`aweber_block`) connects your Drupal site to
[AWeber](https://www.aweber.com/), the email‑marketing service. It provides a
**block** — typically an AWeber sign‑up / opt‑in form — that you can place in your
site's layout so visitors can subscribe to your AWeber mailing lists without
leaving the page.

Use it to grow an email list: drop the block into a sidebar, footer, or landing
page and let visitors opt in. It is an integration/marketing feature with no
access‑control role of its own.

Two things are worth keeping in mind. Because the block generally embeds AWeber's
own form or script, it loads **third‑party code** from AWeber into your pages —
which is a privacy/consent consideration if your site collects consent before
running marketing trackers. And if you connect the block to AWeber using an API
credential, treat that credential as a **secret**: never commit it to
configuration or code.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

Aweber Block adds a block rather than a dedicated settings page:

1. Enable the module.
2. Go to **Structure → Block layout** (`/admin/structure/block`) and place the
   **AWeber** block in the region where you want the sign‑up form to appear.
3. Configure the block instance with your AWeber list / form details so it embeds
   the right opt‑in form, then save.
4. If you gate third‑party scripts behind a cookie‑consent tool, make sure the
   AWeber embed is covered by that consent flow.

### Handling any AWeber credential securely

If the block needs an AWeber API credential, do not paste it into plain
configuration. Store it in an environment variable and load it from there:

```bash
ddev dotenv set .ddev/.env --aweber-api-key=<value>
ddev restart
```

Then reference the `AWEBER_API_KEY` variable through a Key entity (Key module) or
`getenv('AWEBER_API_KEY')`, and keep `.ddev/.env` out of version control.
