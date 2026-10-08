# Commerce Conditions Plus — manual setup guide

**Commerce Conditions Plus** (`commerce_conditions_plus`) upgrades the conditions
editor in Drupal Commerce. Out of the box, Commerce evaluates a set of conditions
with a single, flat operator — either **all** must pass (AND) or **any** must pass
(OR). This module keeps that base choice but adds a table‑based editor and two
grouping operators, **And Operator** and **Or Operator**, so you can build nested,
mixed‑logic condition sets on shipping methods, payment gateways and promotions.

With the grouping operators you insert AND/OR nodes into a conditions list and
nest other conditions beneath them, producing arbitrarily deep boolean
expressions — for example, *free shipping if (subtotal ≥ 100) OR (member AND
subtotal ≥ 50)*. The conditions are shown as a sortable, indentable table with a
per‑row **negate** control, so you can drag conditions into groups, set their
depth, and flip an individual condition's result without affecting its siblings.

Behind the scenes the module stores the nesting (parent, depth, weight and negate)
alongside each condition so it survives save and travels in exported
configuration, and an evaluator service runs the nested structure when Commerce
checks whether a shipping method or payment gateway applies. There is nothing to
switch on beyond enabling the module — the improved editor and operators appear
automatically on the relevant Commerce forms.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent — including the operator
plugin ids and the evaluator service — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer
   (alongside Drupal Commerce) and enable it.

## Where it lives in the admin menu

Commerce Conditions Plus has **no settings page of its own** (`configure: null`).
Instead it enhances the **Conditions** sections of existing Commerce forms — when
you edit a **shipping method**, a **payment gateway**, or a **promotion**, the
conditions area now shows the table editor and offers the And/Or operators. You
reach those through Commerce's normal admin pages (for example **Commerce →
Configuration → Shipping methods** or **Payment gateways**).

## How to use it

1. Enable the module (and make sure Drupal Commerce is installed; shipping‑method
   support also needs Commerce Shipping).
2. Edit a shipping method, payment gateway, or promotion and scroll to its
   **Conditions**.
3. Set the **Conditions table base logic** (the relabelled base operator) to AND
   or OR.
4. Add your conditions as usual, plus **And Operator** / **Or Operator** rows
   (found under the "Conditions Plus" category) to create groups.
5. In the conditions **table**, drag rows to nest them under an operator and set
   their order; use each row's **negate** control to invert a single condition.
6. Save. Commerce now evaluates the nested logic when deciding whether the
   shipping method or gateway applies.

Because the nesting is stored in each condition's configuration, your grouped
logic is included in exported configuration and deploys with your site.
