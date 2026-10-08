<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Twitter Username (twitter_username) — agent index

**A field type for Twitter/X usernames, with a textfield widget and plain-text or profile-link formatters.**

- **Version:** 2.0.x  (info.yml `2.0.1`)
- **Core:** ^10 || ^11
- **Field type:** `twitter_username` — `varchar(15)`, `src/Plugin/Field/FieldType/TwitterUsername.php`
- **Widget:** `twitter_username_textfield` (`@` prefix, maxlength 15)
- **Formatters:** `twitter_username_default` (plain text), `twitter_username_link` (links to `https://x.com/@<name>`, optional `with_replies|media|likes`)
- **Permissions:** none (README)

**Security:** Pure Field API module — no routes, services, or permissions. Field configuration requires the core *administer node fields* / field-config permissions. Output is rendered through `#type => processed_text` with `plain_text` (Default formatter) and `Url::fromUri()` + `#type => link` (Link formatter), both of which escape the stored value, so there is no XSS surface from the username. Length is bounded to 15 by the schema/widget. No anonymous or mutating endpoints.
