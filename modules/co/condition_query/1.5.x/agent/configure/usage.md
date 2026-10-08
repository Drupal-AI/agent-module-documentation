# Using the "Request Param" condition

There is no admin form of its own. The condition appears anywhere Drupal's Condition API is
exposed — most commonly **block visibility**.

## Configure on a block

1. Structure → Block layout → configure a block (or place one).
2. Under **Visibility**, open the **Request Param** tab.
3. In **Query Parameters**, enter one parameter per line:
   ```
   visibility=show
   app=true
   ```
   Array parameters use bracket syntax: `visibility[]=show`.
4. Optionally check **Negate the condition** to invert (show when the parameter is *absent*).
5. Save.

## Evaluation semantics (`RequestParam::evaluate`)

- Config is lowercased (`mb_strtolower`), so matching is case-insensitive on both key and value.
- Newlines are converted to `&` and parsed with `parse_str()` into expected key⇒value(s).
- For each configured key, the current request's value (`$request->get($key)`) is compared;
  the condition returns **TRUE on the first match** (any-of, not all-of).
- **Empty config ⇒ returns TRUE** (no restriction).
- `getCacheContexts()` adds `url.query_args`, so rendered output varies correctly per query
  string (no stale cache across different parameters).

## Notes

- Matches exact `key=value`; there is no partial/substring or numeric-range matching.
- Works with array query params (`?visibility[]=show`) — a match on any array element passes.
- Because it's a standard condition plugin, the same config also works in Rules, Page Manager,
  and other condition consumers.
