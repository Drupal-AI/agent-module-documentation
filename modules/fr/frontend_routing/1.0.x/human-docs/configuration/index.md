# Configuration

Frontend Routes is configured by creating **keyed routes** — named mappings that
tie a front-end route to a Drupal node. There is no global "settings" form to tune;
the configuration *is* the list of route mappings you create.

## Open the configuration page

1. Log in as a user with permission to administer the module's routes (an
   administrator by default — the module provides its own permissions).
2. Go to **Configuration → Web services → Frontend Routing**, or navigate directly
   to `/admin/config/services/frontend-routing`.

## Add a keyed route

On that page, add a new keyed route. Each mapping has:

- A **key** — a stable identifier your front-end framework uses to look up the
  route (for example a name like `home`, `about`, or `blog-index`). Your front end
  references this key rather than a hard-coded node ID, so editors can repoint a
  route to different content without a front-end code change.
- An assigned **node** — the Drupal content whose data the front end should render
  for that route.

Save the route, and your decoupled front end can then resolve the key to the node
and pull the node's data.

## Managing routes from the front end instead

You do not have to create every mapping by hand. Your front-end framework can write
a `frontend_routing.settings.yml` file into the Drupal config directory, and those
mappings will be imported like any other configuration. This is convenient when the
front-end build is the source of truth for which routes exist.

## A note on access

The mapping tells a consumer which node answers a given path, so treat the mapping
API as a decoupled data surface: expose only route-to-node information for content
the consumer is entitled to see, and control access to the mapping the same way you
control access to the rest of your headless data.
