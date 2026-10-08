# Modular Finance — manual setup guide

**Modular Finance** (`modular_finance`) embeds investor‑relations widgets from the
third‑party company [Modular Finance](https://www.modularfinance.se) — such as share
price, ownership, or press feeds — into your Drupal pages as configurable blocks.
It is the "JS‑loader" style of integration: the module emits the widget and client
tokens into `drupalSettings`, and Modular Finance's own client‑side JavaScript
library reads those tokens and renders the widget in the visitor's browser.

Because all rendering happens in the browser, the module makes **no server‑side API
call** — there is no external HTTP request from Drupal and therefore no TLS setting
to worry about. Your job is simply to supply the right tokens and place the block.

Setup has three moving parts: a **global client token** entered on a settings form,
one or more **Modular finance type** config entities (each pairing a widget type
with a widget token you get from Modular Finance), and the **Modular finance block**
that you place in a region and point at one of those types. The module has no
submodules and no other module dependencies.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — enter the client token, create widget
   types, and place the block.

## Where it lives in the admin menu

The list of widget **types** is managed at the type collection
(`entity.modular_finance_type.collection`), and the **global client token** lives on
a settings form at `/admin/config/modular_finance/settings` (which requires the
*Access administration pages* permission). See
[Configuration](configuration/index.md) for the full walkthrough.
