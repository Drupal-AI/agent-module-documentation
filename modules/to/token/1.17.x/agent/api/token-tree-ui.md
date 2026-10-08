# Embed a token browser in a form

Token provides render elements to show users which tokens are available. Add either to a
`$form` array.

**Link that opens the tree in a dialog:**
```php
$form['help'] = [
  '#theme' => 'token_tree_link',
  '#token_types' => ['node', 'user'],   // token types relevant to this form
  '#show_restricted' => TRUE,           // optional
  '#global_types' => FALSE,             // hide global tokens (site:, current-date:)
];
```

**Inline tree table (`token` element):**
```php
$form['tokens'] = [
  '#type' => 'token_tree_table',        // Drupal\token\Element\TokenTreeTable
  '#token_types' => ['node'],
];
```

The `token_tree_link` renders as a "Browse available tokens." link that opens this dialog
(captured on the core Account settings email form at `/admin/config/people/accounts` — Token
has no page of its own; the link sits under the email Body, the dialog lists Name / Token /
Description in an expandable tree):
![Token browser dialog](../../../../../../../screenshots/token/1.17.x/token-browser-dialog.png)

Notes:
- `#token_types` restricts which token groups are shown; use `['all']` for everything.
- The link element loads `token/token` library automatically.
- Endpoint behind the link: route `token.tree` (`/token/tree`, CSRF-protected).
- To find valid `#token_types` for an entity, map it with the entity mapper
  (see [token-service.md](token-service.md)).
