<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
View Modes Inventory installs a ready-made set of node view modes — hero, horizontal media teaser and similar, each at several sizes — with Display Suite layouts already configured.

---

Every project invents the same view modes. A card at three sizes, a teaser with the image on the left, a hero for the top of a landing page, a compact list row: the names differ, the arrangements differ slightly, and the work is redone each time. This module ships an inventory of them as configuration, so a new site starts with a vocabulary of displays instead of building one.

The value is as much in the naming as the markup. When "hero_xlarge" and "horizontal_media_teaser_small" mean the same thing on every site a team builds, editors and developers stop negotiating what a teaser is, and a component library can target known view modes rather than site-specific ones. `ViewModesInventoryFactory` is the service behind it.

The dependency list tells you what it assumes: Display Suite and `ds_extras` for the layouts, `field_group` for grouping, and `smart_trim` for truncated text in teasers. That is a specific stack, and adopting the inventory means adopting it too.

**The core requirement is `~10.6.0 || ~11.4.0`** — two single minors, not ranges. That is a distribution-style pin (it comes in with Varbase) and means the module will block a core update until a matching release exists. Worth knowing before installing it on a site that is not following a distribution's cadence.

---

- Start a site with a standard set of view modes.
- Use a consistent teaser vocabulary across projects.
- Get hero and card displays without building them.
- Provide several sizes of the same display.
- Configure Display Suite layouts for each view mode.
- Truncate teaser text with smart_trim.
- Group fields within a view mode.
- Give a component library known view modes to target.
- Standardise displays across a team's sites.
- Reduce setup time on a new build.
- Align editors and developers on display names.
- Reuse view modes in Layout Builder.
- Audit which view modes a site actually uses.
- Plan core updates around a pinned minor requirement.
- Remove unused view modes after adoption.