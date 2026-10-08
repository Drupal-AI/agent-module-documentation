<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Replicate UI — agent index

Adds a UI to the Replicate deep-clone API. You choose which **content entity types**
are replicable; the module then registers, per enabled type, a `replicate` route
(`/{type}/{id}/replicate`), a "Replicate" local task + entity-operation link, a
confirm form, and a `replicate` link template. Depends on `replicate` and `user`.
Configure route: `replicate_ui.settings` (`/admin/config/content/replicate`).

- Enable replicate for entity types, settings keys, config & drush, how routes/tabs appear → [configure/settings.md](configure/settings.md)
- Who can replicate: the `replicate entities` permission + create/view/edit access checks → [permissions/permissions.md](permissions/permissions.md)
- Clone an entity from code, the Action / Rules / Views field integrations → [api/replicate.md](api/replicate.md)
