# Configuration

DFP has two parts to configure: **global settings** (applied to every ad) and
individual **ad tags** (one per ad slot). Both live under **Structure → DFP Ad
Tags** and require the **Administer DFP** permission.

## Global settings

Go to **Structure → DFP Ad Tags → Global settings**
(`/admin/structure/dfp/settings`). These are stored in the `dfp.settings` config
object.

- **Network ID** *(required)* — your Google network ID, prepended to every ad
  unit. It should begin with a `/`.
- **Ad unit pattern** — the default ad unit pattern used when a tag doesn't define
  its own. Tokens are allowed. It's validated against an allowed character set
  (letters, numbers, hyphens, dashes, periods, slashes, and tokens).
- **Click URL** — a click‑interception/reporting URL used in **sync** mode only.
  You cannot set this together with asynchronous rendering — the form will reject
  the combination.
- **Asynchronous rendering** *(default on)* — render ads asynchronously so they
  don't block the page; turn it off for synchronous rendering.
- **Disable initial load** — async‑only: skip the initial ad fetch so ads load only
  on a later `refresh()` (useful for gallery "next" behavior). Ignored when async
  is off.
- **Single request** *(default on)* — combine all ad requests into one to cut
  round‑trips.
- **Default slug** — the label shown above ads (for example "Advertisement"); set
  it to `<none>` for no label.
- **Collapse empty divs** — one of: never collapse, collapse only if empty, or
  expand if an ad is served — to control layout gaps.
- **Hide slug** *(default on)* — hide the slug label when no ad is served.
- **Targeting** — global key/value targeting pairs (for example `section=sports`)
  applied to every ad request.
- **Ad test ad unit pattern** — the ad unit pattern used for *every* slot when
  `?adtest=true` is on the URL, so you can preview campaigns.

## Ad tags

Each ad tag is a configuration entity describing one slot. Manage them at
**Structure → DFP Ad Tags** (add / edit / delete). A tag has:

- **Slot** — the human‑readable ad slot name (also the tag's label).
- **Size** — comma‑separated sizes, for example `300x600,300x250`; use `0x0` for an
  out‑of‑page slot.
- **Ad unit** — a per‑tag ad unit pattern (tokens allowed) that overrides the
  global default.
- **Slug** — a per‑tag slug override; `<none>` for none, or leave empty to use the
  global default.
- **Block** *(default on)* — expose this tag as a placeable Drupal block. Place it
  from **Structure → Block layout** like any other block.
- **Short tag** *(default off)* — render a JavaScript‑free image link instead of a
  GPT slot, for ads embedded in email.
- **Breakpoints** — responsive size mapping: pairs of a browser size and the ad
  sizes to use at that width.
- **Targeting** — per‑tag key/value targeting, merged with the global targeting.
- **AdSense backfill** — ad types, channel IDs, and colors used to fall back to
  AdSense when DFP inventory is empty.

## Placing an ad on the page

An ad only renders where its tag is present. The usual route is the tag's **block**:
leave the tag's *Block* option on, then add the tag's auto‑generated block to a
region in **Structure → Block layout**. When a page carries a DFP slot, the module
injects the GPT loader and the slot definitions into the page head automatically.

## Previewing campaigns (ad‑test mode)

- Append **`?adtest=true`** to any front‑end URL to route all slots through the
  **Ad test ad unit pattern**, so you can traffic a campaign to a preview without
  touching real inventory.
- There's also an admin **test page** at `/admin/structure/dfp/test_page`.

## Tokens and developer hooks

Ad unit patterns and targeting values run through the token system, so DFP's own
`[dfp_tag:slot]` and `[dfp_tag:network_id]` tokens work, as do core tokens like
`[current-page:url:args:value:0]`. Developers can adjust targeting and tags from
other modules via `hook_dfp_target_alter()`, `hook_dfp_global_targeting_alter()`,
`hook_dfp_short_tag_keyvals_alter()`, and `hook_dfp_tag_alter()`, and can override
the module's templates to change the emitted markup and scripts.
