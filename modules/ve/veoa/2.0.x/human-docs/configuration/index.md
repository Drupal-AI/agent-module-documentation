# Configuration

There is no admin settings page — you configure VEOA inside a view.

## Set it up

1. Edit a view **page** display whose path contains an entity argument — for
   example `node/%node/related` or `user/%user/activity`.
2. In the display's **Access** section, choose **Entity Operation**.
3. Set the three options:

| Option | Example | Meaning |
|---|---|---|
| **Parameter** | `node` | The name of the path argument that holds the entity — the `%node` in `node/%node/related`. (Entered without the `%`.) |
| **Entity type** | `node` | The entity type that parameter resolves to, chosen from your site's entity types. |
| **Operation** | `update` | The operation to check — `view`, `update`, `create`, `delete`, or any custom operation. |

4. Save the view.

The configuration is stored on the view under the
`veoa_entity_access_operation` access plugin.

## What happens when you save

Unlike most access plugins, VEOA doesn't check access "live" — it does its work
at save time. When you save the view it:

- **Up‑casts the path parameter** into a full entity object (so the view and
  Drupal both get the real entity, not just an ID), and
- **Adds a core `_entity_access` route requirement** of the form
  `<entity_type>.<operation>` to the view's path.

From then on Drupal's routing/access system enforces that requirement on every
request to the view page, applying the entity's own access handlers and any
`hook_entity_access` logic — exactly as it would for the entity's canonical page.

## Gotchas

- **The parameter must actually appear in the display's path.** If it isn't in
  the path, there is nothing for the up‑cast and requirement to bind to, and the
  check won't resolve as intended.
- **Re‑save after changing options.** Because the enforcement is a route
  requirement wired at save time, re‑save the view whenever you change any of the
  three options so the route is rebuilt.
- **It only tightens access.** VEOA adds a constraint; it can't grant permissions
  or loosen core's own access on the route.
