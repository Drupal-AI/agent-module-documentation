# Better Normalizers — manual setup guide

**Better Normalizers** (`better_normalizers`) improves three of Drupal core's HAL
normalizers so that HAL JSON serialization is **lossless and round-trippable** —
in other words, what you export can be re-imported without losing information.
It is a developer/serialization module with no interface; you install it and it
quietly upgrades how the `hal_json` format handles files and menu links.

Specifically, it replaces three core normalizers:

- **File entities** are serialized with their actual bytes embedded as
  base64-encoded `data`, and on import those bytes are written back to disk — so a
  file can travel inside a single HAL document and be recreated on another site
  without a separate binary transfer.
- **File field items** keep their per-item metadata such as `description` and
  `display` through a serialize/deserialize round trip, instead of being reduced
  to a bare reference.
- **Menu link content** items embed the entity they point at (and their parent
  menu link), resolving those references back to real IDs and UUIDs on import.

Each replacement is registered at a higher priority than the equivalent core HAL
normalizer, so it wins automatically. There is **nothing to configure** — enabling
the module (together with core's HAL module) is the entire setup, and you use it
through the normal serializer / REST stack.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent — including the exact services,
priorities, and how to extend the normalizers — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside the HAL module.

## How to use it

There is nothing to switch on and no settings to fill in. Once the module (and
HAL) are enabled, any `hal_json` serialization automatically uses the improved
normalizers. You interact with it exactly as you already do with Drupal's
serialization and REST features — export or POST an entity in the `hal_json`
format and the richer output is produced for you. The File-based improvements
apply whenever files are involved; the menu-link improvement applies only when
core's **Menu link content** module is also enabled.

## Where it lives in the admin menu

Nowhere — Better Normalizers has no admin pages, no settings form, and no
permissions. It only affects the `hal_json` serialization format behind the
scenes.
