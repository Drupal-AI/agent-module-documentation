<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring a request-data condition

There is **no central settings page**. You enable the module (`drush en request_data_conditions`)
and then configure each condition inline, in whatever UI consumes Drupal conditions:

- **Block visibility** — on a block's placement/config form, the four conditions appear alongside the
  core ones (Pages, Content types, Roles…): *Cookie values*, *HTTP headers*, *URL query parameters*,
  *Session values*. Stored under the block's `visibility` key.
- **Context** ([context module](https://www.drupal.org/project/context)) — add them as *Conditions*
  on a context. Stored under the context's `conditions` key. (The module contains a small workaround
  so the "Add another" AJAX button works on Context's condition-add route.)
- **Layout Builder section visibility**, Page Manager, or any custom consumer of
  `plugin.manager.condition`.

## The form (identical for all four)

Each condition renders a **table of rules** plus controls:

- **Name** — the cookie / header / query-parameter / session key to look up.
- **Operator** — one of: *must equal*, *must not equal*, *must be set*, *must be set and have any
  value*, *must be set and have no value*, *must not be set*, *matches regular expression*,
  *must contain*, *must not contain*. (See
  [plugins/request_data_conditions.md](../plugins/request_data_conditions.md) for exact semantics.)
- **Value** — the value to match. Disabled (not needed) for the *set / not set / empty / not empty*
  operators. For *matches regular expression*, enter the pattern **without** leading or trailing
  slashes (the module wraps it in `/…/` itself).
- **Add another** — AJAX button to add a further rule row (disabled until the current last Name is
  filled). Empty rows are discarded on save.
- **Require all** — checkbox, **default checked**. Checked = every rule must pass (AND); unchecked =
  any one rule passing is enough (OR).
- **Negate the condition** — the condition system's own standard checkbox; inverts the whole result.

## Behaviour to know

- A condition with **no rules** is a no-op — it evaluates TRUE (shows the block) unless you tick
  Negate. Add at least one rule for it to filter anything.
- Matching is **case-sensitive** for value comparisons and substring (`contains`) checks.
- Header and query values can be multi-valued; the operators handle arrays (e.g. *must equal* matches
  if the value is one of the array's items).
- Caching varies automatically per matched key (`cookies:NAME`, `headers:NAME`,
  `url.query_args:NAME`, `session`) — no extra configuration needed, but verify visibility under the
  anonymous page cache.

## Security reminder

These are **visibility** conditions. Cookies, headers and query parameters are set by the client, so
a visitor can trivially change what a condition sees. Use them for presentation/personalization only;
never as the gate on private data — enforce that with permissions or entity access.

## Drush / config

No dedicated config. The rules live inside the host entity's config (e.g.
`block.block.<id>.visibility.url_query_parameters`), so `drush config:get`/`config:set` on that host
entity is how you'd script it; there is no `request_data_conditions.settings` object and no config
schema of its own.
