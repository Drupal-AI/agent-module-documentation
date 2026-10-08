# Mail Group — manual setup guide

**Mail Group** (`mailgroup`) turns your Drupal site into a mailing-list host. You
create groups, add users as members, and when a message is sent to a group's email
address, every member receives it. Replies can be configured to go back to just
the original sender or out to the whole group — the classic mailing-list choice.

Under the hood, Mail Group models everything as entities: **Mail Group** (a
group), **Mail Group Type** (a template for groups), and **Mail Group Membership**
(a person's place in a group). How mail is actually sent and received is handled by
pluggable **connection backends** — a bundled IMAP option, with add-on modules
providing others such as **Amazon SES** and **Mailgun**. This design lets you swap
the transport without touching the rest of your setup.

Security is built in where it counts: sensitive connection settings (the
credentials a backend needs) are stored **encrypted** via the
[Encrypt](https://www.drupal.org/project/encrypt) module, and every route is gated
by a fine-grained permission set. Mail Group depends on core's **Options** and
**User** modules and on the **Encrypt** module, and supports Drupal 9 and 10.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its Encrypt
   dependency with Composer.
2. [Configuration](configuration/index.md) — set up encryption, create a group and
   its connection backend, and manage memberships and permissions.

## How it fits together

1. You set up an **encryption key and profile** (via the Encrypt module) so
   connection credentials can be stored safely.
2. You create a **Mail Group Type** and a **Mail Group**, and choose a
   **connection backend** (IMAP out of the box, or SES/Mailgun via add-ons) for
   sending/receiving.
3. You add **members** to the group — individually or in bulk.
4. Mail sent to the group address is delivered to members; inbound mail is routed
   in through the connection backend and handled by the module.
