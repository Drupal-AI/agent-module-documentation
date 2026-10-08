# InPlaceEditor plugin type

Quick Edit defines one plugin type: **InPlaceEditor** — the widget used to edit a field in
place.

- Annotation: `@InPlaceEditor(id, module)` (`src/Annotation/InPlaceEditor.php`).
- Manager service: `plugin.manager.quickedit.editor` (`Plugin/InPlaceEditorManager`).
- Interface: `Plugin/InPlaceEditorInterface`; base class `Plugin/InPlaceEditorBase`.
- Directory: `src/Plugin/InPlaceEditor/`.

Bundled editors:
- `plain_text` (`PlainTextEditor`) — simple single-line/plain string fields.
- `editor` (`Editor`) — formatted (rich text) fields, hands off to core Editor/CKEditor.
- `image` (`Image`) — image fields.
- `form` (`FormEditor`) — generic fallback that renders the field's real edit form for
  anything the specialized editors don't handle.

Which editor a field gets is chosen by `quickedit.editor.selector` (`EditorSelector`) based on
the field type / formatter and each editor's `isCompatible()` check.

## Implement a custom editor
```php
#[InPlaceEditor(id: 'my_editor', module: 'my_module')]
class MyEditor extends InPlaceEditorBase {
  public function isCompatible(FieldItemListInterface $items) { return TRUE; }
  public function getMetadata(FieldItemListInterface $items) { return []; }
  public function getAttachments() { return ['library' => ['my_module/quickedit.my_editor']]; }
}
```
Provide a matching JS editor (extending `Drupal.quickedit.EditorView`) in the declared library.
