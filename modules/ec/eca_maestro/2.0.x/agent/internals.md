<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ECA Maestro — internals (trait, constants, help)

Install/enable: `drush en eca_maestro`. Ensure `eca`, `eca_endpoint` (declared deps) and `maestro`
(Composer dep, not in info.yml) are present. No settings page — you use the plugins inside ECA
models via the ECA modeller. The module defines no routes, permissions, services, config objects,
config schema or submodules.

## MaestroTrait — `src/Plugin/MaestroTrait.php`
Shared by every action and the condition. Responsibilities:

- **Logging** to the `eca_maestro` channel: `getLogger()` (lazily `\Drupal::logger('eca_maestro')`),
  plus `info()`, `warning()`, `error()`, and message builders `emptyMessage()`, `invalidMessage()`,
  `undefinedMessage()`.
- **Token service compatibility:** `getTokenServices()` returns `$this->tokenServices` on ECA 1.x
  or `$this->tokenService` on ECA 2.x (property-existence check) — this is why `composer.json`
  accepts `drupal/eca:^1||^2`.
- **Typed config readers**, each calling `getTokenServices()->getOrReplace($this->configuration[$key])`
  then coercing:
  - `getConfigurationIntValue($name,$label)` → int or NULL (numeric check; warns on empty/invalid/undefined).
  - `getConfigurationStringValue($name,$label,$required=FALSE)` → string or NULL (`getString()` on TypedData).
  - `getConfigurationMixedValue($name,$label,$required=FALSE)` → raw value.
- **Named getters** built on the above: `getAssignee()`, `getId()`, `getProcessId()`, `getQueueId()`,
  `getStartTask()`, `getTaskStatus()`, `getTemplateMachineName()`, `getTokenName($required=TRUE)`,
  `getType()`, `getUserId()`, `getVariableName()`.

## EcaMaestroConstants — `src/EcaMaestroConstants.php`
String constants for config keys and their human labels, plus `ECA_MAESTRO_LOG_CHANNEL = 'eca_maestro'`.
Keys: `eca_maestro_id`, `_processid`, `_queueid`, `_assignee`, `_start`, `_status`, `_template`,
`_token`, `_type`, `_userid`, `_value`, `_varname` (each with a `*_LABEL`). No config schema file
declares these — they exist only as ECA plugin `configuration` array keys.

## hook_help — `eca_maestro.module`
`eca_maestro_help()` renders `README.md` on `help.page.eca_maestro`. If the `markdown` module is
enabled it uses the `markdown` filter plugin; else if `markdown_easy` is enabled it uses that
(flavor `github`); otherwise it wraps the raw README in `<pre>`. No other hooks. The README is a
static in-repo file, not user input.
