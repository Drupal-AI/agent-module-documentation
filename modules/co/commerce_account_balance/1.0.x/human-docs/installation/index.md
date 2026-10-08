# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3||^11`).
- **Drupal Commerce** (`commerce`) and **Commerce Price** (`commerce_price`).
- Core **User** (`user`) — always present in a standard Drupal install.

There are no additional PHP libraries or third‑party Composer packages to add.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_account_balance -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in or update any
shared dependencies, including the Commerce packages, as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_account_balance -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_account_balance -y
```

## Assign the balance permissions

Because a balance behaves like money, decide who may see and change it before you
rely on the feature. Go to **People → Permissions**
(`/admin/people/permissions`) and set:

- **`administer account balances`** — create and adjust balances. Staff/admin
  roles only.
- **`view any account balance`** — see other customers' balances. Staff/admin
  roles only.
- **`view account balance`** — controls the (currently unfinished) own‑balance
  block. Grant it only if you intend to experiment with that block.

## Verify it worked

Log in as an administrator and open an order under **Commerce → Orders** for a
customer whose email has an outstanding balance (order total greater than the
amount paid). Confirm the **Account Balance** link/section appears and that the
`/account/balance/{order}` summary table lists that customer's orders and the
balance owed on each.

> **Note.** The *Account Balance* block, the *AccountBalance* entity, and the
> balance‑adjustment form are incomplete on the current release and should not be
> relied on. The working feature is the "amount owed across orders" display on the
> order page.
