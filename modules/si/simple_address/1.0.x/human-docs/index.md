# Simple Address — manual setup guide

**Simple Address** (`simple_address`) provides a lightweight **address field** for
content — one that presents the *same* set of address inputs for every country and
does *no* per-country validation. It exists as a deliberately simpler alternative
to the well-known [Address](https://www.drupal.org/project/address) module: where
Address gives you strict, country-specific formats and validation (ideal for
delivery or billing), many content sites just want somewhere to type an address
without all that machinery. This module fills that gap, while still borrowing the
country / state / province data from the Address module so users get a helpful
list when picking a state or province.

It depends only on core's **Field** module, has no submodules, and there is no
central settings form — you add and configure it like any other field, on a
content type or other fieldable entity via *Manage fields*. The stored value is
ordinary user input rendered normally, so it inherits the entity's usual access
and output handling and plays no access-control role of its own.

The trade-off to be aware of is exactly the one it is named for: **no validation**.
Entered addresses are not checked for correctness or completeness, so this suits
informal address collection — a contact detail, a location note — rather than
shipping or billing flows where a validated, correctly formatted address matters.
For those, reach for the full Address module instead. Note also that this project
is **not covered by Drupal's security advisory policy**, and this 1.0.x branch is a
development release.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

There is no settings page. After enabling the module, go to the content type (or
other entity) where you want an address, choose **Manage fields → Add field**, and
pick the **Simple Address** field type. Then set the widget and formatter on
*Manage form display* and *Manage display* as you would for any field. Every
country shows the same address layout, and no correctness validation is applied.
