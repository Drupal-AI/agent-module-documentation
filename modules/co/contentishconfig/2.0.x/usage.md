<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Mark individual config entities as "contentish" so they are excluded from Drupal configuration import/export (config-sync).

---

Contentish Config adds a per-config-entity third-party setting ("Contentish") that flags a configuration entity as site-specific — treated more like content than deployable config — and keeps it out of the config-sync pipeline. It works by subscribing to core's config-sync storage-transform events: on export it deletes the flagged config names from the export storage (so `drush config:export` / the sync diff never contains them), and on import it copies each flagged item's current active value back into the incoming import storage (so a deployment neither creates a delete nor overwrites the live value). Any config entity whose machine id begins with `_content_` is contentish by default; the checkbox on the entity's edit form lets you override that per item. There is no admin settings page, no route, and no permission of its own — the only UI is the checkbox injected into config-entity forms via `hook_form_alter`. Because the flag is stored as a third-party setting on the entity itself, it exports and imports with that entity's own config schema. This documents the 2.0.x development branch; it supports Drupal 8.8 through 11.

---

- Keep a site-specific view, menu, or block visibility config from being overwritten on deploy.
- Exclude webform or contact-form entities that editors change in production from config-sync.
- Prevent `drush config:export` from picking up environment-specific config entities.
- Stop a config import from deleting config that only exists in production.
- Flag a config entity as "content-ish" with a single checkbox on its edit form.
- Auto-ignore any config whose machine name starts with `_content_` (naming convention).
- Protect per-environment settings that differ between staging and live.
- Avoid spurious "config override" diffs during deployment reviews.
- Let content editors manage certain config entities without CI/CD conflicts.
- Preserve the active/live value of a flagged config item across imports.
- Treat editorially-managed taxonomy or image-style config as content.
- Ship a codebase where "_content_"-prefixed config is ignored by default across a team.
- Store the ignore flag with the entity (third-party setting) instead of a central ignore list.
- Combine per-entity ignoring with normal config-sync for everything else.
- Migrate away from maintaining a separate config_ignore pattern list for individual entities.
- Exclude a small set of entities without ignoring an entire config type by wildcard.
- Keep the ignore decision visible and editable on the very form that creates the config.
- Support multi-environment deployment workflows where some config is local.
- Have the flag survive re-export because it lives in the entity's own third-party settings.
- Roll the flag back simply by unchecking the box (it unsets the third-party setting).
