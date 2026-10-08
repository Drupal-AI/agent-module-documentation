# ECA + Metatag plugins

`eca_metatag` ships **no plugin type of its own** (no manager service). It contributes plugin
*instances* to three managers that already exist: ECA's event manager, core's/ECA's action manager,
and Metatag's `metatag.tag` manager. All machine names below are verified against source.

## ECA event plugin — `eca_metatag` (2 derivatives)

- Class: `Drupal\eca_metatag\Plugin\ECA\Event\MetatagEvent` (extends `eca`'s `EventBase`).
- Attribute: `#[EcaEvent(id: 'eca_metatag', deriver: MetatagEventDeriver::class, version_introduced: '1.0.0')]`
  (`src/Plugin/ECA/Event/MetatagEvent.php:14`).
- Deriver: `Drupal\eca_metatag\Plugin\ECA\Event\MetatagEventDeriver` (returns `MetatagEvent::definitions()`).
- `definitions()` (`MetatagEvent.php:24`) yields two derivatives → full plugin ids `eca_metatag:tags`
  and `eca_metatag:alter`:

  | Full plugin id | Label | Symfony event name | Event object |
  |---|---|---|---|
  | `eca_metatag:tags` | Provide a list of tags | `eca_metatag.tags` (`EcaEvents::TAGS`) | `Event\TagsEvent` |
  | `eca_metatag:alter` | Alter metatags | `eca_metatag.alter` (`EcaEvents::ALTER`) | `Event\AlterEvent` |

Use these as the **start event** of an ECA model. `eca_metatag:tags` fires while Metatag is
building its list of available tag plugins (dispatched from the `EcaDeriver`, see below);
`eca_metatag:alter` fires while a page's meta tags are being assembled (dispatched from
`hook_metatags_alter`, see plumbing).

## ECA action plugins (2)

Both are declared with **both** `#[Action(...)]` (core) and `#[EcaAction(version_introduced: '1.0.0')]`
(ECA), extend `Drupal\eca\Plugin\Action\ConfigurableActionBase`, and use `$this->tokenService->replace()`
on every config value so inputs accept **ECA tokens**.

| Plugin id | Class | Pairs with event | Purpose |
|---|---|---|---|
| `eca_metatag_add_tag` | `Plugin\Action\AddTag` | `eca_metatag:tags` (`TagsEvent`) | Register a brand-new metatag by calling `TagsEvent::addTag($name, $label, $description)`. |
| `eca_metatag_set_tag_value` | `Plugin\Action\SetTagValue` | `eca_metatag:alter` (`AlterEvent`) | Overwrite an existing tag's value via `AlterEvent::setMetatagValue($name, $value)`. |

**Why these actions never show up in a plain action list.** They inherit ECA
`ActionBase::externallyAvailable()`, which returns `FALSE` (`eca/src/Plugin/Action/ActionBase.php:124`),
and neither class overrides it — so they are intentionally excluded from the general
action list and are only offered inside ECA models. On top of that each action's `access()`
returns `forbidden()` unless the *current* event is the matching event object:

- `AddTag::access()` (`AddTag.php:31`) — allowed only when `$this->event instanceof TagsEvent`.
- `SetTagValue::access()` (`SetTagValue.php:31`) — allowed only when `$this->event instanceof AlterEvent`
  **and** `AlterEvent::hasMetatag($token_replaced_name)` is TRUE (you cannot set a tag that does not
  already exist).

Config keys (schema-backed, see `config/schema/eca_metatag.schema.yml`):

- `eca_metatag_add_tag`: `name` (string, required), `label` (text, required), `description` (text).
  `name` becomes the Metatag plugin id; `label`/`description` are shown in Metatag's admin UI.
- `eca_metatag_set_tag_value`: `tag_name` (string, required), `tag_value` (text, required).
  `tag_name` is the Metatag plugin id to overwrite; `tag_value` its new value.

## Metatag Tag plugin — `eca` (+ deriver, dynamic)

- Class: `Drupal\eca_metatag\Plugin\metatag\Tag\Eca` (extends Metatag's `MetaNameBase`), annotated
  `@MetatagTag(id = "eca", group = "basic", type = "label", weight = 0, secure = FALSE, multiple = FALSE, trimmable = TRUE, deriver = "…\EcaDeriver")`.
- Deriver: `Drupal\eca_metatag\Plugin\metatag\Tag\EcaDeriver`
  (`src/Plugin/metatag/Tag/EcaDeriver.php`). Its `getDerivativeDefinitions()` constructs a fresh
  `TagsEvent`, dispatches it on `EcaEvents::TAGS` (`eca_metatag.tags`), then for every tag an ECA
  model registered via `AddTag` emits a metatag plugin with id **`eca:<name>`**, label
  `<label>`, description `<description>`.

Net effect: an ECA model reacting to `eca_metatag:tags` and running `eca_metatag_add_tag`
**defines new Metatag plugins at runtime** — they then appear in Metatag's admin UI and render
like any core tag. Clear caches after changing which tags a model adds so the deriver re-runs.

## Raw events (dispatched objects)

`Drupal\eca_metatag\EcaEvents` constants (`src/EcaEvents.php`):

| Constant | Value | Event class | Methods an action uses |
|---|---|---|---|
| `EcaEvents::TAGS` | `eca_metatag.tags` | `Event\TagsEvent` | `getTags(): array`, `addTag(string $name, string $label, string $description): void` |
| `EcaEvents::ALTER` | `eca_metatag.alter` | `Event\AlterEvent` | `hasMetatag(string $name): bool`, `setMetatagValue(string $name, string $value): void` (a no-op if the tag does not already exist) |

`AlterEvent` wraps the metatags array **by reference** (`__construct(array &$metatags, array &$context)`),
so `setMetatagValue()` mutates the live page metatags.

## Plumbing (how the raw events get dispatched)

- Hook: `Drupal\eca_metatag\Hook\MetatagHooks::metatagsAlter()` implements `hook_metatags_alter()`
  (both as a `#[Hook('metatags_alter')]` method and via the `#[LegacyHook]` wrapper
  `eca_metatag_metatags_alter()` in `eca_metatag.module`). It calls
  `$this->triggerEvent->dispatchFromPlugin('eca_metatag:alter', $metatags, $context)` — this is what
  bridges Metatag's alter hook to the `eca_metatag:alter` ECA event.
- Services (`eca_metatag.services.yml`): `Drupal\eca_metatag\Hook\MetatagHooks` (autowired) receives
  `Drupal\eca\Event\TriggerEvent` (aliased to `@eca.trigger_event`). The parameter
  `eca_metatag.skip_procedural_hook_scan: true` tells ECA to skip the procedural hook scan.
- `eca_metatag.install`: `hook_install()` sets the module weight to `1` (via `module_set_weight`)
  so its hook runs after Metatag's.
- The `TagsEvent` is dispatched not from a hook but from the metatag `EcaDeriver` (see above), i.e.
  during Metatag plugin discovery.
