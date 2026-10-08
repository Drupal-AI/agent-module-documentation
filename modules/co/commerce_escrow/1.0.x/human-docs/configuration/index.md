# Configuration

Setting up Commerce Escrow touches four places: the payment gateway, your order
type, your product variation type, and Escrow.com itself.

## 1. Add the payment gateway

1. Go to **Administration → Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
2. Choose the Escrow plugin (**Escrow Pay** and/or **Escrow Offer**).
3. Provide:
   - **API key** — your Escrow.com API key.
   - **Email** — the email of the Escrow.com account holder.
   - **Mode** — **Live** or **Test**.
4. Save.

## 2. Choose the Escrow workflow on your order type

Go to **Commerce → Configuration → Order types**, edit the order type you want to
use with Escrow, and under **Workflow** choose **Escrow Workflow**. This lets the
order's states be driven by Escrow.com's webhook updates.

## 3. Apply the Escrow Item trait to your product variation type

Go to **Commerce → Configuration → Product variation types**, edit the variation
type you want to sell through Escrow, and under **Traits** enable **Escrow Item**.
The variation type then gains escrow‑specific fields, including:

- **Brokered** — whether you are brokering the sale between a buyer and seller.
- **Broker fee percentage** and **broker fee split** (buyer, seller, or shared).
- **Escrow fee** split (buyer, seller, or shared).
- **Escrow item type** — the type of goods sold via Escrow.com.
- **Inspection period** — how long the Escrow offer is valid (1–30 days).
- **Display Escrow fee information** — show an estimated fee during checkout.
- **Extra attributes fees**, **Single item**, and **In stock** options.

## 4. Set the webhook on Escrow.com

In your Escrow.com account, set the webhook URL to
`https://yourwebsite.com/payment/webhook/escrow` so payment and order states stay
synchronised in real time.

## Store your API credentials securely

Your Escrow.com API key is a secret. Prefer storing it in an environment variable
and referencing it (for example through a Key entity or from settings) rather than
committing it to exported configuration:

```bash
ddev dotenv set .ddev/.env --escrow-api-key=<value>
ddev restart
```

## Customising the workflow (optional)

You do not have to use the provided order and payment workflow (the Escrow Item
product‑variation trait is the only hard requirement). You can stop the automated
state changes by subscribing to the `EscrowEvents::ESCROW_WEBHOOK` event and
calling its `setStopWebhook()` method, and enrich or alter the outgoing
transaction payload via `EscrowEvents::ESCROW_ORDER_PAYLOAD`. The bundled
`EscrowClient` exposes the Escrow.com API methods for use in custom code.
