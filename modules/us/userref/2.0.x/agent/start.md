<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# User Reference filter (userref) — agent index
**Text-format filter that converts @username mentions into links to user profiles.**

- **Version:** 2.0.x — core `^10`
- **Plugin:** `@Filter(id="userref")` `UserRef` (TYPE_TRANSFORM_IRREVERSIBLE)
- **Lookup:** exact `user_load_by_name()`, then relaxed parameterized `REGEXP_REPLACE` query on `users_field_data`
- **Security:** DB lookup uses a bound `:referencedName` parameter (no SQL injection); output via `Link::fromTextAndUrl` (escaped, no XSS); no routes/permissions/external calls.
