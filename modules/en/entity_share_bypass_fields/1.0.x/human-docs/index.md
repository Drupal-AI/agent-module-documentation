# Entity Share Bypass Fields — manual setup guide

**Entity Share Bypass Fields** (`entity_share_bypass_fields`) adds an **Entity Share
Client import processor** that removes ("bypasses") fields from incoming
synchronised entity data — either fields that don't exist on the local site, or
fields you explicitly name — so an import doesn't break on unknown fields.

The problem it solves is schema drift. When one Drupal site pulls content from
another with Entity Share, the remote JSON:API payload can contain fields the
local entity does not have (the two sites' content models have diverged), and
Entity Share will fail while trying to write them. This processor runs early in the
import (at the `prepare_entity_data` stage), loads the local entity by its UUID,
and unsets from the payload any attribute you have listed to bypass, plus any
`field_*` attribute that doesn't exist as a field locally. Entity Share then imports
the trimmed payload. A second use is deliberately excluding specific fields from
sync — for example to keep a local‑only field from being overwritten. Failures are
logged rather than fatal.

**What "bypass" means here — read this carefully.** Despite the name, this is a
**client‑side data‑trimming step on the pulling site, not a field‑access‑control
bypass**. It only *removes* attributes from data the client has already fetched, so
it cannot expose restricted field values to anyone. It does not disable field
read/write access checks, and it does not change what the remote channel serves —
the remote server still governs what it exposes. Who can turn the processor on is
governed by Entity Share Client's own admin permissions.

It depends on **Entity Share Client** (`entity_share_client`). There is nothing to
configure globally — you enable and tune the processor inside an Entity Share
import config, described below.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

This module has no settings form of its own — you configure its processor inside
each Entity Share import config, described in "How to use it" below.

## Where it lives in the admin menu

The processor is configured per import config on the Entity Share Client screen at
**Configuration → Web services → Entity Share → Import configs**
(`/admin/config/services/entity_share/import_config`).

## How to use it

1. Once the module is installed, edit an **Entity Share import config** on your
   client site.
2. In the **Processors** section, find the new **Bypass fields** processor and
   **enable** it. From then on, each sync automatically bypasses fields that don't
   exist locally.
3. Optionally, to always drop specific fields, open the processor's settings and
   list their **machine names** in the text area, comma‑separated (for example
   `field_foo, field_bar`).
