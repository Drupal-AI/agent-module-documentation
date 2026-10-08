<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bee Hotel Sample Hotel (beehotel_samplehotel) — agent index

One-step **demo-hotel installer**. Dependency: `bee_hotel`. Core `^9.4 || ^10 || ^11`.

## What it does

- `beehotel_samplehotel_install()` (`.install`) → `SampleHotelInstall([],[],[])->install()`, which
  orchestrates:
  - `SampleHotelInstallDrupal` — Drupal content (unit nodes, config),
  - `SampleHotelInstallBat` — BAT units + availability events,
  - `SampleHotelInstallCommerce` — Commerce products/variations/stores.
- `beehotel_samplehotel_uninstall()` → `SampleHotelInstall::uninstall()` removes the sample data.
- `beehotel_samplehotel_page_attachments()` attaches a helper library on `/admin/beehotel/vertical`.

Install with `drush en beehotel_samplehotel`. Intended for demos/evaluation/training only — not
production. No routes/permissions/schema; no solution subpages.
