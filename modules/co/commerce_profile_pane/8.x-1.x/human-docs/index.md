# Commerce Profile Pane — manual setup guide

**Commerce Profile Pane** (`commerce_profile_pane`) provides a Drupal Commerce
checkout pane for each **Profile type** defined by the Profile module. The pane
renders that profile's form inside checkout, letting a customer create a new profile
or edit their existing one as part of placing an order — dietary requirements with a
food order, a delivery instruction, a membership number, a marketing preference,
collected in the flow rather than in a separate form nobody fills in later.

Doing this through the Profile module, rather than as fields on the order, is the
right modelling. A profile persists across orders, so a returning customer is not
asked again, and the data lives on the *customer* instead of being copied into every
order they place. You add the pane by editing your checkout flow and placing the
relevant "Profile type" pane into a checkout step.

There is no global settings screen — it is configured entirely by editing checkout
flows. It depends on **Commerce** (`commerce`), **Commerce Checkout**
(`commerce_checkout`), and the **Profile** module (`profile`), and it also requires
**Inline Entity Form** (which Commerce already uses). It supports Drupal 9, 10, and
11.

A few limitations are worth knowing up front:

- A checkout pane for the built-in **'customer'** profile type is already provided by
  Commerce core, so this module deliberately does not offer one for it.
- For profile types that allow **multiple** profiles per user, the pane loads the
  **first** such profile it finds.
- A profile pane **cannot** be placed in the **'login'** step, because that step has
  no submit button for the whole form.

Because anything collected here is stored against a person indefinitely, treat it as
personal data: have a reason for collecting each field, a retention position, and a
way for the customer to see and change it (which the Profile module supports and a
checkout-only form does not). And remember checkout is conversion-sensitive — every
extra field costs some completed orders, so ask what happens if a field is left
blank; if the answer is "nothing", it probably does not belong in checkout.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Commerce Checkout and Profile.

There is **no configuration form** — you add and position the pane by editing a
checkout flow, described below.

## Where it lives in the admin menu

The module adds no settings page. You use it from **Commerce → Configuration →
Orders → Checkout flows** (`/admin/commerce/config/checkout-flows`), where each
Profile type's form pane can be moved into a checkout step.

## How to use it

1. If needed, create the profile type you want to collect at **Configuration →
   People → Profile types**.
2. Go to **Commerce → Configuration → Orders → Checkout flows** and edit the
   checkout flow you use.
3. Move the "**{Profile type}** profile form" pane into an appropriate checkout step
   — any step **except** 'login', which is not a workable option.
4. Configure the pane's settings for that profile form and save.
5. Test checkout to confirm the pane collects (and, for returning customers,
   pre-fills) the profile as intended.
