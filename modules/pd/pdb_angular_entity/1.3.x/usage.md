<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
PDB Angular Entity provides an Angular view mode for Drupal entities using the PDB framework and modern Angular (`@angular/elements`).

---

Building on Progressively Decoupled Blocks (`pdb`), it discovers Angular components (those declared with `presentation: angular`) and, via `PdbAngularBlockDeriver`, turns each into a placeable Drupal block (`PdbAngularBlock`) that renders the component's custom-element tag and wires configuration through `drupalSettings` so the Angular element self-bootstraps. `PdbAngularViewDisplay` provides an Angular-based entity view display, and an OOP hook class plus a settings form (`/admin/config/pdb_angular_entity/settings`, `administer site configuration`) tie the pieces together. Two example components (`site_info_component`, `article_component`) ship under `ng_component/`.

This enables progressive decoupling: interactive Angular widgets embedded inside otherwise server-rendered Drupal pages, either as blocks or as an entity view mode, without a full headless rebuild. Typical setup: install `pdb`, provide or enable Angular components, configure the module settings, then place the derived component blocks or select the Angular view display for an entity/view mode.

---
- Embed an Angular component in a Drupal page
- Render an entity through an Angular view mode
- Expose an Angular component as a placeable block
- Pass entity/config data to Angular via drupalSettings
- Progressively decouple a specific region or widget
- Use @angular/elements custom elements in Drupal
- Auto-derive blocks from discovered Angular components
- Ship an interactive widget without going fully headless
- Configure the Angular integration on the settings form
- Provide a site-info Angular component (example)
- Provide an article Angular component (example)
- Bootstrap Angular components as web components
- Combine server-rendered content with Angular islands
- Reuse PDB component discovery for Angular
- Attach an Angular display to a chosen view mode
