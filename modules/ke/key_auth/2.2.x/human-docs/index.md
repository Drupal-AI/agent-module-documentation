# Key Authentication — manual setup guide

**Key Authentication** (`key_auth`) lets API clients log in to your Drupal site as a
specific user by presenting a **per-user API key**, instead of a username/password
or a session cookie. It is a lightweight way to authenticate a mobile app, a
decoupled/headless frontend, or a machine-to-machine integration against your site's
REST or JSON:API endpoints.

Each Drupal user gets an `api_key` value. A client sends that key on every request —
as an HTTP header (for example `api-key: <key>`) or as a URL query parameter
(`?api-key=<key>`), whichever you allow. If the key matches an active user, and that
user's role has permission to use key authentication, the request is authenticated
as that user. Keys are random, unique per user, and easy to rotate or revoke: each
user has a **Key authentication** tab on their account where they can generate a new
key or delete the current one, complete with ready-made header and query examples to
copy.

A site-wide settings page controls the parameter name, the key length, whether keys
are auto-generated for new users, and which delivery methods (header, query, or
both) are accepted. A built-in safeguard ensures that any request carrying a key is
never served from Drupal's internal page cache, so authenticated responses are never
leaked to anonymous visitors. The module depends only on core's **User** module and
works on Drupal 9.5 through 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the site-wide settings, the permission
   that unlocks keys, and how users generate and send their key.

## Where it lives in the admin menu

- The site-wide settings form is at **Configuration → Web services → Key
  authentication** (`/admin/config/services/key-auth`).
- Each user's key is managed on their account, at
  **/user/{user}/key-auth**.
- The permission that makes keys work lives on **People → Permissions**
  (`/admin/people/permissions`).
