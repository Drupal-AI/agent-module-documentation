<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the "Global: Current path" field

Add it in the view's **Add fields** dialog under **Global: Current path** (id `current_path`).
It has no query and can be used in any display; combine with a rewrite to build links.

## Options (stored in the field handler, schema `views.field.views_current_path`)

| Option | Type | Default | Meaning |
|---|---|---|---|
| `path_format` | radios | `raw-internal` | Output style (see below). |
| `query_string_support` | radios | `bypass-query-string` | Only for `alias-relative`; how to treat the existing query string. |
| `query_params_filter` | textarea → list | `[]` | Only for `query-only`; allow-list of parameters to keep, one per line. Append `=` to a name to keep it only when it has a value. |
| `query_params_renaming` | textarea → list | `[]` | Only for `query-only`; `original\|new` per line. |
| `query_params_trim` | checkbox | `false` | Trim trailing spaces from query values. |
| `query_params_lower` | checkbox | `false` | Lower-case query values. |
| `cache_user` | checkbox | `false` | Add the `user` cache context (rebuild per user). |

### `path_format` values
- `raw-internal` — internal system path, e.g. `node/215` (from `path.current`).
- `raw-relative` — `base_path` + internal path.
- `raw-absolute` — `base_url` + relative path.
- `alias-internal` — `Request::getRequestUri()` (the aliased request URI).
- `alias-relative` — request URI, then processed per `query_string_support`.
- `alias-absolute` — `Url::fromUri('internal:' . path, ['absolute' => TRUE])`.
- `query-only` — the query string only (parsed from `$_SERVER['QUERY_STRING']`, `q` dropped),
  after applying the filter/rename/trim/lower options; built with `UrlHelper::buildQuery()`.

### `query_string_support` (alias-relative only)
- `bypass-query-string` — leave the URI unchanged.
- `remove-query-string` — cut everything from `?`.
- `replace-query-string` — keep path plus a trailing `?` (so a rewrite can append params).
- `concat-query-string` — append `&` if a query already exists, else `?`.

## Using it in a rewrite
The field value is available as the token `[current_path]` (or `[<field id>]`) in other
fields' **Rewrite results**. For query-string concatenation do **not** put a literal `?` in
the rewrite — write `[current_path]tid=[tid]`; the module inserts the `?`/`&` itself.

## Caching
`render()` always adds `url.query_args` cache context (or `url.query_args:<param>` per kept
param in `query-only` mode); `cache_user` additionally adds the `user` context. No custom
access — visibility follows the view's own access. In view preview the field renders a
placeholder string (`PreviewFallbackInterface`).
