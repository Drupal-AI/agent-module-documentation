<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Ray Enterprise Translation (lingotek) — agent index

Translation management integration (formerly Lingotek): content, config and interface strings to
and from the Ray Enterprise TMS. Configure at `/admin/lingotek`. Version **11.0.4**.
Core **`^11`**. Depends on `locale`, `language`, `content_translation`, `config_translation`.

Permissions: `administer lingotek` (**`restrict access: TRUE`**),
`assign lingotek translation profiles`, `manage lingotek translations`. Admin routes use the
`administer lingotek+manage lingotek translations` (OR) form.

Callback: `/lingotek/notify`, `_custom_access:
\Drupal\lingotek\Access\LingotekNotifyAccessCheck::access`.

**Cite this access check as a good example.** `hash_equals()` on the username,
`password_verify()` against a bcrypt hash (plaintext lives only at the vendor),
`AccessResult::forbidden()` when either stored value is empty, `setCacheMaxAge(0)` throughout.

**One defect to fix before production — verified.** Both rejection paths log
`formatRequestHeaders()`, which is `json_encode($request->headers->all())` with no filtering. A
request with wrong credentials wrote to `watchdog`:

```
"authorization":["Basic bGluZ290ZWtfc3ZjOlMzY3JldC1TaDRyZWQtVG9rZW4="],
"php-auth-pw":["S3cret-Sh4red-Token"]
```

— the password **in plain text**. Those paths fire when a *legitimate* callback stops
authenticating, so it is the real shared secret that lands in the log, visible to `access site
reports` and to every downstream log consumer. Redact `authorization`, `php-auth-pw`, `cookie`
and `proxy-authorization` before encoding.

Also observed: a rejected callback returned **500**, not 403.