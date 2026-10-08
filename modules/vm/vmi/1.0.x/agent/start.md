<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# View Modes Inventory (vmi) — agent index

Ships a standard set of **node view modes** (hero and horizontal-media-teaser families at
xsmall→xlarge) with Display Suite layouts pre-configured.
Core **`~10.6.0 || ~11.4.0`** — two single minors, distribution-style pinning (arrives with
Varbase). Depends on `user`, `node`, `ds:ds`, `ds:ds_extras`, `field_group`, `smart_trim`.

Service: `ViewModesInventoryFactory`. Config: `core.entity_view_mode.node.*` plus DS layout config.

The value is the **shared vocabulary** as much as the markup — when `hero_xlarge` and
`horizontal_media_teaser_small` mean the same thing on every site a team builds, a component
library can target known view modes.

**Flag the core pin:** it will block a core update until a matching release exists. Relevant for
any site not following a distribution's cadence.