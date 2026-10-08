<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# File Gate Form (file_gate_form) — agent index

Optional submodule of **File Gate** adding the `form` gate method: a native email / lead-capture form grants the
download on submission. Version **1.10.x**, core `^11.4 || ^12`, package Security. Depends on
`file_gate:file_gate`. Enable with `drush en file_gate_form`. No permissions, no config schema.

## Provides
- **Gate method** `form` — `\Drupal\file_gate_form\Plugin\GateMethod\FormGate`. `mint()` → `NULL` (live);
  `grants()` returns TRUE when the session holds a per-file grant in private tempstore
  (`FormGate::GRANT_COLLECTION` = `file_gate_form`) that is younger than the field `ttl` (default 3600 s). Field
  settings: `ttl` (≥60), `require_consent`, `consent_text`, `intro_text`.
- **Route** `file_gate_form.gate` — `/file-gate/form/{file}`, `_access: TRUE`, form
  `\Drupal\file_gate_form\Form\FileGateForm`. 404s unless the file is gated with the `form` method.
- **Event** `\Drupal\file_gate_form\Event\LeadCapturedEvent` (`public readonly` `$file`, `$email`, `$consent`) —
  dispatched on each valid submission so the site persists the lead (File Gate stores none).

## Flow
`FileGateForm` renders email (required), optional consent checkbox, an off-screen honeypot (`hp_url`), and submit.
`validateForm()` rejects a filled honeypot and enforces a per-IP flood (10 / 3600 s). `submitForm()` dispatches
`LeadCapturedEvent`, records the session grant in tempstore keyed by file UUID, and redirects to
`file_gate.download?f=<uuid>`. The `form` method then checks that grant on delivery.

See [plugins/form.md](plugins/form.md) for the method, the form, spam guards, and the lead event.
