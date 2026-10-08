# Configuration

Setting up Commerce Amazon SP-API follows the initial‑setup sequence below. You'll
create an app and marketplace in Drupal, sync inventory, then turn on order
integration.

## 1. Create your SP-API app in Amazon Seller Central

In Amazon Seller Central, create an **SP‑API type app** (choose **Sellers** under
Business entities), then **self‑authorize** your app and copy the **refresh
token**. You'll also have your **LWA client ID and client secret** and your
**Seller (merchant) ID**. Keep the client secret and refresh token as secrets (see
[Installation](../installation/index.md)).

## 2. Create an Amazon App in Drupal

1. Go to **Amazon Apps** (`/admin/commerce/amazon/apps`) and add an app.
2. Fill in the token and client data from Seller Central.
3. Choose the **mode** (test/sandbox vs live) appropriate to your credentials.

The Amazon App handles authentication and lists the markets available from your
Amazon merchant account.

## 3. Create an Amazon Marketplace

1. Go to **Amazon Marketplaces** (`/admin/commerce/amazon/marketplace`) and add
   one.
2. Choose the **Amazon App** you created in the previous step.
3. Choose the **marketplace** — you can select only one region per marketplace
   entity.
4. Leave **Sync items from FBA inventory** enabled if you want automatic inventory
   sync.
5. Select the **conditions** under which an order placed in Drupal should be sent to
   Amazon for fulfillment.

## 4. Sync inventory

Run **cron** to perform the initial inventory sync. This links Amazon items to your
Drupal product variations (as **Amazon Item** entities under the marketplace).

## 5. Marketplace integration settings and order workflow

Open the **Settings** operation on your marketplace
(`/admin/commerce/amazon/marketplace/{id}/integration`) and configure:

- **Sync period** — how often inventory syncs: **10, 15, 30 or 60 minutes**.
- **Fulfillment policy** (FillOrKill / FillAll / FillAllAvailable) and **shipping
  speed** (Standard / Expedited / Priority) used when creating Amazon orders.
- **Low inventory threshold** — below which orders are no longer sent to Amazon.
- **Order‑type workflow integration** — per order type, enable automatic workflow
  integration and **map each Amazon fulfillment transition to a Commerce order
  transition**, so your order state advances automatically as Amazon reports
  progress.

## 6. Place a test order

Place an order that meets your marketplace conditions and confirm an **Amazon
Fulfillment** record is created (linked to the Commerce order) and that the order's
state transitions as Amazon reports progress.

## A note on data and security

The module calls the Amazon SP‑API using your LWA credentials (client secret and
refresh token) — keep them secret and connect over HTTPS. Order data sent to Amazon
for fulfillment includes
**customer PII**, so make sure this transfer is consistent with your privacy policy
and obligations.
