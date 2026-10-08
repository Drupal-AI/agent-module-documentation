<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Augmentor ECA Rules (augmentor_eca) — agent index

Submodule of **augmentor**. Adds **one configurable ECA action** so a no-code ECA (BPMN /
business-rules) model can run an Augmentor over a token and store the response into another token.
Package `Augmentor`. Depends on **`augmentor`** and **`eca` (>=2.1)**. Core `^10.1 || ^11 || ^12`.
No routes, permissions, services, or config schema of its own.

- **The action — config keys, execute flow, tokens** →
  [actions/basic-augment.md](actions/basic-augment.md)

## What it provides (from source)

- **ECA action** `augmentator_eca_basic` — *"Basic Augment Action"* / *"Run text through
  Augmentor."* — class `src/Plugin/Action/AugmentorBasic.php` (`#[Action]` + `#[EcaAction]`),
  extending the module's `AugmentorBase` (`src/Plugin/Action/AugmentorBase.php`, which extends ECA's
  `Drupal\eca\Plugin\Action\ConfigurableActionBase`).
- Gets the Augmentor manager via `$container->get('plugin.manager.augmentor.augmentors')`.
- Config keys: `augmentor` (uuid), `response_key` (default `default`), `token_input`,
  `token_result` — the last three are `#eca_token_reference` fields.
- `execute()`: resolve the augmentor; read `token_input` via ECA's `tokenService->getTokenData(...)
  ?->getValue()`; if either is empty, return; else `$augmentor->execute($value)` and
  `tokenService->addTokenData($token_result, $response_key ? $result[$response_key] : $result)`.
- All access/orchestration is ECA's; this submodule adds no gate of its own.
