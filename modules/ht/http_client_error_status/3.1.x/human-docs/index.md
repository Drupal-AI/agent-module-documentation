# HTTP Client Error Status Block Condition — manual setup guide

**HTTP Client Error Status Block Condition** (`http_client_error_status`) adds a block
visibility condition called **"HTTP 40x Client error status code"**. It lets you show (or
hide) a block only on client-error pages — the 401 Unauthorized, 403 Access denied, and
404 Page not found screens. A typical use is putting a search box, a sitemap link, or a
"contact us" message on your 404 page, or a login prompt on your 403 page.

Because it is a standard Drupal *Condition* plugin, it works anywhere conditions are
consumed, but the everyday use is on blocks in Block layout and Layout Builder. It covers
**401**, which Drupal core's own `response_status` block condition does not.

As of the 3.1.x release the module also doubles as a **migration helper** toward core's
`response_status` condition. It provides a listing page that shows every block using this
condition (and flags any that already have both conditions), plus three Drush commands to
list, remove, or convert those conditions. Core's condition covers 403/404 (and 200), so
the migration moves 403/404 to core while keeping 401 on this module's condition.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module.

## How to use it

### Show a block only on error pages

1. Go to **Structure → Block layout** and place or edit a block.
2. Open the **"HTTP 40x Client errors"** section in the block's configuration.
3. Tick the pages the block should appear on — **401**, **403**, and/or **404**.
4. Optionally tick **Negate** to invert the rule (hide the block on those pages instead).
5. Save the block.

The choice is stored in the block's own configuration, so it exports with your config like
any other block setting.

### Audit and migrate to core's condition

- **Listing page** — visit **Configuration → Development → HTTP Client Error Status**
  (`/admin/config/development/http-client-error-status`), gated by the **Administer
  http_client_error_status configuration** permission. It tables every block using the
  condition, its 401/403/404/negate flags, and a "Potential Conflict" marker for any block
  that already carries both this condition and core's `response_status`.
- **Drush commands** (require Drush 12.5.2+ / 13):

  | Command | Aliases | What it does |
  |---------|---------|--------------|
  | `http_client_error_status:list` | `hces:list` | Print a table of every block using the condition. Read-only. |
  | `http_client_error_status:update` | `hces:update` | Convert each block's 403/404 settings to core's `response_status`, keeping 401 on this plugin. |
  | `http_client_error_status:remove` | `hces:remove` | Remove the condition from all blocks (the blocks themselves are kept). |

  A typical migration is `drush hces:list` to audit, then `drush hces:update`, then
  export and review the resulting config before deploying — the README advises running the
  conversion on a test copy rather than directly on production. Blocks flagged as a
  conflict are skipped by the conversion.

### Uninstalling

Uninstalling the module strips the condition from any blocks that use it, but leaves the
blocks in place.
