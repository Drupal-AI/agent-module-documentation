<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — set it up in a View

No admin settings page. Configure entirely on the view's contextual filter.

## Steps
1. Add a **contextual filter** (argument) for the entity id, e.g. *Content: ID* for nodes.
2. Under **When the filter value is NOT available** → select **Provide default value**.
3. For default value type choose **Previously rendered entities**
   (plugin `views_exclude_default_render_history`).
4. Choose **Do not use a relationship** to check against the current page's entity (or a relationship to check
   a related entity).
5. Set **Entity type** to the type to track — typically **Content** for nodes. (Required; options are all
   entity type labels.)
6. **Crucial, easily missed:** scroll to the bottom of the contextual filter settings, expand **More**, and
   tick the **Exclude** checkbox. Without this the argument *includes* rather than *excludes* the ids.

## How it behaves
- The plugin's `getArgument()` returns the `+`-joined ids of entities already rendered on the page for the
  chosen entity type; with **Exclude** on, Views subtracts them.
- When nothing has been rendered yet, it returns the literal `all`, which acts as a no-op (view is unfiltered).
- Config stored on the argument: `entity_type_id` (default `''`). No module-level config object.

## Gotchas
- The order of blocks/views on the page matters: only entities rendered **before** this view are excluded.
- Tracking uses `hook_entity_build_defaults_alter()`, so entities served from render cache are still counted.
