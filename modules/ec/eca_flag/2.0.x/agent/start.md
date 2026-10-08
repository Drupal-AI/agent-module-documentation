<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ECA Flag (eca_flag) — agent index

Bridges the **Flag** module into the **ECA** (Event–Condition–Action) engine so flagging or
unflagging an entity can start an ECA model, a model can test whether an entity is flagged, and a
model can load an entity's flagging(s) onto the token stack. Depends on `eca (^2 || ^3)` and
`flag (^4 || ^5)`; PHP >= 8.1; core `^10.4 || ^11`. No routes, no permissions, no Drush, no settings
page (`configure` = null). It ships only a config schema for its plugin config; all behaviour is
wired inside an ECA model (trusted site config), typically a BPMN modeller.

It defines no plugin *type* of its own — it plugs into ECA's event/condition plugin types and core's
action plugin type. Three surfaces:

- **Events** — one derived ECA event plugin `flag` with 4 derivatives (`flag:flag`, `flag:unflag`,
  `flag:insert`, `flag:delete`) and the tokens each puts on the stack →
  [plugins/events.md](plugins/events.md)
- **Condition** — `eca_flag_entity_is_flagged` ("Flag: entity flagged"), one config field `flag_name`
  → [plugins/conditions.md](plugins/conditions.md)
- **Action** — `eca_flag_get_flagging` ("Flag: get flagging for entity"), loads flagging entity/ies
  onto a token; flag/unflag themselves reuse the Flag module's own ECA actions →
  [plugins/actions.md](plugins/actions.md)

Key facts:
- ECA event plugin id `flag`, deriver `Drupal\eca_flag\Plugin\ECA\Event\FlagEventDeriver`; schema
  keys `eca.event.plugin.flag:{flag,unflag,insert,delete}`.
- `flag:flag`/`flag:unflag` react to Flag's own `FlagEvents::ENTITY_FLAGGED`/`ENTITY_UNFLAGGED`;
  `flag:insert`/`flag:delete` react to internal events `eca_flag.insert`/`eca_flag.delete` dispatched
  from `hook_flagging_insert`/`hook_flagging_delete` (service `Drupal\eca_flag\Hook\FlagHooks`,
  autowired, using `eca.trigger_event`).
- Event tokens: `flagging`, `flag`, `entity` for a single flagging, plus `flaggings` (a list) when an
  unflag/delete affects many entities at once.
- Condition config key `flag_name`; action config keys `flag_name` + `token_name` (schema
  `eca.condition.plugin.eca_flag_entity_is_flagged`, `action.configuration.eca_flag_get_flagging`).
- Modelling caveat: a model that both listens for flag events and performs flag actions can trigger
  itself — ECA follows the chain, so add a condition that breaks the cycle.
