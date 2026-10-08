# Configuration

Setting up Modular Finance is a three‑step process: enter the global client token,
create one or more widget types, then place a block for each widget you want to
show.

## 1. Enter the global client token

1. Go to `/admin/config/modular_finance/settings` (this requires the **Access
   administration pages** permission).
2. Enter the **client token** supplied by Modular Finance and save. This value is
   stored in the `modular_finance.settings` configuration and is shared by every
   widget on the site — it is emitted to each widget as the `c` value.

## 2. Create one or more Modular finance types

Each widget you embed is described by a **Modular finance type** config entity.

1. Go to the type collection (**Modular finance types**,
   `entity.modular_finance_type.collection`).
2. Add a new type and give it:
   - a **widget type** — which Modular Finance widget this is (share price,
     ownership, and so on), and
   - a **widget token** — the token Modular Finance issued for that specific widget.
3. Save. You can create as many types as you have widgets to display.

## 3. Place the Modular finance block

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Place the **Modular finance block** (`modular_finance_block`) in the region where
   you want the widget to appear.
3. In the block form, **select the type** you created above, and configure the usual
   block visibility settings.
4. Save the block.

## What happens on the page

When the block renders it attaches the `modular_finance/modular-finance` library and
pushes the following into `drupalSettings.modularFinance` for the vendor JavaScript
to pick up: the CSS selector for the widget, the widget type, the widget token, the
current language/locale, and the global client token. The Modular Finance script
then draws the widget in the browser.

## A note on the tokens and secrets

Both the client token and the widget tokens are **published to the page** by design
— they are the vendor's publishable widget keys, meant to be visible in client‑side
code, not private API credentials. There is therefore nothing to store in a Key
entity or environment variable here, and you should **not** place any private
credential in these fields. Because the module makes no server‑side request to
Modular Finance, there is no outbound API connection or TLS verification to
configure.
