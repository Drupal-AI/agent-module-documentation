# PayU Donations — manual setup guide

**PayU Donations** (`payu_donations`) provides a configurable **donation block**
backed by the **PayU** payment system. Place the block on a page, and visitors can
enter an amount and donate — they are sent to PayU to pay, and the donation is
recorded back in Drupal. It is aimed at nonprofits and charities collecting online
donations, and is especially handy where PayU is the local payment provider.

The important part for anyone taking real money: payment confirmation goes through
PayU's **notify** endpoint, and this module **verifies the OpenPayU signature** on
that notification (using your configured signature key) before it marks a donation
complete. Forged or tampered payment notifications are therefore rejected — the
browser redirect the donor sees is only used to manage the user experience, not to
confirm that money changed hands. The authoritative confirmation is the
signature-verified server-to-server notify.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — enter your PayU credentials, store
   the keys as secrets, and place the donation block.

## Where it lives in the admin menu

You place the donation block through **Structure → Block layout**
(`/admin/structure/block`). PayU credentials and module options are administered by
users holding the **administer payu_donations configuration** permission (a second
permission, **administer payu donations payment**, covers payment handling). See
[Configuration](configuration/index.md).
