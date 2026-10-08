# How tourauto works

Tourauto has **no config UI, config schema, permissions, or plugins**. Enable it
(`drush en tourauto`) and it works on top of existing Tour config entities.

## Auto-open logic (`hook_page_bottom`)

On every page, `TourautoHooks::pageBottom()`:

1. Returns early unless the current user has tourauto enabled.
2. Loads tours matching the current route via `tourauto.manager` → `getCurrentTours()`
   (which itself checks the `access tour` permission and uses Tour's `tour.helper`).
3. Diffs available tour ids against the user's **seen** ids (`getSeenTours()`); if any are
   unseen, `should_open` is true.
4. Marks those tours seen (`markToursSeen()`) and attaches
   `drupalSettings.tourauto_open = <bool>` plus the `tourauto/tourauto` library so the JS
   pops the tour open. Cached per `user` context.
5. For users with `administer site configuration`, also attaches a
   `drupalSettings.tourauto_debug` payload (available/seen/new tour lists, route, counts).

## Per-user preference & seen state

Stored in **`user.data`** under module `tourauto`:

| Key | Meaning | Default |
|---|---|---|
| `tourauto_enable` | Whether auto-open is on for the user | `TRUE` (unset = on) |
| `tourauto_state` | JSON `{ "seen": { "<tour_id>": true } }` of seen tours | `{}` |

`TourautoHooks::formUserFormAlter()` adds two checkboxes to the **user edit form**:

- **Open tours automatically** → saved to `tourauto_enable`.
- **Clear status (mark all tours as unseen)** → calls `clearState()`, deleting
  `tourauto_state` so every tour auto-opens again.

Both operate on the account being edited (via `getManagerForAccount()`), so an admin editing
another user sets that user's preference.
