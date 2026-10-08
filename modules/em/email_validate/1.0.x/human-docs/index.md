# Email Validate — manual setup guide

**Email Validate** (`email_validate`) adds stricter validation of the email
addresses people use when they register or update a user profile, with the goal of
keeping out disposable and abusive signups. It layers several checks on top of
Drupal core's basic email validation, and each check can be switched on or off
individually so you enable only the ones you want.

Its checks include catching **Gmail/Google address tricks** (plus‑addressing and
dot variations that resolve to an account you already have), **Yandex temporary
address variations**, an **internal domain blacklist** of email domains to block,
an optional lookup against the **block‑temporary‑email.com** service (which needs
a free account and API key), and — in newer releases — a **DNS record check** of
the email domain and a **bulk check of existing site users'** addresses.

Because these checks run against the address at submission time, the module is an
anti‑abuse tool rather than an access‑control one. Keep in mind it validates the
*format and reputation* of an address; it does not confirm that the person
actually controls that inbox. For that, pair it with Drupal's core email
verification. The module has no other module dependencies.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — choose which validation constraints
   to enable.

## Where it lives in the admin menu

Once enabled, the settings form sits at **Configuration → People → User Email
validation** (`/admin/config/people/email_validate`). That is where you turn each
constraint on or off and save.
