# TFA - SMS API — manual setup guide

**TFA - SMS API** (`tfa_smsapi`) is a plugin for the **TFA (Two-Factor
Authentication)** module that delivers the second-factor login code by **SMS**,
sent through the **SMS API** (`smsapi`) module's service. A user completing
two-factor login receives their one-time code as a text message on the phone number
they have registered, and enters it to finish signing in.

The actual checking of the code is handled by the vetted TFA framework — this
module's job is the delivery: it takes the code TFA needs to send and dispatches it
over your SMS API account. It gives you a ready-to-use SMS second factor for sites
that either are setting up TFA for the first time or already have TFA configured.
Alongside the core delivery it offers a configurable limit on how many times a user
may enter a code before their account is locked, and a choice of which configured
SMS API sender is used to send the message.

The module depends on the **TFA** module (version 1.5 or newer) and the **SMS API**
module, and supports Drupal 10.2 and 11. Your SMS API credentials are configured
through the SMS API module rather than here; store them securely (env-backed) and
never commit them. This module is covered by Drupal's security advisory policy.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its
   dependencies, enable it, and select SMS as a TFA validation method.

## How to use it

TFA - SMS API works as a validation plugin inside TFA, so you drive it from the TFA
settings rather than from a separate screen of its own:

- First configure your **SMS API** account and credentials in the SMS API module,
  including at least one sender.
- Then, in the TFA settings, select the SMS API plugin as a validation method so
  users can enrol a phone number and receive codes by text.
- Set the **limit** on how many code entry attempts are allowed before an account
  is locked, and pick which SMS API **sender** the verification messages come from.

Users then register the telephone number where they want to receive codes, and at
login TFA sends the one-time code there as an SMS for them to enter.
