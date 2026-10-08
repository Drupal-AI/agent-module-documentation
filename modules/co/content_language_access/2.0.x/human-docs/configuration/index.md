# Configuration

Remember: once the module is enabled, it **already denies** access to published
nodes whose language doesn't match the negotiated language. Everything on the
settings form serves to *allow* exceptions — it never tightens the rule.

## Prerequisite: language detection

Before the module behaves as you expect, configure how Drupal decides the current
language, at **Configuration → Regional and language → Languages → Detection and
selection**. For per‑language sites this is usually **URL** (prefix) or **domain**
negotiation. The access check compares each node's language against this
negotiated language.

## Open the settings form

1. Log in as a user with the **Administer content_language_access settings**
   permission.
2. Go to **Configuration → Regional and language → Content language access**, or
   navigate directly to `/admin/config/regional/content_language_access`.

Settings are stored in `content_language_access.settings`.

## The cross‑language allow matrix

The form shows a group for each enabled language, each containing a checkbox for
every *other* language. The meaning is:

> Checking **English → Portuguese** means: when the site's negotiated language is
> **English**, a **Portuguese** node is still allowed to be viewed.

By default nothing is checked, so any mismatch is denied. Tick the specific
pairings you want to permit — for example, allow English content to be seen from
the German site as a fallback. The same‑language checkbox is always on and cannot
be unchecked (a node always shows in its own language).

## Bypass options

- **Bypass language access validation** (`access_bypass`) — a master switch that
  enables the route bypass below. Leave it off if you don't need route
  exceptions.
- **Routes to be bypassed** (`route_list`) — a text area, one route machine name
  per line. Requests on these routes skip the language check (only takes effect
  when the master switch above is on). When the bypass is active, operations
  running under the **CLI** (such as Drush) are also exempt, so background
  processing isn't blocked.

The module also automatically stays out of the way while a **translation is being
added**, so editors are never blocked from translating content.

## Role bypass

Separately from this form, the **Bypass content_language_access** permission
exempts a role from the check entirely — that user can view published nodes in
any language regardless of the negotiated language or the matrix. Because it turns
the feature off for that role, grant it narrowly. Anonymous visitors normally hold
neither permission, so the mismatch rule applies to them as intended.

## Good to know

- The check restricts **viewing published nodes** only. Unpublished nodes, and
  edit/delete operations, are never language‑restricted by this module.
- A denial is a hard 403 that overrides other modules' "allowed" decisions on the
  canonical node page. The module can only *remove* view access, never grant it.
- It does **not** filter node listings, search, or views/query access — only the
  direct node page. Pair it with other access controls if you need list‑level
  filtering.

## Save

Click **Save configuration**. Changes take effect on the next request.
