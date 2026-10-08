<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Add the "Random seed" sort to a view

There is no admin settings page — you add the sort inside the Views UI (or in the view's
config).

## Via the Views UI

1. Edit your view (`/admin/structure/views/view/<view>`).
2. In **Sort criteria** click **Add**.
3. Search for **Random seed** (category *Global*, from the `views` table) and add it.
4. Configure the options (below). The normal ASC/DESC order control is hidden — order is
   random.

## Options

| Option | Values (default) | Effect |
|---|---|---|
| `user_seed_type` | `same_per_user` (default) / `diff_per_user` | Same random order for everyone, or a different order per user. |
| `anonymous_session` | bool (FALSE) | Only with `diff_per_user`: start a session for anonymous users so each gets its own order (costs performance; otherwise anonymous users share one order). |
| `reset_seed_int` | `-1` never, `0` custom, `3600` hourly, `28800` 8-hourly, `86400` daily (default `3600`) | How often the seed regenerates (reshuffle). |
| `reset_seed_custom` | integer seconds (300) | Used when `reset_seed_int` is `0` (Custom). |
| `reuse_seed` | `''` or `<viewid>-<displayid>` | Reuse another view display's seed so two listings shuffle identically. |

## In view config (scriptable)

The sort is a handler on the display; the key fields are `id`, `table: views`,
`field: random_seed`, `plugin_id: views_random_seed_random`, plus the options above:

```yaml
display:
  default:
    display_options:
      sorts:
        random_seed:
          id: random_seed
          table: views
          field: random_seed
          plugin_id: views_random_seed_random
          user_seed_type: same_per_user
          anonymous_session: false
          reset_seed_int: 86400        # reshuffle daily
          reset_seed_custom: 300
          reuse_seed: ''
```

Read it back:

```bash
drush cget views.view.<view> display.default.display_options.sorts
```

## Caching note

For a cached view, use **time-based** caching aligned with `reset_seed_int` — otherwise the
cached page can outlive the seed (or vice-versa). When the seed regenerates, the module
invalidates the cache tag `views_random_seed-<view>-<display>`.
