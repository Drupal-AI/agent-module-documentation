<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Wayback Filter

## Settings form — `/admin/config/content/wayback_filter` (perm `administer site configuration`)
Writes `wayback_filter.settings`:
- **waybacklink_mode** — `append` (add an icon link after the original, recommended) or `replace` (rewrite the original link's href to the Wayback URL, keeping link text).
- **waybacklink_icon** — emoji/character/text used as the link label (default 🏛️).
- **waybacklink_title** — hover title on the Wayback link.
- **waybacklink_start** — nodes older than this many years get Wayback links (`0` = all nodes; default 3).
- **field_link** — (experimental) newline-separated link-field machine names to process in `hook_preprocess_node`.

## Enable on a text format
`/admin/config/content/formats` → edit a format → enable **Wayback Filter** → place it **near the end** of the *Filter processing order* → save. Only nodes viewed in `full` view mode that are old enough get links.

## How it works
On full node view the filter reads the node `created` date, and for nodes older than the threshold it scans the body for `<a href>` links, skips `web.archive.org` links, and for `http(s)` links builds `https://web.archive.org/web/<YmdHis>/<url>` (timestamp from the node's creation date), then appends or replaces per mode.

## Security notes
- No server-side fetch (no SSRF); only URL string construction.
- `nid` is a bound query parameter, not concatenated SQL.
- Icon/title are admin-controlled config; href is captured by a quote-free regex. Keep the filter late in the pipeline so upstream sanitization runs first.
