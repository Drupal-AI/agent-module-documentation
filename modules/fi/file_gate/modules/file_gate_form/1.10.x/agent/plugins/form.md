<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# File Gate Form — the `form` gate method, the capture form & lead event

## The gate method — `FormGate`
`src/Plugin/GateMethod/FormGate.php`, `#[GateMethod(id: 'form', …)]`, `final`, extends `GateMethodBase`.

- Constants: `GRANT_COLLECTION = 'file_gate_form'` (private-tempstore collection), `DEFAULT_TTL = 3600`.
- `mint()` → `NULL` (access decided live from the recorded per-session grant).
- `grants(FileInterface $file, Request $request)`: reads the tempstore value for `$file->uuid()` (the request
  time recorded at submit); returns TRUE only when it exists and `now - granted < ttl`.
- Field settings (`fieldSettingsForm`/`fieldSettingsSubmit`): `ttl` (≥60), `require_consent` (bool),
  `consent_text`, `intro_text` (empty values dropped).

To use it: on a gated private file/image field pick method "Email / form capture (coupled)"; link visitors to
`/file-gate/form/{file-uuid}`.

## The form — `FileGateForm`
`src/Form/FileGateForm.php`, route `file_gate_form.gate` (`/file-gate/form/{file}`, `_access: TRUE`, `no_cache`).

- `buildForm()` loads the file by UUID and 404s unless it is gated with the `form` method
  (`loadFormGatedFile()`). Renders optional `intro_text` (via an escaped `@intro` placeholder), a required `email`
  field, an optional required `consent` checkbox (label = `consent_text`), an off-screen **honeypot** `hp_url`
  (positioned off-screen, `autocomplete=off`, `tabindex=-1`, `aria-hidden`; deliberately not named
  url/website/homepage to avoid autofill false positives), and a submit button.
- `validateForm()`: a non-empty honeypot fails without revealing why; a per-IP flood
  (`SUBMIT_LIMIT = 10` / `SUBMIT_WINDOW = 3600 s`, event `file_gate_form.submit`) blocks excess attempts.
- `submitForm()`: registers the flood hit, reloads the file, dispatches `LeadCapturedEvent`, records the session
  grant (`tempstore.private` collection `file_gate_form`, key = file UUID, value = request time), and redirects to
  `file_gate.download?f=<uuid>`.

## The lead event — `LeadCapturedEvent`
`src/Event/LeadCapturedEvent.php` (extends Symfony `Event`). Constructed with `public readonly FileInterface
$file`, `string $email`, `bool $consent`. Dispatched only after email/honeypot/rate-limit validation pass. File
Gate persists nothing; subscribe to store the lead where you handle PII and consent (Contact, Webform, a CRM):

```php
// your_module.services.yml → event_subscriber tag; getSubscribedEvents():
//   return [LeadCapturedEvent::class => 'onLead'];
public function onLead(\Drupal\file_gate_form\Event\LeadCapturedEvent $event): void {
  // $event->file, $event->email, $event->consent
}
```
