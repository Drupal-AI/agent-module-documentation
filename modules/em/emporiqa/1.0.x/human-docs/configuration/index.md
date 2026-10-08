# Configuration

Emporiqa is a two‑sided setup: a little configuration in Drupal (a signing secret
and catalog sync) and the rest — the widget, playground, and dashboard — in your
Emporiqa account. Grant the module's permissions only to trusted administrators,
since they control the storefront connection.

## 1. Create an Emporiqa account

Sign up at **https://emporiqa.com** (free to start, with signup credit and no card
required). You'll use the Emporiqa dashboard for the account‑side pieces: the
playground, widget wording, business hours, live take‑over, and the
chat‑attributed revenue dashboard.

## 2. Set the signing secret in Drupal

Emporiqa issues a signed **user‑identity token** so the chat widget can identify a
logged‑in shopper. That token is HMAC‑signed with an admin‑configured
**`webhook_secret`**.

- **Set a strong secret.** Use a long, high‑entropy value.
- Enter it on the module's settings form (**Configuration → Web services →
  Emporiqa**, the *Connection Secret* field). Copy it from your Emporiqa dashboard's
  Store Settings → Integration tab.
- If the secret is unset, the token endpoint returns nothing — so the widget can't
  identify users until you configure it.

## 3. Sync your catalog and content

Emporiqa answers from *your* data, not the language model's training, so it needs a
sync:

- **Products and variations** sync through Drupal's entity API with resolved,
  promotion‑aware prices (a reduced product is quoted at its sale price, with the
  original price, and quantity breaks are quoted for the quantity asked about).
- **Any content type** (shipping, returns, FAQs) syncs through its display modes.
- **Stock** reads from Commerce Stock, custom fields, or publish status.

Use the module's **Drush commands** to run and control the sync (run `drush list |
grep emporiqa` to see the available commands), and the module's **alter hooks** if
a developer needs to customise what is synced.

## 4. Try it in the playground, then go live

In the Emporiqa dashboard you can use the **playground** to chat against your real
catalog before the widget is live on the storefront — switch language and edit the
widget wording as you go, which is handy for sign‑off. When you're satisfied,
enable the widget so it appears on your storefront.

## What shoppers get

Once configured and synced:

- The assistant recommends products from your catalog, handles objections, and
  says so when asked for something you don't sell.
- **In‑chat cart and checkout** — the item is actually placed in the cart by the
  plugin (through the session cart and Commerce's cart provider, with CSRF
  protection and your store's own stock and variation checks), and the confirmation
  the shopper reads is built from what really landed in the cart.
- **Live take‑over** — handoff alerts can reach Slack, Microsoft Teams, Discord,
  Google Chat, or email, and a team member can join and reply inside the
  conversation. Business hours and timezone are set per store; outside them the
  chat collects an email or phone number.

For the full feature list and screenshots, see emporiqa.com.
