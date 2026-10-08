# SMS Framework — manual setup guide

**SMS Framework** (module machine name `sms`, Composer project `drupal/smsframework`) is an
extensible API layer that sits between Drupal and the many SMS gateway providers out there. It
doesn't talk to any one provider by itself; instead it defines a common way to plug providers
in, represent outgoing and incoming text messages, attach verified phone numbers to your
users (or any entity), and handle delivery reports — so any gateway module built for the
framework works the same way.

The core idea is the **gateway plugin**. Each SMS provider is a plugin, and you create a
**gateway** (a small configuration entity) that selects a plugin and holds its settings — your
API credentials, endpoints, and so on. The framework ships one gateway out of the box, **Log**,
which "sends" messages to Drupal's log and marks them delivered. That lets you build and test
your whole flow without a real provider or spending money on texts; swap in a real gateway
when you're ready.

Around that, SMS Framework provides a full pipeline: a send-and-queue service (send inline or
defer to cron), an event system for choosing gateways per recipient or rewriting messages,
per-entity **phone-number fields with verification** (send a one-time code, confirm it at a
`/verify` page, all flood-limited), and dynamically generated webhook routes for receiving
incoming messages and pushed delivery reports. Four optional submodules extend it: bulk send
(**SMS Blast**), developer tooling (**SMS Devel**), send-a-node-to-phone (**SMS Send to
Phone**), and deep user integration including SMS-driven account registration and "active
hours" delays (**SMS User**). It requires Drupal 11, PHP 8.3, core **Telephone**, and the
**Dynamic Entity Reference** module.

This guide is written for a **human** setting the framework up through the admin UI. If you
want terse, token‑cheap references for an AI coding agent — including how to write a gateway
plugin and use the send/verification services — read the sibling [`agent/`](../agent/start.md)
docs instead.

> **Security note for real gateways:** the incoming-message webhook is public and the
> delivery-report route's access check is not authentication — SMS providers call these
> server-to-server. Authentication is the gateway plugin's responsibility, so when you enable a
> real gateway, confirm it validates its callbacks (signature/shared secret). The default Log
> gateway exposes no such endpoint. See the module's `security.md`.

## Contents

1. [Installation](installation/index.md) — install with Composer, meet the PHP 8.3
   requirement, and enable the module and any submodules.
2. [Configuration](configuration/index.md) — global settings, gateways, phone-number
   settings, and the verification page.

## Where it lives in the admin menu

Everything is under **Configuration → SMS Framework** (`/admin/config/smsframework`), gated by
the *Administer SMS Framework* permission: global **Settings**, the **Gateways** list, and the
**Phone number** settings. The verification form lives at `/verify` by default.
