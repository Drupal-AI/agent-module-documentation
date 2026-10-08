# Commerce Tax Conditions — manual setup guide

**Commerce Tax Conditions** (`commerce_tax_conditions`) lets a Drupal Commerce
store make a **tax rate conditional**. Instead of a tax type always applying, it
only applies when the order matches the conditions you attach to it — an order
total above a threshold, a particular store, a specific customer or role, and so
on. It builds on Commerce Tax's own condition support and is aimed at site
builders configuring tax types, not developers writing code.

Reach for it when a single flat tax type is not enough and tax has to depend on
business rules: charge a rate only above a spending limit, restrict a tax type to
certain stores, or model region- and channel-specific tax rules — all in
configuration, so the rules deploy with your site. Conditions are evaluated per
order at tax-calculation time; when they fail, the tax type is simply skipped.

The module works as soon as it is enabled — there is no settings page of its own.
It adds a **Conditions** section to the existing tax-type form, and it depends on
Drupal Commerce with the **Commerce Tax** submodule (`commerce_tax`,
`>= 8.x-2.20`), which you must enable first.

> **Heads up:** if you are on Drupal Commerce `^2.32` or newer, Commerce Tax
> already ships a conditions UI and you do **not** need this module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside Commerce Tax.

There is **no configuration page** for this module — it has no settings form of
its own. Everything happens on the tax-type form, described below.

## Where it lives in the admin menu

Commerce Tax Conditions adds no admin page. You use it entirely from your existing
tax types at **Commerce → Configuration → Tax types**
(`/admin/commerce/config/tax-types`). Edit (or add) a tax type and you will find a
new **Conditions** section on the form.

## How to use it

1. Make sure both **Commerce Tax** and **Commerce Tax Conditions** are enabled.
2. Go to **Commerce → Configuration → Tax types**
   (`/admin/commerce/config/tax-types`) and edit the tax type you want to gate.
3. In the **Conditions** section, add one or more conditions — for example
   *Order total* over a limit, a specific *Store*, or a *Customer / role*
   restriction. Combine several with AND/OR logic using Commerce's standard
   condition-group behavior.
4. Save the tax type. From now on the tax only applies to orders that match; other
   orders skip it entirely.
5. Because the settings are stored as configuration, they export with the tax type
   and travel between environments. Always **verify the computed tax on a real
   test order** before going live.
