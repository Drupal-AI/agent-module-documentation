# Commerce Reporting — manual setup guide

**Commerce Reporting** (`commerce_reports`) adds sales analytics to a Drupal
Commerce store. Every time an order is placed it quietly records report data, and
it presents that data as aggregated tables and Views under the store's **Reports**
section — so store owners and finance teams can see how the shop is doing without
exporting to a spreadsheet or writing custom queries.

It ships four report types out of the box: an **order report** (order counts,
customer counts and revenue per period), a **purchased-items report** (which
products sold and in what quantities), a **promotion report** (coupon and
promotion usage and the discounts they generated), and a **tax report** (tax
collected, for accounting). Each report can be grouped by month, day or year, and
two of them are also exposed as Views (`sales_report` and
`purchased_items_report`) that you can clone or feed into charts and dashboards.

Report data is captured automatically as orders are placed, so day to day there
is nothing to do. When you first install the module you will want to run the
**Generate reports** form once to backfill reports from your existing historical
orders. Developers can add their own report type (say shipping or refunds) by
writing a report-type plugin — see the [`agent/`](../agent/start.md) docs.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (Drupal Commerce is required).
2. [Configuration](configuration/index.md) — viewing reports, backfilling with
   the Generate reports form, the shipped Views, and the permissions.

## Where it lives in the admin menu

The reports live under **Commerce → Reports** (`/admin/commerce/reports`), gated
by the **Access commerce reports** permission. The rebuild tool is under
**Commerce → Configuration → Reports → Generate reports**
(`/admin/commerce/config/reports/generate-reports`), gated by the **Generate
commerce order reports** permission. There is no separate settings form.

## How to use it

Enable the module, run the **Generate reports** form once to populate reports
from past orders, then browse **Commerce → Reports**. New orders are added to the
reports automatically from then on. See [Configuration](configuration/index.md)
for the details.
