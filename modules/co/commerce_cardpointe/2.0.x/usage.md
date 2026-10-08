<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce CardPointe is a Drupal Commerce on-site payment gateway for CardPointe (CardConnect / Fiserv), tokenizing cards in a hosted iframe and charging them server-side, with optional Clover Flex terminal support.

---

Commerce CardPointe adds a Drupal Commerce payment gateway (`cardpointe_hostediframe`) that processes credit-card payments through the CardPointe / CardConnect (Clover Connect, a Fiserv company) platform. It is an on-site gateway: the card number, expiry and CVV are entered in CardConnect's hosted iframe tokenizer, which runs on Clover's servers and returns a token; only that token reaches your Drupal site, which then authorizes or captures the charge server-side through the CardConnect Gateway REST API. The stored payment method keeps only the card type, last four digits and expiry. The gateway supports immediate capture or authorize-then-capture, and full void, capture and refund from the Commerce order-management screens.

Alongside the online iframe flow, the module offers an integrated-terminal payment method type that drives a CardPointe/Clover Flex device for card-present transactions via the CardConnect Terminal API. Store staff pick a registered terminal (managed as `commerce_cardpointe_terminal` config entities under the gateway's Terminals tab) and press "Authorize Card"; the module connects to the device, syncs its clock, authorizes the order balance on the terminal, and records the payment. Configuration is done entirely on the Commerce payment-gateway form — CardPointe site, merchant ID, API username/password, transaction type, optional custom iframe CSS, optional request/response debug logging, and the terminal site + API key. Use Sandbox (UAT) mode with CardConnect test credentials before switching to Production.

---

- Accept online credit-card payments (Visa, Mastercard, Amex, Discover) through CardPointe's hosted iframe tokenizer.
- Keep the raw card number off your server — the PAN is tokenized client-side and only a token is charged server-side.
- Store reusable payment methods holding only card type, last four digits and expiry (card-on-file support).
- Choose immediate capture or authorize-now / capture-later per gateway (`intent` setting).
- Void, capture and refund (full or partial) payments from the Commerce order-management interface.
- Prompt for the CVV again when a customer re-uses a stored card at checkout (card-not-present verification).
- Run card-present transactions on a Clover Flex device via the CardPointe integrated Terminal API.
- Register and manage terminals (by HSN) as entities under the payment gateway, with a "refresh" action that syncs the device list from CardConnect.
- Optionally apply custom CSS to the hosted tokenizer iframe.
- Validate the entered merchant credentials (and terminal API key) when saving the gateway.
- Switch between Sandbox (UAT) and Production endpoints with a single mode setting.
- Optionally log API request/response messages for debugging.
- Restrict terminal management with the `manage commerce_cardpointe terminals` permission.
