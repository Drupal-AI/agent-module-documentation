# Configuration

All of Navigation Extra's features are switched on and tuned from one settings page, where
each feature appears as its own vertical tab.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → User interface → Navigation → Extra**, or navigate directly to
   `/admin/config/user-interface/navigation/extra`.

Each feature tab has an **Enabled** checkbox and a **Weight** (which controls the order its
section appears in the sidebar); a feature's options stay hidden until you tick its Enabled
box. Turn on only the sections you actually want in the navigation.

## The features (tabs)

- **Common** — always-on baseline options that affect the whole navigation: group collections
  at the top or bottom, hide empty collections, hide the core "Add content" link, generate
  overview links so a parent with children stays clickable, and **override the core 3-level
  menu-depth cap** for deeper trees.

- **Content** — add content links to the sidebar: a list of **recent items** (with a
  configurable limit and link target), and **"create new content"** links, optionally grouped
  into a create menu with collections.

- **Media** — add a Media section; optionally link it to the **Media Library** and group its
  create links.

- **Taxonomies** — add taxonomy links, grouped into collections, with optional create links.

- **Users** — add a Users section: show **role** items (and hide selected roles), a **people**
  link, and an **add-new-user** link.

- **Files** — add a Files link, or show files under the Media section; optionally hide core's
  files link.

- **Blocks** — control which blocks are offered, hide the core blocks link, and manage the
  list of "navigation-safe" blocks used in Layout Builder.

- **Forms** — add **webform** links (optionally linking to webform results) and **contact
  form** links.

- **Local Tasks** — add entity local tasks (the tabs like *View / Edit / Delete*) into the
  navigation.

- **Tools** — add Navigation Extra's own tools links and, if you run Devel, Devel's — each
  positionable and optionally grouped under a Tools/Development collection.

- **Version** — show a version/environment indicator. Choose the **source** of the version
  string (a provider, module, file, environment variable, or a pattern/format), what to
  **output** (title, description, URL, update checks), and define **environments** (name,
  colour, background) so dev/staging/production are colour-coded.

## Save

Click **Save configuration**. Reload any admin page to see the new sections appear in the
left navigation sidebar.

## The blocks

Three blocks ship with the module and are placed like any other block, via **Structure →
Block layout** or Layout Builder:

- **Navigation Extra Local Tasks** — renders entity tabs inside the navigation sidebar.
- **Navigation Extra Version** — renders the configured version/environment indicator.
- **Navigation Menu Block Override** — overrides/augments core's navigation menu block.

## Going further

A custom module can declare its own hierarchical navigation collections via
`hook_navigation_extra_collections()`, and you can add a whole new feature tab by writing a
`NavigationExtraPlugin`. Both are developer-facing — see the [`agent/`](../../agent/start.md)
docs (`hooks/hooks.md` and `plugins/plugins.md`) for the details.
