<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Null User adds a `NullUser` class — a null-object variant of Drupal's `AnonymousUserSession` — to make user-object comparisons in code cleaner.
---
The problem it solves: code that must represent "no user" often juggles `NULL`, uid 0 (anonymous) and real accounts, leading to fragile checks. Null User provides an explicit `NullUser` object so developers can return and compare a distinct "null" account rather than mixing `NULL` and the anonymous user.

How it works: `Drupal\null_user\NullUser` extends `AnonymousUserSession` and overrides three methods — `id()` returns `NULL` (not 0), `getRoles()` returns an empty array, and `hasPermission()` always returns `FALSE`. It has no routes, no permissions, no services, no forms and no configuration; it is purely a developer utility class to instantiate and compare against. It performs no user anonymisation, deletion or mutation of any kind.

Setup: enable the module and use the class in custom code (`new \Drupal\null_user\NullUser()`); there is nothing to configure.
---
- Represent "no user" as an explicit object instead of NULL.
- Distinguish a null user (id NULL) from anonymous (uid 0) in code.
- Return a NullUser from a service that may have no account.
- Compare an account against a known null-object instance.
- Guarantee `hasPermission()` is always FALSE for the null case.
- Guarantee an empty role list for the null case.
- Simplify null-safety in account-handling code.
- Avoid scattered `is_null()` checks around user objects.
- Provide a consistent sentinel account across a codebase.
- Use as a reference implementation of the null-object pattern in Drupal.
- Type-hint against AccountInterface while passing an explicit null user.
- Short-circuit permission checks safely with a guaranteed-FALSE account.
- Seed unit tests with a deterministic empty-user object.
- Replace ad-hoc anonymous-user stand-ins with a named class.
- Signal "unresolved account" distinctly from a real anonymous session.
- Keep account-comparison logic branch-free and readable.
- Depend on a tiny module with no config or schema overhead.
