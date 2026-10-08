# Session Entity — manual setup guide

**Session Entity** (`session_entity`) provides a content entity type that is stored
in the user's session instead of the database. Each user (including anonymous
visitors) has a single session entity, which they can edit if they have the
permission. Because it is a normal content entity, you can add fields to it — and
because it lives in the session, its data automatically disappears when the session
ends.

That combination makes it a neat way to model per-visit, ephemeral data. Classic
uses are letting a visitor set preferences or details about themselves — a chosen
location, a display option — without creating a user account or writing anything
permanent to the database. Under the hood the module uses a custom entity storage
controller that keeps the entity's data in Drupal's private tempstore.

This is a **developer building block**, not a turn-key feature. There is no settings
form: you enable it, grant its permission, and then define fields and write code
that reads and writes the session entity. To fetch the current user's session
entity in code:

```php
$session_entity = \Drupal::service('session_entity.current')
  ->getCurrentUserSessionEntity();
```

A couple of things to keep in mind about the data. It lives only in the session, so
it is per-user, not shared, and it is *not* the place for anything that must persist
or that needs cross-user integrity. And avoid storing sensitive data in the session
beyond what is strictly necessary — session data is only as protected as your
session store. The module has no broad access-control role beyond its own
permission. It needs no other modules and supports Drupal 8.8 through 11.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

After enabling, grant the module's permission to the roles that should be able to
edit their session entity (at **People → Permissions**,
`/admin/people/permissions`). Then add any fields you need to the session entity
type through Drupal's field UI, and use the `session_entity.current` service (shown
above) from your own code to read and update the current user's entity. Everything
you store there vanishes when the visitor's session ends.
