# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **Commerce Order** (`commerce_order`) — the module provides a Commerce inline form
  and integrates with the checkout/profile flow.
- For the optional submodules: **Commerce Shipping** and/or **Commerce Payment**,
  respectively, since those panes extend those integrations.

There are no third‑party Composer or PHP library requirements. This release is a
beta, so try it on a non-production copy first.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_profile_inline_form_radios -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_profile_inline_form_radios -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_profile_inline_form_radios -y
```

## Submodules

The project ships three optional submodules that reuse the parent module's inline
form. Enable only the ones matching your checkout integrations:

| Submodule (machine name) | Provides |
|--------------------------|----------|
| **Shipping** (`commerce_profile_inline_form_radios_shipping`) | Overrides the `shipping_information` checkout pane to use the radio-button inline form. Requires Commerce Shipping. |
| **Payment** (`commerce_profile_inline_form_radios_payment`) | Overrides the `payment_information` checkout pane to use the radio-button inline form. Requires Commerce Payment. |
| **PayPal** (`commerce_profile_inline_form_radios_paypal`) | Overrides the PayPal Checkout add-payment-method form's billing profile to use the radio-button inline form. Requires Commerce Payment and Commerce PayPal. Supports Drupal 9 and 10 only (not 11). |

Enable one with `drush en`, for example:

```bash
drush en commerce_profile_inline_form_radios_shipping -y
```

(Check the module's own `.info.yml` files for the exact submodule machine names in
your copy before enabling.)

## Verify it worked

As a returning customer with more than one saved profile, go through checkout. Where
the profile is collected you should see your saved profiles presented as radio
buttons, letting you pick one instead of re-typing an address. If you enabled a
shipping or payment submodule, confirm its pane appears in your checkout flow.
