# Configuration

Rabbit Hole has **no central admin form**. You configure it on the edit forms of
the entity types whose submodule you enabled (see
[Installation](../installation/index.md)), using a vertical tab named **Rabbit
Hole settings**. Which forms show the tab depends on which submodules are on:
`rh_node` puts it on content types and nodes, `rh_media` on media types and
media items, and so on.

## Grant the permissions first

Rabbit Hole generates **two permissions per supported entity type**, so you only
see the ones for the entity types you enabled. Set them at **People →
Permissions** (`/admin/people/permissions`):

- **`rabbit hole administer <entity_type>`** — lets a role see and edit the
  Rabbit Hole settings tab on that entity type's forms (change the action, the
  redirect, the override). Example machine names: `rabbit hole administer node`,
  `rabbit hole administer media`.
- **`rabbit hole bypass <entity_type>`** — lets a role **skip** the configured
  behavior and always view the real canonical page for that entity type. Example:
  `rabbit hole bypass node`. Grant this to trusted roles (such as editors or
  administrators) so they can still reach pages that visitors are redirected or
  blocked from.

You can also grant them from Drush, for example:

```bash
drush role:perm:add editor 'rabbit hole administer node'
```

## Set a behavior on a bundle

This is the usual starting point — a default that applies to every entity of a
bundle.

1. Edit the bundle. For nodes, go to **Structure → Content types → *your type* →
   Edit**; for other entity types, open the equivalent bundle settings form.
2. Open the **Rabbit Hole settings** vertical tab.
3. Choose the **Behavior** (the `action`), one of:
   - **Display the page** (`display_page`) — the normal Drupal behavior; the
     canonical page renders as usual.
   - **Access denied** (`access_denied`) — return a 403.
   - **Page not found** (`page_not_found`) — return a 404. Often preferable to
     403 because it does not reveal that the content exists.
   - **Page redirect** (`page_redirect`) — send visitors somewhere else (see the
     redirect fields below).
4. Decide whether to tick **Allow this behavior to be overridden for individual
   entities** (`allow_override`). When on, each entity's own edit form exposes
   the same settings so a single node can differ from this bundle default. When
   off, the bundle default is fixed for every entity.
5. Save the form.

## Redirect settings

These fields appear (and matter) when the behavior is **Page redirect**:

- **Redirect target** (`redirect`) — the path or full URL to send visitors to.
  It supports **tokens**, so you can point at a field value, for example
  `[node:field_external_url]`, or use `<front>` for the front page.
- **Response code** (`redirect_code`) — the HTTP status to send: **301**
  (permanent, best for SEO consolidation of retired pages), **302** (temporary,
  good for campaigns or A/B tests), or **303/304/305/307** for less common
  cases.
- **Fallback behavior** (`redirect_fallback_action`) — what to do when the
  redirect target turns out to be empty or invalid (for example a token that
  resolves to nothing). Pick one of the other actions (typically *Access denied*
  or *Page not found*) so visitors get a sensible response instead of an error.

## Override on a single entity

If the bundle has **Allow override** enabled, open any individual entity's edit
form (for example a single node) and you'll find the same **Rabbit Hole
settings** tab. Set a different action or redirect there to override the bundle
default for just that one entity — useful for one high‑value page that should
behave differently from the rest of its type.

## Where the settings are stored

Behind the scenes each configuration is saved as a `BehaviorSettings` config
entity (`rabbit_hole.behavior_settings.*`), so your Rabbit Hole setup exports and
deploys with the rest of your site configuration. The install ships two defaults,
`rabbit_hole.behavior_settings.default` and `.default_bundle`. Developers can
read and write these programmatically through the
`rabbit_hole.behavior_settings_manager` service — see the sibling
[`agent/`](../agent/start.md) docs.
