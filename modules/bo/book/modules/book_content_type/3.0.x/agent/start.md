# book_content_type — agent start

Submodule of **book** (`part_of: book`). Ships inside the project under
`tests/modules/` with `package: Testing` — a fixture/convenience module, not a
production feature. No config form, permissions, services or plugins.

What it does: its only logic is `hook_install()` in `book_content_type.install`,
which writes `book.settings.allowed_types` to register a `book` content type as an
allowed book type whose allowed `child_type` is also `book`:

```php
// book_content_type_install()
$config = \Drupal::configFactory()->getEditable('book.settings');
$config->set('allowed_types', [['content_type' => 'book', 'child_type' => 'book']])->save();
```

Enable with `drush en book_content_type`. For how `allowed_types` works and other
Book settings, see the parent's
[../../../../3.0.x/agent/configure/settings.md](../../../../3.0.x/agent/configure/settings.md).
