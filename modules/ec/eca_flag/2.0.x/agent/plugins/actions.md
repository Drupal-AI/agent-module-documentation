# ECA Flag action

Source: `src/Plugin/Action/GetFlagging.php`.
One action, a core `#[Action(id: 'eca_flag_get_flagging', label: 'Flag: get flagging for entity',
type: 'entity')]` also annotated `#[EcaAction]`, extends `ConfigurableActionBase`.

**This module does not provide a flag/unflag action** — flagging and unflagging in an ECA model use
the **Flag module's own** ECA actions (which enforce Flag's access). `eca_flag`'s only action *reads*
flaggings.

## What it does

Loads the flagging entity/entities for the given content entity and puts them on the token stack.

- `flag_name` empty → `FlagService::getAllEntityFlaggings($entity)` (every flag).
- `flag_name` set → `FlagService::getEntityFlaggings($flag, $entity)` (just that flag).
- If exactly one flagging is found, the single `FlaggingInterface` is stored; otherwise the array is
  stored. Stored via `tokenService->addTokenData($tokenName, $flagging)`.
- `token_name` is run through `tokenService->replaceClear()` before use.

## Config

| Key | Widget | Notes |
|---|---|---|
| `token_name` | `textfield`, required | Name of the token that will hold the loaded flagging(s). |
| `flag_name` | `select` | Options: `''` = *all*, plus every flag id (`getAllFlags()`). `#eca_token_select_option` is on, so `_eca_token` selects "use a token" and the value comes from `getTokenValue('flag_name')`. |

Schema `action.configuration.eca_flag_get_flagging` (`flag_name: string`, `token_name: string`).

## Access & dependencies

- `access($object, $account)` returns **allowed only if** `$object` is a `ContentEntityInterface`,
  the account has `view` access to it (`$object->access('view', $account)`), **and** at least one
  flagging exists for it — otherwise forbidden. So the read is gated by the flagged entity's own view
  access.
- `calculateDependencies()` adds the selected flag's config dependency when a specific `flag_name` is
  configured, so exported ECA config carries the flag dependency.

## Downstream tokens

Whatever `token_name` you set becomes usable in later steps — e.g. a single flagging exposes its
fields, or the array can be looped. Combine with the flag events (see events.md) whose stack already
carries `flagging` / `flag` / `entity`.
