# OwnID — manual setup guide

**OwnID** (`ownid`) adds **passwordless, biometric web authentication** to your
Drupal site through the OwnID service. Instead of typing a password, your users
log in with their device's biometrics or a passkey. The flow is entirely
web‑based — there is no separate app for users to install — and OwnID markets it
as working across operating systems, devices, and domains, with passkey support
out of the box. At the time of writing the module uses **email** as the login
identifier.

Setting it up is a small, no‑code process from the admin's point of view: you
create a project in the OwnID console, choose the Drupal integration, and paste
the two credentials it gives you — an **App ID** and a **Shared Secret** — into
the module's settings form. From then on the passwordless login option appears on
your login flow.

Because this module governs how people authenticate, it is **security‑critical**.
Two things matter most. First, the Shared Secret is exactly that — a secret — so
keep it out of exported configuration and version control (see
[Configuration](configuration/index.md) for how). Second, understand that trust
in every login depends on OwnID's verification being validated on the server side
before a Drupal session is established; review the token/verification flow and
your account‑mapping rules before you rely on OwnID as a real login method for
your users.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — create your OwnID project, and store
   and enter the App ID and Shared Secret safely.

## Where it lives in the admin menu

After enabling, open the module's **settings form** (its **Configure** link on the
**Extend** page, `/admin/modules`, takes you straight there) and paste in the
**App ID** and **Shared Secret** from your OwnID console. That single form is
where the integration is wired up.

## A note on external connectivity

OwnID is a hosted service, so the passwordless flow contacts OwnID's servers over
HTTPS. Make sure outbound HTTPS to OwnID is permitted from your environment (mind
any egress firewall rules), and only ever exchange credentials over HTTPS.
