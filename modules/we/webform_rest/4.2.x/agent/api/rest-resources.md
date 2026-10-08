<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# webform_rest — REST resources & payloads

Five REST resource plugins (`src/Plugin/rest/resource/`). All endpoints honour the format
with `?_format=json` (or `xml`, `hal_json` if enabled). Enable a resource first — see
[../configure/enable-resources.md](../configure/enable-resources.md).

| Plugin id | Methods | Endpoint (`uri_paths`) | Purpose |
|---|---|---|---|
| `webform_rest_elements` | GET | `/webform_rest/{webform_id}/elements` | Webform elements as a render array |
| `webform_rest_fields` | GET | `/webform_rest/{webform_id}/fields` | Flattened field list, defaults/tokens resolved |
| `webform_rest_submit` | POST | `/webform_rest/submit` | Create a submission |
| `webform_rest_submission` | GET, PATCH | `/webform_rest/{webform_id}/submission/{uuid}` | Read / update a submission |
| `webform_rest_complete_submission` | GET | `/webform_rest/{webform_id}/complete_submission/{uuid}` | Submission data + fields |

## Read a webform

```
GET /webform_rest/contact/elements?_format=json      # render array of elements
GET /webform_rest/contact/fields?_format=json        # flat fields with default values
```
`elements` returns the raw Form API elements; `fields` returns a simplified list. Unknown
webform id → 404; missing id → 400.

## Submit a webform

```
POST /webform_rest/submit
Content-Type: application/json
{
  "webform_id": "contact",
  "name": "Ada",
  "email": "ada@example.com",
  "subject": "Hi",
  "message": "Hello"
}
```
- `webform_id` is **required** (400 if missing/invalid, 400 with error body if no data).
- All other keys are the webform's field values (arrays for multi-value fields).
- Runs the same validation, handlers, emails, and hooks as a UI submission; enforces
  webform open/close and `submission_create` access.
- Success → `{ "sid": "<submission-uuid>" }`. Validation errors → HTTP 400 with an `error`
  object listing the field errors.
- Draft: include `"draft": true` (only if the webform allows drafts, else 400).
- If `webform_rest.settings:confirmation_settings` is on, the response also carries the
  webform's `confirmation_type` / `confirmation_url` / `confirmation_message` / etc.

## Read / update a submission

```
GET   /webform_rest/contact/submission/{uuid}?_format=json
PATCH /webform_rest/contact/submission/{uuid}?_format=json   { "message": "edited" }
GET   /webform_rest/contact/complete_submission/{uuid}?_format=json
```

## Altering the submit response — `webform_rest.submit.return` event

`WebformSubmitResource::post()` dispatches `WebformSubmitReturnEvent`
(`Drupal\webform_rest\Event\WebformSubmitReturnEvent`, constant
`WebformSubmitReturnEvent::WEBFORM_SUBMIT_RETURN = 'webform_rest.submit.return'`) before
returning. Subscribe to it to rewrite the response body or HTTP code. The event exposes
`getType()`, `getSubmissionValues()`, and — **returned by reference** so you can mutate them
in place — `getReturnData(): array` and `getHttpCode(): int`. The resource builds a
`ModifiedResourceResponse` from the (possibly modified) data + code.

```php
// mymodule.services.yml → tags: [{ name: event_subscriber }]
public static function getSubscribedEvents(): array {
  return [\Drupal\webform_rest\Event\WebformSubmitReturnEvent::WEBFORM_SUBMIT_RETURN => 'onReturn'];
}
public function onReturn(\Drupal\webform_rest\Event\WebformSubmitReturnEvent $event): void {
  $data = &$event->getReturnData();   // reference — assign into it to change the response body
  $data['received_at'] = time();
  $code = &$event->getHttpCode();     // reference — reassign to change the HTTP status
}
```
