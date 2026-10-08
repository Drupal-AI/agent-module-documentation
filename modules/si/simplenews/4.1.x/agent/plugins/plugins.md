# Plugin type — Recipient handlers

Simplenews defines one plugin type, **`simplenews_recipient_handler`**, which decides *which
subscribers* receive a given newsletter issue.

- Manager service: `plugin.manager.simplenews_recipient_handler`
  (`Drupal\simplenews\RecipientHandler\RecipientHandlerManager`).
- Discovery: annotation `@RecipientHandler` (`src/RecipientHandler/Annotation/RecipientHandler.php`),
  interface `Drupal\simplenews\RecipientHandler\RecipientHandlerInterface`.
- Plugins live in `Plugin/simplenews/RecipientHandler/`.

## Built-in handler

- `simplenews_all` (`RecipientHandlerAll`) — the default; sends to **all active subscribers** of the
  issue's newsletter. Base classes `RecipientHandlerBase`, `RecipientHandlerEntityBase`,
  `RecipientHandlerSelectBase` support building custom recipient lists (e.g. from an entity query).

## Implement a custom handler

Create `Plugin/simplenews/RecipientHandler/MyHandler.php` extending `RecipientHandlerBase` (or a
select/entity base), annotate it with `@RecipientHandler`, and implement the interface to yield the
recipient rows written to the spool. Restrict which handlers a newsletter may use via the
newsletter config entity's `allowed_handlers` list.

The spool resolves the handler for an issue through
`SpoolStorageInterface::getRecipientHandler($issue)`.
