# Digital Signage Framework — manual setup guide

**Digital Signage Framework** (`digital_signage_framework`) lets you publish Drupal
content to physical digital-signage screens — the displays you see in real estate
offices, restaurants, hotels, retail stores, event venues, schools, and transport
hubs. The big win is that you edit content once in Drupal, and your existing
workflow, review process, and revisions all carry through to what appears on your
screens, keeping messaging consistent without extra editorial work.

The framework models a signage estate with a few content entity types: a
**Device** (one physical screen), a **Device type** (a hardware/orientation/
resolution profile), and a **Schedule** (an ordered playlist of content), plus a
**Content setting** entity that marks which content bundles are publishable to
signage. It is deliberately **generic**: it doesn't talk to any specific screen
vendor itself. Instead, a pluggable *platform* plugin adapts the model to a real
vendor platform (such as signageOS), and a *schedule generator* plugin builds each
device's playlist. You can even run several platforms on one Drupal site and manage
all their devices uniformly.

Beyond publishing, it supports device management (preview in Drupal, push
schedules and configuration, collect remote screenshots and logs, offline mode),
slide design (Layout Builder support, fixed overlays/underlays, fonts, QR codes),
dynamic content like timetables, an estate-wide emergency mode, and controlled
interaction on touch displays. It requires Drupal 10.3 or 11 and several supporting
modules.

Devices fetch their content from the framework's own HTTP API rather than through
normal user logins; that API authenticates each device with a per-device
cryptographic fingerprint. Admin configuration and the various push actions are
each protected by their own permissions.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the framework and a platform
   integration with Composer and enable them.
2. [Configuration](configuration/index.md) — the order of operations for setting
   up content settings, device types, devices, and schedules, and operating the
   estate.

## Where it lives in the admin menu

Global settings are at **Configuration → Services → Digital Signage Framework**
(`/admin/config/services/digital_signage_framework`), behind the **administer
digital signage framework** permission. Device types live under **Structure**,
devices and their push/sync/emergency actions under **Content**, and the content
settings entity under **Structure → Digital signage content setting**.
