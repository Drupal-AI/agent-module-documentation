<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The revision-author tokens — definitions, values, sanitization, usage

Everything lives in `revision_author_tokens.tokens.inc` (the `.module` file is empty).

## Registration — `hook_token_info()`

`revision_author_tokens_token_info()` (`.tokens.inc:8`) adds three entries under the existing
`node` token group:

| Token | `name` | id (info key) |
|---|---|---|
| `[node:revision-author]` | "Revision Author" | `revision-author` |
| `[node:revision-author-uid]` | "Revision Author UID" | `revision-author-uid` |
| `[node:revision-author-mail]` | "Revision Author Email" | `revision-author-mail` |

These are flat tokens on the `node` group, **not** a chained user token — you cannot do
`[node:revision-author:mail]`; the module explicitly defines the three leaf tokens instead.
Runtime `\Drupal::token()->getInfo()['tokens']['node']` confirms exactly:
`revision-author`, `revision-author-mail`, `revision-author-uid`.

> The registered id is `revision-author-mail`. The README's `[node:revision-author-email]` does
> not exist — use `[node:revision-author-mail]`.

## Replacement — `hook_tokens()`

`revision_author_tokens_tokens()` (`.tokens.inc:32`) only acts when `$type == 'node'` and
`$data['node']` is non-empty. For each requested token it reads
`$data['node']->getRevisionUser()` and returns:

```php
$revision_author = $data['node']->getRevisionUser();          // account of the CURRENT revision
'revision-author'      => $revision_author ? $revision_author->getDisplayName() : '';   // :40
'revision-author-uid'  => $revision_author ? $revision_author->id()            : '';   // :45
'revision-author-mail' => $revision_author ? $revision_author->getEmail()      : '';   // :50
```

Exact semantics:

- **Source account** = the node's *revision* user (`getRevisionUser()`) — the person recorded as
  having created the loaded revision. This is the module's whole point: it is **not**
  `[node:author]` (node owner / `getOwner()`) and **not** the currently logged-in user.
- **`getDisplayName()`** returns the account's display name — the raw username by default, or
  whatever `hook_user_format_name_alter()` / a realname-style module produces.
- **`revision-author-uid`** is the numeric uid as a string; **`revision-author-mail`** is the raw
  email address.
- **No revision user** (`getRevisionUser()` is NULL) → every token resolves to `''` (empty
  string), never a fatal.
- The token fires against **whatever node/revision is in `$data['node']`** — normally the default
  (latest) revision. To resolve for a specific historical revision, pass that loaded revision
  object as the `node` data when calling the token service.

## Sanitization / escaping

The hook returns raw scalar strings and does **not** branch on `$options['sanitize']`. That is
safe and matches core's own approach: in Drupal 10/11 the central token service escapes plain-text
token values for you. `Token::replace()` (the markup path) wraps every non-`MarkupInterface`
replacement in `new HtmlEscapedText($value)` (`core/lib/Drupal/Core/Utility/Token.php:258`), and
`replacePlain()` renders to plain text — so a display name containing HTML is escaped at output.
Core's `UserTokensHooks::tokens()` likewise returns raw `getDisplayName()` / `getEmail()` without a
manual `Html::escape()`, for the same reason. There is no XSS gap introduced by this module.

What the module does **not** do that core token hooks usually do: it adds **no cacheable metadata**
to `$bubbleable_metadata` (it never records a dependency on the revision-author user entity). A
consumer that caches token output will not auto-invalidate if that user's name/email later changes.
This is a correctness/cache nuance, not a security issue.

## Where the tokens work

Because they are ordinary `node` tokens they resolve anywhere a node is supplied to the token
service:

- **Pathauto** URL-alias patterns for nodes (be careful — see privacy note below).
- **Metatag** field patterns (title/description) on nodes.
- **Mail** bodies / message templates that pass the node (core contact, Message, Simplenews, etc.).
- **ECA / Rules / Token Filter / Views** (Views token replacements, area/field rewrite) — anywhere
  a node token is accepted.

Resolve manually in code:

```php
$output = \Drupal::token()->replace('Last edited by [node:revision-author]', ['node' => $node]);
// or fetch a single value:
$name = \Drupal::token()->replace('[node:revision-author]', ['node' => $node], ['clear' => TRUE]);
```

## Privacy note

`[node:revision-author]` and `[node:revision-author-mail]` place a real person's identity (and, for
the latter, their email) wherever the token is rendered. Putting them into a **public** surface — a
URL alias, a meta description, an anonymously-viewable field — discloses who edited a page, and
potentially their email, to every reader. This is the same exposure core's `[user:mail]` /
`[node:author:mail]` carry: the tokens themselves apply no access check, so the trust boundary is
whoever configures the pattern. Keep them to internal notifications and admin-only displays unless
public disclosure is intended.
