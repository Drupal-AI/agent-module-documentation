# Commerce Square — manual setup guide

**Commerce Square** (`commerce_square`) connects **Square's** Connect payment
APIs to Drupal Commerce, giving your store an on-site credit-card payment gateway.
Cards are tokenized in the browser by Square's Web Payments SDK, so the raw card
number never touches your server — a PCI-friendly checkout that still keeps the
customer on your site. It accepts the major card brands (Amex, Diners Club,
Discover, JCB, Maestro, Mastercard, Visa, and UnionPay), and supports authorizing
a payment now and capturing it later, as well as refunds from the Commerce order
screen.

There are two modes: **Sandbox** (`test`) for end-to-end testing with Square's
test cards, and **Production** (`live`) for real charges. Setup happens in two
layers. First, application-level credentials go on a **Square settings** form —
your Square application name, application secret, and the Sandbox and Production
application IDs and tokens. Second, you create a Commerce **payment gateway**
using the Square plugin, where you pick the Square **location** transactions are
attributed to (fetched live from Square) and whether to show card-brand icons at
checkout.

Connecting a **production** account uses Square's OAuth flow: saving the settings
form redirects you to Square to authorize, and the access and refresh tokens
Square returns are stored in Drupal's **state** — deliberately kept out of your
exported configuration. Because these are real payment credentials, treat them as
secrets: keep them out of version control and prefer environment-based storage
over committing them in plain configuration.

The module requires **Drupal Commerce** (with Commerce Payment) and the
`square/square` PHP SDK, which Composer installs for you. Live and sandbox charges
call Square over the network, so a working internet connection to Square is needed
for real transactions.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including the
   Square SDK) and enable the module.
2. [Configuration](configuration/index.md) — enter your Square application
   credentials, connect production via OAuth, and add the Square payment gateway.

## Where it lives in the admin menu

The application settings form is at **Commerce → Configuration → Payment → Square
settings** (`/admin/commerce/config/square`), gated by the **Administer commerce
square** permission. You add the gateway itself at **Commerce → Configuration →
Payment gateways**.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. In the Square developer dashboard, obtain your application ID, secret, and
   Sandbox credentials.
3. Enter them on the **Square settings** form, and for production complete the
   OAuth authorization when the form redirects you to Square.
4. Create a Commerce **payment gateway** with the Square plugin, choose the mode
   (Sandbox or Production) and the Square location, and enable it.
5. Test the full checkout in Sandbox mode with Square's test cards before going
   live.

See [Configuration](configuration/index.md) for the field-by-field details.
