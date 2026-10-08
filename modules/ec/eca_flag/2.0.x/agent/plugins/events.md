# ECA Flag events

Source: `src/Plugin/ECA/Event/FlagEvent.php` (+ `FlagEventDeriver.php`), internal event classes in
`src/Event/`, and the hook dispatcher `src/Hook/FlagHooks.php`.

One ECA event plugin `#[EcaEvent(id: 'flag', deriver: FlagEventDeriver)]` whose `definitions()`
returns four derivatives. In a model you select "Flag" and then the specific event; the resulting
plugin id is `flag:<key>` (schema key `eca.event.plugin.flag:<key>`).

## The four events

| Plugin id | Label | Fires on (event name) | Event class |
|---|---|---|---|
| `flag:flag` | Flag | `FlagEvents::ENTITY_FLAGGED` (`flag.entity_flagged`) | `Drupal\flag\Event\FlaggingEvent` |
| `flag:unflag` | Unflag | `FlagEvents::ENTITY_UNFLAGGED` (`flag.entity_unflagged`) | `Drupal\flag\Event\UnflaggingEvent` |
| `flag:insert` | Insert flagging | `eca_flag.insert` (`FlaggingEvents::INSERT`) | `Drupal\eca_flag\Event\FlaggingInsert` |
| `flag:delete` | Delete flagging | `eca_flag.delete` (`FlaggingEvents::DELETE`) | `Drupal\eca_flag\Event\FlaggingDelete` |

- `flag:flag` / `flag:unflag` are the Flag module's own dispatched events (a link click, an ECA
  flag/unflag action, or any code calling the flag service).
- `flag:insert` / `flag:delete` are dispatched by this module from the entity hooks
  `hook_flagging_insert` / `hook_flagging_delete` on the `flagging` entity. The procedural hooks in
  `eca_flag.module` (`#[LegacyHook]`) and the OOP `Drupal\eca_flag\Hook\FlagHooks` methods
  (`#[Hook('flagging_insert')]` / `#[Hook('flagging_delete')]`) call
  `TriggerEvent::dispatchFromPlugin('flag:insert'|'flag:delete', $flagging)`.
- The two pairs behave similarly: `flag`≈`insert` (one entity gets flagged), `unflag`≈`delete`.
  `unflag`/`delete` can concern **many** entities at once.

`src/Event/FlaggingBase`, `FlaggingInsert`, `FlaggingDelete` are marked `@internal` (not a public API;
may change on minor updates). `FlaggingBase::getEntity()` returns the `FlaggingInterface`.

## Tokens on the stack

Two mechanisms expose tokens; both are on `FlagEvent`.

`getData($key)` (flat token access) resolves, for the single-flagging case:

| Token | Meaning |
|---|---|
| `flagging` | the flagging entity (`FlaggingInterface`) |
| `flag` | the flag config entity (`$flagging->getFlag()`) |
| `entity` | the flagged/unflagged entity (`$flagging->getFlaggable()`) |
| `flaggings` | the list of flaggings (only on `unflag`/`delete` when more than one) |

For `unflag`, `flagging`/`flag`/`entity` resolve to the **first** item (`reset($flaggings)`); the full
set is under `flaggings`. Any unmatched key falls back to `parent::getData()` (ECA base tokens).

`buildEventData()` also builds structured `event.*` tokens:

- Single flagging (`flag`, `insert`, or one-item `unflag`/`delete`): `event.flag`, `event.flagging`,
  `event.entity`.
- Multiple (`unflag`/`delete` with many): `event.flaggings` is a list; each item `event.flaggings.#`
  (0-based index `#`) has `.flag`, `.flagging`, `.entity`.

So a model reacting to a bulk unflag iterates `flaggings` and reads `flag`/`flagging`/`entity` per item.

(Per the source, a `flag-action` token is not yet provided — pending Flag issue #2500091.)
