<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Clipboard service, access check & controller

Sources: `src/ParagraphsClipboardService.php`, `src/Access/ParagraphsClipboardAccess.php`,
`src/Controller/CopyClipboardController.php`, `paragraphs_clipboard.services.yml`.

## Service `paragraphs_clipboard.paragraphs_clipboard_service`

`ParagraphsClipboardService` wraps a **private tempstore** (`tempstore.private`, collection
`paragraphs_clipboard`) — clipboard data is per-user and session-scoped. Constants:
`CLIPBOARD_KEY = 'copy_clipboard'` (id/revision copies, this module), `CLIPBOARD_UUID_KEY =
'copy_clipboard_uuid'` (uuid copies, used by the layout submodule).

| Method | Purpose |
|---|---|
| `setClipboardData($key, array $data)` | Delete then set the clipboard entry. |
| `getClipboardData(string $key)` | Raw stored array (or the tempstore object). |
| `getParagraphByRevisionId($rid)` | `loadRevision($rid)` from paragraph storage. |
| `getParagraphByUuid(string $uuid)` | `entity.repository` load by UUID. |
| `getParagraphFromClipboard(string $key): ?Paragraph` | Resolve the stored entry to a paragraph (by `revision_id`, else `paragraph_uuid`). |
| `checkCardinality(int $count, int $cardinality): bool` | True if `count < cardinality` or unlimited. |

## Access `paragraphs_clipboard.paragraphs_clipboard_access`

`ParagraphsClipboardAccess::access(Paragraph $paragraph, FieldDefinitionInterface $field): AccessResult`:
- Allowed only if `$paragraph->access('update')` **and** the paragraph's bundle is permitted by the
  target field's `handler_settings`:
  - `isAllowedParagraphType()` honours `target_bundles` and `negate` (empty/negated list logic), so a
    paragraph can only be pasted into a field that would accept that bundle.

This same service is reused by the `layout_paragraphs_clipboard` submodule.

## Controller `CopyClipboardController::copy(ParagraphInterface $paragraph)`

Backs the `paragraphs_clipboard.copy` JSON route (guarded by `_entity_access: paragraph.update`).
Stores `paragraph_id` + `revision_id` under `CLIPBOARD_KEY` and returns an `AjaxResponse` with a
`MessageCommand` ("Paragraph has been copied to clipboard.").

## Calling it programmatically

```php
$svc = \Drupal::service('paragraphs_clipboard.paragraphs_clipboard_service');
$svc->setClipboardData(\Drupal\paragraphs_clipboard\ParagraphsClipboardService::CLIPBOARD_KEY, [
  'paragraph_id' => $paragraph->id(), 'revision_id' => $paragraph->getRevisionId(),
]);
$copy = $svc->getParagraphFromClipboard(\Drupal\paragraphs_clipboard\ParagraphsClipboardService::CLIPBOARD_KEY);
```
