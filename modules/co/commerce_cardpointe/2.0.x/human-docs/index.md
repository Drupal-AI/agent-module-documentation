# Commerce CardPointe — manual setup guide

**Commerce CardPointe** (`commerce_cardpointe`) adds a Drupal Commerce payment
gateway for **CardPointe**, the CardConnect / Fiserv (Clover Connect) payment
platform. It processes card payments using CardPointe's **Hosted iFrame
Tokenizer**, so card data is collected directly on Clover's servers and tokenized
rather than passing through your site. It depends on Commerce Payment and provides
its own permissions.

The module offers two gateway styles: a **Hosted iFrame** gateway for online card
payments, and a **Terminal** gateway that integrates with the Clover Flex device
for card‑present transactions. Voids, captures, and refunds are all handled from
the order‑management interface.

For a card payment integration, the security posture is what matters: card data is
tokenized on Clover's servers, authorization and capture happen **server‑side**
against CardPointe's authenticated API (the module doesn't trust a client‑side
result), and your CardPointe **API credentials must be stored as secrets** — not
committed to exported config — with the site running over HTTPS. Confirm you're in
the right test vs live mode before taking real payments. On PCI‑DSS: the
maintainers state the module is intended to work within the requirements of
**Self‑Assessment Questionnaire A‑EP** (the exact designation depends on your
integration), while stressing that PCI compliance ultimately remains your
responsibility.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add a CardPointe gateway and enter
   your credentials.

## Where it lives in the admin menu

Commerce CardPointe adds no page of its own. You configure it as a gateway under
**Administration → Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`) — see
[Configuration](configuration/index.md).
