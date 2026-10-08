<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Extending execution — hooks and events

Augmentor exposes two independent extension surfaces around a run.

## Hooks (fired by the execute controller)

Declared in `augmentor.api.php`, invoked in `AugmentorController::execute()` via
`moduleHandler->invokeAll()`:

- **`hook_pre_execute(array &$decoded_request_body)`** — runs *before* execution on the decoded
  request body, an assoc array with keys `input` and `augmentor` (and any widget extras). Mutate it
  in place to change what runs or the input.
- **`hook_post_execute(array &$result, array &$decoded_request_body)`** — runs *after* execution;
  `$result` is the augmentor's keyed response array. Reshape/annotate results before they are
  JSON-encoded back to the browser.

```php
function mymodule_pre_execute(array &$request_body) {
  if (isset($request_body['input'])) {
    $request_body['input'] = trim($request_body['input']);
  }
}

function mymodule_post_execute(array &$result, array &$request_body) {
  if (!empty($result['default'])) {
    $result['default'] = ucfirst($result['default']);
  }
}
```

These only fire on the **HTTP execute path** (field-widget buttons). Actions/ECA/Search API call the
manager directly and do **not** trigger these hooks.

## Events (fired by the manager on every run)

Dispatched by `AugmentorManager` inside `executeAugmentor()` for **all** call paths:

- **`AugmentorInputEvent::ALTER`** (`augmentor.input.alter`) — `getInput()/setInput()`, dispatched by
  `processInput()` before `execute()`.
- **`AugmentorOutputEvent::ALTER`** (`augmentor.output.alter`) — `getOutput()/setOutput()`,
  dispatched by `processOutput()` after `execute()`.

The module registers a no-op subscriber `AugmentorEventSubscriber` (service
`augmentor.event_subscriber`) as a starting point — override or add your own subscriber to act on
these events.

Caveat (from source): `executeAugmentor()` calls `processInput($input)` but does **not** reassign
its return value before `execute($input)`, and calls `processOutput($response)` without reassigning
either. So today the input/output events act as **observation/side-channel** points rather than
guaranteed in-line mutators of the value passed to `execute()`. Prefer the `pre_execute`/
`post_execute` hooks (which mutate by reference) when you need to reliably change the executed input
or the returned result on the HTTP path.

## Also alterable

`AugmentorManager` calls `alterInfo('augmentor_info')`, so `hook_augmentor_info_alter(&$definitions)`
can alter the list of available augmentor **plugin definitions**.
