<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ECA Metatag (eca_metatag) — agent index

Bridges the **ECA** no-code automation framework (`drupal/eca`) to the **Metatag** module so meta
tags can be driven by business rules instead of hard-coded configuration. It contributes plugin
instances to three existing managers: an **ECA event** plugin (`eca_metatag`, deriving
`eca_metatag:tags` and `eca_metatag:alter`), two **ECA action** plugins (`eca_metatag_add_tag`,
`eca_metatag_set_tag_value`), and a dynamic **Metatag Tag** plugin (`eca`, via a deriver). The
alter path is wired by `hook_metatags_alter()` → `TriggerEvent::dispatchFromPlugin('eca_metatag:alter', …)`;
the tags path is dispatched from the metatag deriver while Metatag builds its list of available tags.

The actions only make sense inside a model started by their matching event: `eca_metatag_add_tag`
after `eca_metatag:tags` (it registers a new tag by name/label/description, which then appears in
Metatag's admin UI), and `eca_metatag_set_tag_value` after `eca_metatag:alter` (it overwrites an
existing tag's value on the current page). Both action's inputs run through ECA's token service, so
values can be composed from the event entity, earlier actions, or any token context. There is **no
settings UI**, no `configure` route, no permissions, and no Drush — everything lives inside ECA
models; the module only ships plugins, config schema, one hook, and a service.

- Depends on: `eca:eca (^2 || ^3)`, `metatag:metatag`.
- Core: `^10.4 || ^11`. PHP: `>=8.1`. Package: `ECA`.
- No settings page / `configure` route. No permissions. No Drush. **Provides config schema** (action
  config + ECA event plugin schema). Defines **no plugin type of its own** (only plugin instances).
- `hook_install()` sets the module weight to `1` so its metatag hook runs after Metatag's.

## What you'd do → where

- **Understand/author the ECA event, action, and metatag Tag plugins (ids, classes, config keys,
  access gating, raw event methods)** → [plugins/eca-plugins.md](plugins/eca-plugins.md)

## Key facts (real machine names)

- ECA event plugin: `eca_metatag` (`Plugin\ECA\Event\MetatagEvent`, deriver `MetatagEventDeriver`) →
  derivatives `eca_metatag:tags` and `eca_metatag:alter`.
- ECA action plugins: `eca_metatag_add_tag` (`Plugin\Action\AddTag`), `eca_metatag_set_tag_value`
  (`Plugin\Action\SetTagValue`) — both `#[Action]` + `#[EcaAction]`, extend `ConfigurableActionBase`,
  `externallyAvailable() === FALSE`, event-gated in `access()`.
- Metatag Tag plugin: `eca` (`Plugin\metatag\Tag\Eca` extends `MetaNameBase`, deriver `EcaDeriver`)
  → dynamic derivatives with ids `eca:<name>`, group `basic`, type `label`.
- Raw events: `eca_metatag.tags` (`EcaEvents::TAGS` → `Event\TagsEvent`), `eca_metatag.alter`
  (`EcaEvents::ALTER` → `Event\AlterEvent`).
- Hook: `hook_metatags_alter` — `Hook\MetatagHooks::metatagsAlter()` (`#[Hook('metatags_alter')]`)
  and legacy wrapper `eca_metatag_metatags_alter()` in `eca_metatag.module`.
- Services: `Drupal\eca_metatag\Hook\MetatagHooks` (autowired), alias
  `Drupal\eca\Event\TriggerEvent: '@eca.trigger_event'`; parameter `eca_metatag.skip_procedural_hook_scan: true`.
- Config schema keys: `eca.event.plugin.eca_metatag:tags`, `eca.event.plugin.eca_metatag:alter`,
  `action.configuration.eca_metatag_add_tag` (`name`, `label`, `description`),
  `action.configuration.eca_metatag_set_tag_value` (`tag_name`, `tag_value`).
