<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity View Redirect — configuration & mechanism

Source: `entity_view_redirect.module`, `src/EventSubscriber/EventSubscriber.php`,
`config/schema/entity_view_redirect.schema.yml`, `entity_view_redirect.permissions.yml`,
`entity_view_redirect.services.yml`.

## Install / enable

```
composer require drupal/entity_view_redirect
drush en entity_view_redirect -y
```

No dependencies beyond core node/taxonomy/user. Nothing is redirected until you enable a toggle on a
bundle or on the user form (below). Grant `bypass entity view redirect` to any role that must still
reach the real view page.

## Where you configure it

There is **no dedicated admin page** (`configure` route is null). Settings live on existing forms via
`hook_form_*_alter` in `entity_view_redirect.module`:

- **Node type** — `entity_view_redirect_form_node_type_form_alter()` adds a "Node View Page Redirect"
  details group to each content type's edit form (`/admin/structure/types/manage/<type>`). Fields:
  *Enable redirect to Node view page* (`node_view_redirect`), *Redirect to custom path…*
  (`custom_path`, UI-only), *Redirect path* (`node_redirect_path`). Saved as **third-party settings**
  on the `node_type` config entity by the entity builder
  `entity_view_redirect_form_node_type_submit()`; when *custom path* is unchecked, `node_redirect_path`
  is stored as FALSE (falls back to the edit form).
- **Taxonomy vocabulary** — `entity_view_redirect_form_taxonomy_vocabulary_form_alter()` adds the same
  three fields to the vocabulary form (`/admin/structure/taxonomy/manage/<vocab>`), stored as
  third-party settings `vocabulary_view_redirect` / `vocabulary_redirect_path` by
  `entity_view_redirect_form_taxonomy_vocabulary_submit()`.
- **User** — `entity_view_redirect_form_user_admin_settings_alter()` adds a "User View page Redirect"
  group to Account settings (`/admin/config/people/accounts`). Its submit handler
  `entity_view_redirect_form_user_settings_submit()` writes to the **config object**
  `entity_view_redirect.settings` (`user_view_redirect`, `user_redirect_path`). This is global — user
  redirect is not per-bundle.

The "Redirect path" help text: *"Enter a valid absolute path. Use % as token of current
User ID / Taxonomy ID. Ex: /homepage (or) /node/%/analytics"*. Reaching a path field requires ticking
*Redirect to custom path*; otherwise the destination is the entity's edit form.

## Config object & schema

`entity_view_redirect.settings` (schema `config/schema/entity_view_redirect.schema.yml`):

- `user_view_redirect` — boolean, redirect the user canonical page.
- `user_redirect_path` — text, internal path (may contain `%`); FALSE/empty → user edit form.

Node and vocabulary settings are **not** in this object — they are third-party settings on each
`node_type` / `taxonomy_vocabulary` config entity (keys `node_view_redirect`, `node_redirect_path`,
`vocabulary_view_redirect`, `vocabulary_redirect_path`).

Example (user redirect to a custom path):

```yaml
# entity_view_redirect.settings.yml
user_view_redirect: true
user_redirect_path: '/user/%/address-book'
```

## Runtime behavior (`EventSubscriber::redirectToEditPage`)

1. Subscribed to `KernelEvents::REQUEST` (default priority) — runs after core routing/access.
2. If the current user has permission `bypass entity view redirect`, return (no redirect).
3. Match route: `entity.node.canonical` / `entity.taxonomy_term.canonical` / `entity.user.canonical`.
4. Load the relevant redirect flag + path (bundle third-party settings for node/term; config object
   for user). If the flag is off, do nothing.
5. If a custom path is set: replace `%` with the entity ID (`$node->id()` / `$term->id()` /
   `$user->id()`) and build the target with `Url::fromUri('internal:' . $custom_path)->setAbsolute()`.
   The `internal:` scheme means the path must be a site-internal path (leading `/`, `#`, or `?`);
   a bare external URL is rejected by core rather than redirected to.
6. Otherwise build the entity's `*.edit_form` URL (`entity.node.edit_form` /
   `entity.taxonomy_term.edit_form` / `entity.user.edit_form`).
7. `$event->setResponse(new RedirectResponse($url))` — a 302 to the target.

Notes:

- The default (no custom path) sends users to the **edit form**; a viewer without edit access will get
  the edit form's own access denial. Set a custom path if plain viewers should land somewhere else.
- The subscriber uses `$this->configFactory->getEditable('entity_view_redirect.settings')` for the
  user case even though it only reads it (an immutable `get()` would suffice) — behaviorally harmless.
- To restore the normal view pages, untick the toggles (or disable the module) and clear caches.

## Permission

`bypass entity view redirect` (`entity_view_redirect.permissions.yml`) — holders skip all redirects
and see the normal canonical view page. Grant it to admins/reviewers who need the default view.
