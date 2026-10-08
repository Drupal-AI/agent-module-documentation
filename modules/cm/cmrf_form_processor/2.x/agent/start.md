<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CiviMRF Form Processor (cmrf_form_processor) — agent index

Connects **Drupal Webforms to CiviCRM's Form Processor** extension over a **CiviMRF** (CiviCRM
REST framework) connection. It ships a single Webform **handler plugin** that, on the configured
submission states, maps a Webform submission's field values to Form Processor API parameters and
POSTs them to CiviCRM through `cmrf_core`. Beyond plain submission it also supports: retrieving
**default values** from CiviCRM to pre-fill a form (turning an "insert" form into an "edit" form),
server-side **validation** against the Form Processor, live **calculations**, CiviCRM-driven
**redirects**, and file up/download between Webform and CiviCRM. Package `CiviCRM`. Core
`^8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later. Installed **2.2.20** (version dir `2.x`).

## Dependencies

- Drupal modules (`.info.yml`): **`cmrf_core`** (the CiviMRF connection layer) and **`webform`**.
- Composer (`composer.json`): `drupal/cmrf_core:^2.1`, `drupal/webform:^6.0`.
- CiviCRM side: the **Form Processor** extension must be installed on the target CiviCRM, reachable
  through a configured CiviMRF connector. This module makes **no direct HTTP call** to CiviCRM
  itself — all API traffic goes through `cmrf_core`'s `Core::createCall()` / `executeCall()`.

## What it provides (from source)

- **Webform handler** `cmrf_form_processor` (`Plugin/WebformHandler/FormProcessorWebformHandler`,
  `@WebformHandler`, category "CiviCRM"). Its configuration form lets an admin pick a CiviMRF
  **connector** + **Form Processor**, sync Form Processor input fields into the Webform as elements
  (`FormProcessorWebformBuilder`), choose per-field submission **formats**, pick the submission
  **states** to send on, and enable defaults/validation/calculation/redirect. The heavy lifting is
  split into four sub-handlers extending `FormProcessorBaseHandler`:
  `WebformSubmissionHandler` (send-to-CiviCRM + redirect), `DefaultDataHandler` (pre-fill),
  `CalculationHandler` (live calc via AJAX), `ValidationHandler` (server-side validation).
- **`Factory`** (`cmrf_form_processor.factory` pattern, instantiated with `cmrf_core.core`) — thin
  wrapper over `cmrf_core` that builds/executes Form Processor API calls (`FormProcessorInstance`,
  `FormProcessor`, `FormProcessorDefaults`, `FormProcessorValidation`, `FormProcessorCalculation`)
  and caches metadata (fields, outputs, options) in `cache.default`.
- **`OptionsSet`** — mirrors CiviCRM select-field option lists into `WebformOptions` config
  entities (id prefix `cmrfformprocessor_`), refreshed on cron/cache-flush; wired via
  `hook_webform_options_alter`.
- **File download route** `cmrf_form_processor.download_file` → `/cmrf/file/{fileid}`
  (`Controller/DownloadFileController`, `_access: 'TRUE'`) — serves a managed file gated by a
  content-hash query token, plus the `cmrf_form_processor.file` service (`File/File`) that downloads
  CiviCRM-supplied attachment URLs into `private://cmrf_form_processor/<uid>/…`.
- **Tokens** (`cmrf_form_processor.module`): the `cmrf-form-processor` token type exposing
  `default-data:*`, `return-data:*`, `calculated-data:*`.
- **JS libraries** (`.libraries.yml`): `webform.element.form_processor_calculation` and
  `webform.element.form_processor_defaults` — the AJAX triggers for live calculation / default
  retrieval. No permissions, no install/update hooks, no config schema files, no templates.

## Submodules

- **`cmrf_form_processor_display`** — adds a `cmrf_display` Webform element (display-only markup /
  link / button populated from a Form Processor output). See
  [modules/cmrf_form_processor_display/2.x/agent/start.md](../../modules/cmrf_form_processor_display/2.x/agent/start.md).
- **`cmrf_form_processor_mollie`** — moves the Form Processor call to the **Mollie payment
  webhook** so CiviCRM is only invoked after payment. See
  [modules/cmrf_form_processor_mollie/2.x/agent/start.md](../../modules/cmrf_form_processor_mollie/2.x/agent/start.md).

## Solution docs

- **Handler configuration, submission mapping, defaults/validation/calculation, redirect** →
  [handler/webform-handler.md](handler/webform-handler.md)
- **File download route + attachment download service, tokens** →
  [api/files-and-tokens.md](api/files-and-tokens.md)
