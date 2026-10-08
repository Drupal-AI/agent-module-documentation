# Installation

## Requirements

- **Drupal 8.8, 9, or 10** (`core_version_requirement: ~8.8 || ^9 || ^10`) with
  **Drupal Commerce 2.x** or newer.
- Commerce **Payment** (`commerce_payment`).
- **Yunke QR Code** (`yunke_qrcode`) — required for the PC (Native) payment QR
  code. Install it first.
- WeChat's official PHP SDK (`wechatpay/wechatpay-guzzle-middleware`) — this is
  why the module **must** be installed with Composer, so the SDK is added to the
  class loader.
- A **WeChat Pay merchant account** with your App ID, Merchant ID, APIv3 key,
  merchant certificate serial number, and merchant private key.

## Install with Composer

Because the QR code and the WeChat SDK are required, install via Composer (not by
downloading the module by hand). Install the QR‑code dependency first, then the
module:

```bash
composer require drupal/yunke_qrcode
composer require drupal/commerce_wechat -W
```

The `-W` flag lets Composer update shared dependencies as needed. Composer pulls
in the WeChat PHP SDK automatically.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_wechat -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_wechat -y
```

Enabling Commerce WeChat Pay also enables `commerce_payment` and `yunke_qrcode`
if they are not already on.

## Verify it worked

Go to **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`), click **Add payment gateway**, and
confirm **WeChat Pay** appears as a plugin. Continue with
[Configuration](../configuration/index.md).
