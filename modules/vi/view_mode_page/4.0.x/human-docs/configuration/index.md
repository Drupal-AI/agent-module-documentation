# Configuration

Everything in View mode page revolves around **patterns**: each one maps a path
template to a view mode, optionally limited to certain content.

## Open the patterns list

1. Log in as a user with the **Administer view_mode_page** permission (an
   administrator by default).
2. Go to **Configuration → Search and metadata → View mode page**, or navigate
   directly to `/admin/config/search/view-mode-page`.

Here you can add a new pattern, and edit or delete existing ones.

## Add a pattern

Click **Add** and fill in the fields:

- **Label** — a human‑friendly name for the pattern (for example "Article
  summary").
- **Machine name** — the internal id, generated from the label.
- **Alias type** — which kind of entity path this pattern applies to. The module
  ships a "canonical entities" option derived for each entity type that has a
  canonical URL — for example one for nodes. Pick the one matching the entity you
  want to expose.
- **Pattern** — the path template. It **must contain a `%`**, which is the
  placeholder for the entity's normal URL or alias. For example, the pattern
  `/%/summary` maps `/my/great/page/summary` to the entity that lives at
  `/my/great/page`. Use whatever suffix you like — `/%/print`, `/%/card`, `/%/m`,
  and so on.
- **View mode** — the view mode used to render the entity at this path, such as
  **Teaser**, **Full**, or a custom mode like **Printable**. Only view modes that
  exist for the target entity type make sense here.

## Restrict which content a pattern applies to (optional)

- **Selection criteria** — optional conditions that limit the pattern. Using the
  CTools condition plugins you can restrict it to specific **bundles** (for
  example only Articles) and/or **languages**. Leave this empty to apply the
  pattern to any entity of that type that has a canonical URL.
- **Selection logic** — when you add more than one condition, this chooses whether
  **all** conditions must match (**and**, the default) or **any** of them
  (**or**).

## Ordering overlapping patterns

- **Weight** — when more than one pattern could match the same request, the weight
  decides which wins (lower weights are considered first). Give your more specific
  patterns a lighter weight so they take precedence over broader ones.

## How it behaves

When a visitor requests a path that matches a pattern, the module renders the
entity in the requested view mode **inline** — through an internal sub‑request,
not an HTTP redirect. That means the extra path is a genuine URL of its own (good
for SEO and for linking), and the visitor needs the normal **access content**
permission to view it, just like any other page.

## Save and deploy

Click **Save**. Patterns are stored as configuration entities, so you can export
them and deploy the same extra paths across environments. You can create as many
patterns as you need — for example `/%/summary`, `/%/print`, and `/%/card` all at
once.
