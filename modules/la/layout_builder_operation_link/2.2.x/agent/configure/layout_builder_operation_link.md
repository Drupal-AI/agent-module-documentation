<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — layout_builder_operation_link

**There is no module configuration.** No settings form, no `configure` route (`data.json`
`configure: null`), no permissions, no config schema. Enable the module and the Layout link
appears wherever it applies. Everything below is about the *conditions* that make it appear —
which are Layout Builder's own settings, not this module's.

## When the "Layout" link shows

The link is added to an entity's operations dropbutton **only when all** of these hold, checked
per entity via `access_manager->checkNamedRoute('layout_builder.overrides.<entity_type>.view', …)`:

1. The entity's bundle has **Layout Builder enabled** on its default view display, **and**
2. **overrides are allowed** ("Allow each content item to have its layout customized"), **and**
3. the current user has permission to edit that entity's layout (e.g. *Configure any layout* /
   *Configure all … layouts*, plus normal update access to the entity).

If overrides are off, or the user lacks layout permission, the link is simply absent (no error).
So the link doubles as a signal of which bundles have per-entity overrides and who may use them.

## Where it appears

Any listing that renders an entity operations dropbutton (`links__dropbutton__operations`):
`/admin/content` (nodes), taxonomy vocabulary term overview, the users admin list, media admin,
and custom admin Views with an "Operations" field. It works for every entity type because it
keys off the generic `hook_entity_operation()`.

The link points to `/<entity-path>/layout` — e.g. `/node/123/layout`, `/taxonomy/term/7/layout`.
Title is **"Layout"**, weight **50** (sorts after core Edit/Delete).

## Enable Layout Builder overrides on a bundle (the actual "setup")

UI: *Structure → Content types → <type> → Manage display*, check **Use Layout Builder** and
**Allow each content item to have its layout customized**, Save.

Drush / PHP (enable overrides for Article nodes' default view display):

```bash
drush php:eval '
  $d = \Drupal::service("entity_display.repository")->getViewDisplay("node", "article", "default");
  $d->enableLayoutBuilder()->setOverridable()->save();
'
drush cr
```

Disable again:

```bash
drush php:eval '
  $d = \Drupal::service("entity_display.repository")->getViewDisplay("node", "article", "default");
  $d->disableLayoutBuilder()->save();
'
```

The override flags live on the view display config entity
`core.entity_view_display.<entity_type>.<bundle>.<mode>` under
`third_party_settings.layout_builder` as `enabled: true` and `allow_custom: true`.

## Multilingual

If the Layout Builder field (`OverridesSectionStorage::FIELD_NAME`, i.e. `layout_builder__layout`)
is **translatable** (as when the Layout Builder Asymmetric Translation `layout_builder_at` module
is installed and the field is made translatable per bundle), the module adds the entity's language
as a `language` route option, so the link opens the layout of the translation being viewed
(e.g. `/es/node/2/layout`).
