# Views filter and token integrations

Both are in `node_co_authors.module`, plus one plugin class.

## Views filter — `author_co_author_name`

`node_co_authors_views_data()` adds a filter handler on the `node_field_data` table:

```php
$data['node_field_data']['author_co_author_name'] = [
  'title' => t('(Co-)author name (autocomplete)'),
  'filter' => [
    'title' => t('(Co-)author name (autocomplete)'),
    'help'  => t('The name of the author or one of the co-authors. …'),
    'field' => 'uid',
    'id'    => 'author_co_author_name',
  ],
];
```

The handler is `Drupal\node_co_authors\Plugin\views\filter\AuthorCoAuthorName`
(`@ViewsFilter("author_co_author_name")`), which **extends the core `user` module's `Name` filter**
(`Drupal\user\Plugin\views\filter\Name`). It therefore inherits the same autocomplete UI (type a
user name, the filter stores the resolved user ID(s)).

Its only override is `opSimple()`: it uses the node entity's `TableMapping` to resolve the
`co_authors` field's data table and `target_id` column, adds a relationship/join to that table, then
matches the exposed user ID(s) against **either** `node_field_data.uid` **or** the co-authors table
column, OR'd together via `setWhereGroup('OR')`:

```php
$coAuthorsTable  = $mapping->getFieldTableName('co_authors');
$coAuthorsColumn = $mapping->getColumnNames('co_authors')['target_id'];
$groupId = $this->query->setWhereGroup('OR');
$this->query->addWhere($groupId, "$this->tableAlias.$this->realField", array_values($this->value), $this->operator);
$this->query->addWhere($groupId, "$coAuthorsTable.$coAuthorsColumn", array_values($this->value), $this->operator);
```

Use this filter in a content View to list nodes where a given user is the author **or** a co-author.
Table/column names come from the entity's table mapping (not from request input) and the values are
passed to `addWhere()` as parameters, so the query is bound, not string-concatenated.

## Token — `[node:co_authors_email]`

`node_co_authors_token_info()` declares one token under the `node` type: `co_authors_email`, of type
`array`. `node_co_authors_tokens()` fills it with a map of `uid => email` built from
`$node->get('co_authors')->referencedEntities()`:

- `[node:co_authors_email]` — the array of the node's co-authors' email addresses.
- Chained array tokens also work: `\Drupal::token()->findWithPrefix($tokens, 'co_authors_email')`
  delegates to the core `array` token type (e.g. `[node:co_authors_email:join:", "]`,
  `[node:co_authors_email:count]`), generated only when at least one co-author email exists.

The comment in source notes this manual token exists because nested entity tokens are not yet
possible in the Token module (see drupal.org issue 1195874). Intended for server-side use such as
email notifications where a site builder places the token.
