<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `augmentor` plugin type — writing a provider

## What an augmentor is

An **augmentor plugin** is a class that takes a text `$input` and returns a **keyed array** result.
The type is managed by `AugmentorManager` (`src/AugmentorManager.php`, service
`plugin.manager.augmentor.augmentors`):

- Namespace scanned: `Plugin/Augmentor`; interface `Drupal\augmentor\AugmentorInterface`;
  attribute `Drupal\augmentor\Attribute\Augmentor` (id, label, description, deriver) with a legacy
  `Annotation\Augmentor` fallback; alter hook `augmentor_info`; cache bin `augmentor_plugins`.

A **plugin** is the code; an **augmentor instance** is a saved configuration of that plugin (label,
UUID, weight, API key, debug + plugin `settings`) stored in `augmentor.settings`. `getDefinitions()`
lists plugin classes; `getAugmentors()` lists saved instances.

## Contract

Extend `AugmentorBase` (`src/AugmentorBase.php`, implements `AugmentorInterface`,
`ContainerFactoryPluginInterface`) and implement **`execute($input): array`** — return an
associative array whose keys are "response keys" (convention: `default` for the primary result).
Widgets/actions later pick a key out of that array.

Minimal blueprint (the bundled Demo augmentor, `augmentor_demo/src/Plugin/Augmentor/Demo.php`):

```php
#[Augmentor(
  id: 'demo',
  label: new TranslatableMarkup('Demo Augmentor'),
  description: new TranslatableMarkup('Split text into sentences separated by a dot.'),
)]
class Demo extends AugmentorBase {
  public function execute($input) {
    // ... process $input ...
    return ['default' => $output];   // keyed array
  }
}
```

`AugmentorBase::__construct` receives (and `create()` wires): `logger.factory` (channel
`augmentor`), `key.repository`, `current_user`, `file_system`, `file.repository`.

## Configuration form & stored config

`AugmentorBase::buildConfigurationForm()` provides three base elements every augmentor inherits:

- `label` (textfield),
- `key` — a **`key_select`** element (Key module) for the API key,
- `debug` (checkbox).

Override `buildConfigurationForm()`/`submitConfigurationForm()`/`defaultConfiguration()` to add
provider settings (model, endpoint, temperature…). The Demo augmentor `unset($form['key'])` because
it needs no credential.

`getConfiguration()` returns `['label','uuid','id','weight','key','debug','settings' => …]`;
`setConfiguration()` splits `settings` back out and re-hydrates label/key/debug/uuid. This is the
shape persisted under `augmentor.settings:augmentors.<uuid>`.

## API-key handling (Key module)

Keys are **never stored inline** — the augmentor stores only the **Key entity id** (`getKey()`), and
resolves the secret lazily:

- `getKeyObject()` → `keyRepository->getKey($this->key)` (returns null when unset),
- `getKeyValue()` → `->getKeyValue()` (the actual secret) — call this inside `execute()` when
  building the outbound request.

So credentials live in a Key entity (env var, file, config-with-encryption, …) and never in the
augmentor's exported config. Provider modules are responsible for using `getKeyValue()` correctly.

## Helpers on the base

- `normalizeText($value)` — `Html::decodeEntities()` + `trim()`.
- `debug(array $messages)` — when the instance's debug flag is on, logs
  `json_encode(..., JSON_HEX_TAG|JSON_HEX_APOS|JSON_HEX_AMP|JSON_HEX_QUOT)` to the `augmentor`
  channel. The manager calls this with `['input'=>…, 'response'=>…]` after each run.

## How the manager runs one

`AugmentorManager::executeAugmentor($augmentor_id, $input)` (used by the controller, Action, widgets'
preview, ECA and Search API):

1. throws if `$input` is empty;
2. `getAugmentor($uuid)` → `createInstance($type)` + `setConfiguration()` + `setUuid()`;
3. `processInput()` (dispatch `AugmentorInputEvent::ALTER`) — note: the returned processed input is
   **not** reassigned before `execute()`; the event is a side-channel;
4. `$augmentor->execute($input)`;
5. `processOutput()` (dispatch `AugmentorOutputEvent::ALTER`);
6. `debug()`; validates the response is an array and (if present) `status === 200`;
7. on any `\Exception` returns `['_errors' => [message]]`.

`isAugmentorValidTarget()` is a helper used by widgets/actions to whitelist target fields: it accepts
`body`, `title`, or any field prefixed `field_`/`schema_`, and produces a human label.
