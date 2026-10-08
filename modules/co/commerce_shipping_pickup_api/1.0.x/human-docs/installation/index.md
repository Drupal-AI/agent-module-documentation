# Installation

## Requirements

- **Drupal 8.7.7+, 9, 10, or 11**
  (`core_version_requirement: ^8.7.7 || ^9 || ^10 || ^11`).
- **Drupal Commerce** — hard dependencies are `commerce`, `commerce_checkout`,
  `commerce_shipping` and `profile`, installed automatically as Composer
  dependencies.
- No third‑party PHP libraries are required.

Remember that this is only the framework. To offer pickup delivery for real you
also need a **provider** — either the bundled demo submodule or a separate
provider project such as Foxpost, GLS CsomagPont, Magyar Posta, or Pick Pack
Pont.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_shipping_pickup_api -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies (such as Commerce) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_shipping_pickup_api -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_shipping_pickup_api -y
```

## Submodules

The project ships two optional submodules — enable them individually with
`drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Pickup demo** | `commerce_shipping_pickup_demo` | A very simple sample provider with two hard‑coded pickup points, so you can wire up the checkout pane and a shipping method and watch the pickup flow work before installing a real carrier. Great for learning the setup. |
| **Pickup In-store** | `commerce_shipping_pickup_store` | A basic provider offering pickup at a single preset address (for example, in‑store pickup). The pickup address is configured on the shipping method. |

For example, to try the demo provider:

```bash
drush en commerce_shipping_pickup_demo -y
```

## Verify it worked

After enabling the framework (and a provider), go to **Commerce → Configuration
→ Shipping methods** and start adding a shipping method — you should be able to
pick a pickup provider's plugin. In your checkout flow
(**Commerce → Configuration → Checkout flows**) you should also see the pickup‑
capable **Shipping information** pane available to add. If you enabled the demo
submodule, place a test order and confirm you can choose one of its two sample
pickup points at checkout.
