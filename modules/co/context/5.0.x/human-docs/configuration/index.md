# Configuration

Context is configured by building **contexts** — each one a set of conditions
plus reactions. The interface lives in the **Context UI** submodule at
**Structure → Context** (`/admin/structure/context`); make sure `context_ui` is
enabled (see [Installation](../installation/index.md)). You need the **Administer
contexts** permission.

## Create a context

1. Go to **Structure → Context** and click to add a context.
2. Give it a **label** (and optionally a **group** to organize related contexts
   and a **description**).
3. Add conditions and reactions (below), then save.

Contexts can be grouped, ordered by **weight** for predictable evaluation,
**duplicated** as a starting point for a new one, and **disabled** temporarily
without deleting them. Because each context is a config entity, it exports and
deploys with the rest of your configuration.

## Conditions — when the context is active

Conditions decide whether a context matches the current request. Context **reuses
Drupal core's standard Condition plugins**, so any core or contrib condition is
available, including:

- **Request path** — match a path or wildcard pattern (for example `/products/*`).
- **User role** — target authenticated users, a specific role, and so on.
- **Content type** — match a node type.
- **Language** — match the current language.

Context also provides a few conditions of its own:

- **Request domain** — match by domain.
- **HTTP status code** — fire on 403 / 404 pages.
- **Request path exclusion** — exclude specific paths from an otherwise sitewide
  context.
- **User status** — fire only on a user's own profile page.
- **View inclusion** — activate when a particular View is rendered.
- **Context (any) / Context (all)** — chain contexts together based on other
  active contexts.

### All vs any

Each context has a toggle for how its conditions combine:

- **Require all conditions (AND)** — every condition must match. Use this to
  narrowly target a page.
- **Any condition (OR)** — the context is active if any single condition matches.
  Use this for broader matching.

Leaving a context with **no conditions** makes it **sitewide** — it is always
active.

## Reactions — what happens when it matches

Reactions are the actions Context performs when a context's conditions pass. Add
one or more:

- **Blocks** — the flagship reaction. Place blocks into theme regions with
  per‑context visibility — a centralized alternative to core Block layout. You can
  choose whether to also include the default Block‑layout blocks.
- **Theme** — switch the active theme for the matched pages / section.
- **Body class** — add one or more CSS classes to the `<body>` tag so your theme
  can style those pages.
- **Page title** — override the page title.
- **Page template suggestions** — add extra Twig template suggestions so you can
  build a custom page template for the section.
- **Menu** — set the active menu trail / breadcrumb for pages that aren't
  naturally in the menu.
- **Regions** — disable or unset theme regions on the matched pages.

## Save

Save the context. On every request Context evaluates each context and applies the
reactions of those whose conditions pass. Developers can add new behaviors by
writing a custom `ContextReaction` plugin — see the [`agent/`](../agent/start.md)
docs for that API.
