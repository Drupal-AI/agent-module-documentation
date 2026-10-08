# Null User — manual setup guide

**Null User** (`null_user`) is a tiny **developer utility**: it adds a `NullUser`
class — a "null‑object" variant of Drupal's `AnonymousUserSession` — to make
user‑object handling in code cleaner. Despite the name, it performs **no**
anonymisation, deletion, or mutation of user accounts. It is purely a value class
for developers to instantiate and compare against.

The problem it solves is a familiar one: code that must represent "no user" ends
up juggling `NULL`, uid 0 (the anonymous user), and real accounts, which leads to
fragile checks scattered through a codebase. Null User gives you an explicit,
distinct object to return and compare instead of mixing `NULL` with the anonymous
user. Its `Drupal\null_user\NullUser` extends `AnonymousUserSession` and overrides
three methods: `id()` returns `NULL` (not 0), `getRoles()` returns an empty array,
and `hasPermission()` always returns `FALSE`. This is the classic *null‑object
pattern* applied to Drupal accounts.

It has **no routes, permissions, services, forms, or configuration** — there is
genuinely nothing to set up beyond enabling it and using the class in your own
code. It has no attack surface and nothing to gate.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

This module has **no configuration** of any kind (`configure` is null, and it
ships no settings form). Everything it offers is the `NullUser` class, used from
code as shown below.

## How to use it

Enable the module, then instantiate and compare against the class in custom code:

```php
$account = new \Drupal\null_user\NullUser();
// $account->id() === NULL, getRoles() === [], hasPermission(...) === FALSE
```

Typical uses include returning a `NullUser` from a service that may have no
account, distinguishing "unresolved account" (id `NULL`) from a real anonymous
session (uid 0), seeding unit tests with a deterministic empty‑user object, and
keeping account‑comparison logic branch‑free and readable. The introductory blog
post
[Null users and system users in Drupal](https://www.oliverdavies.uk/blog/null-users-and-system-users-in-drupal)
explains the pattern in more depth. The **System User** module is one real‑world
consumer of Null User.
