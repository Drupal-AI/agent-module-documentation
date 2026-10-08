# eWeLink — manual setup guide

**eWeLink** (`ewelink`) connects your Drupal site to the **eWeLink** smart-home cloud so
you can control eWeLink IoT devices — such as smart door locks and switches — directly
from Drupal. It uses the eWeLink API PHP library to talk to eWeLink's cloud, and it
records what people do with devices as **Activity** entities for auditing and usage
analytics.

The headline use case is an **"Open the Door" page**: a customizable page where an
authorized user can trigger an eWeLink-connected device, for example unlocking a door.
The module creates a dedicated **"Open the Door User"** role and an **"Access the Open
the Door page"** permission so you can control exactly who may operate devices — either
by assigning the role manually through the People screen, or programmatically from
custom code (for example in `hook_cron` or a user-save hook, as the "Bee Hotel" project
does). The design is extensible: support for more eWeLink devices (lights, switches,
sensors, cameras) can be added.

Because triggering a device performs a **real, physical action**, treat access to this
module with the seriousness that implies.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable
   it.
2. [Configuration](configuration/index.md) — connect your eWeLink account, store the
   credentials securely, and gate who can operate devices.

## Where it lives in the admin menu

After enabling, connect your eWeLink account on the module's settings form, and manage
who may operate devices through **People** (`/admin/people`) — where you assign the
**Open the Door User** role — and **People → Permissions**, for the **Access the Open
the Door page** and Activity-entity permissions.

## How to use it

1. Connect your eWeLink account and store its credentials securely — see
   [Configuration](configuration/index.md).
2. Grant the **Access the Open the Door page** permission (and the Activity permissions)
   to the right roles, and assign the **Open the Door User** role to the users who
   should be able to operate devices.
3. Authorized users open the **Open the Door** page and trigger the connected device.
4. Review the **Activity** entities to see who operated which device and when.

> **This controls physical devices — restrict it tightly.** The permission that lets a
> user open a door (or trigger any device) grants a real-world capability, so grant it
> only to trusted users, keep the Activity-entity permissions restricted too, and store
> your eWeLink credentials securely as described in
> [Configuration](configuration/index.md). Operating devices also means your site makes
> outbound (egress) calls to the eWeLink cloud.
