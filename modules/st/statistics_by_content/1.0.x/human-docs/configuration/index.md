# Configuration

There is a single, simple setting: the list of content types that should keep
being counted.

## Open the settings form

1. Log in as a user with the **Administer statistics** permission.
2. Go to **Configuration → System → Statistics → By content type**, or navigate
   directly to `/admin/config/system/statistics/by-content-type`.

## Choose which content types are tracked

The form is a list of checkboxes, one per content type. Tick the content types you
want core Statistics to keep counting; leave unticked the ones you want to stop
counting.

- **Ticked** — the core Statistics counter stays attached to those content types'
  full node pages, so their views are counted as usual.
- **Unticked** — the module strips the counter JavaScript from those pages, so no
  view count accrues and no counter AJAX request is made.

Click **Save configuration**. The change takes effect on the next page render.

## Good to know

- This only affects **full-page node views** — not teasers, not previews, not
  admin listings.
- The module does not delete or alter any counts that were already recorded; it
  only stops *new* counting on the content types you unticked.
- It pairs naturally with core Statistics' *popular content* block and with Views,
  giving you cleaner popularity data focused on the content that matters.
