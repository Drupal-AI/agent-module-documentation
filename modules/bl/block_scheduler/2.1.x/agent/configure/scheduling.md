<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure: schedule a block with the Expiry condition

The module adds one core `Condition` plugin, `expiry`, to the Visibility section of every block.
No global settings, no route, no permission — you configure per block.

## Where

- Classic block layout: `/admin/structure/block` → a block's **Configure** → **Visibility** →
  **Expiry** vertical tab.
- Layout Builder: the block's configuration form (visibility conditions section) exposes the same
  **Expiry** condition.

Two fields (`#type => 'datetime'`):

- **Publish Date** → stored config key `start`
- **Expiry Date** → stored config key `end`

Both optional. Values are captured as `DrupalDateTime` and persisted as **Unix timestamps**
(`->getTimestamp()`); a blank field is stored as `''`.

## Storage shape

State lives in the host block entity's visibility configuration (no separate config entity, no
module config schema). Example fragment of a block's config:

```yaml
visibility:
  expiry:
    id: expiry
    negate: false
    context_mapping: {  }
    start: 1767225600   # Publish Date (epoch seconds) or '' if unset
    end: 1767830400     # Expiry Date  (epoch seconds) or '' if unset
```

## Visibility logic

`Expiry::evaluate()`:

- Both `start` and `end` empty and not negated ⇒ returns `TRUE` (block always shows; the condition
  is a no-op).
- If `start` set: visible requires `time() >= start`.
- If `end` set: visible requires `time() <= end`.
- Combined with AND, so a block with both set shows only inside `[start, end]`.

A second, independent layer runs in `hook_block_access()` (`BlockSchedulerHooks::blockAccess`): for
the `view` operation it reads the block's stored `expiry` config and returns
`AccessResult::forbiddenIf(...)` when `time() < start` or `time() >= end`. Note `end` is treated as
**exclusive** here versus **inclusive** in `evaluate()`, but the practical result is identical —
the block is hidden before the publish date and once the expiry date is reached. This access result
adds a cacheable dependency on the block.

## Validation

`validateConfigurationForm()` only fires when **both** dates are provided (and are objects, not
arrays). It then requires `end > start`, else sets the error:
"Please select expiry date greater than publish date." Supplying only one date bypasses this check.

## Caching (why no cron is needed)

`Expiry::getCacheMaxAge()` returns the number of seconds until the next relevant boundary:

- If `start` is in the future ⇒ max-age = `start - now`.
- Else if `end` is in the future ⇒ max-age = `end - now`.
- Otherwise `Cache::PERMANENT`.

Merged with the parent max-age, this lets render/page caches expire exactly when a scheduled block
should appear or disappear. There is no `hook_cron`; scheduling is enforced at request time via the
condition/access evaluation plus this cache max-age.

## Notes

- Timezone: comparisons use server `time()` / request time; the datetime widget uses the site/user
  timezone for entry.
- `summary()` returns the literal string "Expiry" (no date detail in the visibility summary line).
- Applies to any block plugin (content blocks, views blocks, system blocks) since it is a generic
  visibility condition.
