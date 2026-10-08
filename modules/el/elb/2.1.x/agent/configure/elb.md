<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring External Link Blocklist

## Enable validation on a field
1. Create/edit a **Link** field.
2. In **Manage form display**, select the **External link blocklist** widget for that field.
3. (Optional) The widget settings expose `size` and `placeholder`.

## Edit the blocklist
Go to `/admin/config/content/elb` (permission: `access the external links blocklist page`):
- **Blocklist** — comma-separated patterns, e.g. `dev.example.com, staging.example.net`.
- **Exceptions** — comma-separated patterns that override the blocklist, e.g. allow `good.example.com` while `example.com` is blocked.

Both are stored as single strings in `elb.settings` and split on commas (values trimmed, empties dropped).

## How matching works (`BlocklistService`)
- `isBlocklisted($uri)` → TRUE if `$uri` **contains** any blocklist pattern (`substr_count`) and contains no exception pattern.
- This is plain substring matching, so a pattern matches anywhere in the URL. Choose patterns accordingly.

## Linkit integration
If Linkit is used, `elb_form_linkit_editor_dialog_form_alter()` adds `elb_linkit_href_validate` to the dialog's `href` element, so blocklisted links are rejected in the CKEditor link dialog too.

## Upgrade caution
`elb_update_8004` grants `access the external links blocklist page` to every role that has `access administration pages`. After running updates, verify only intended roles can reach `/admin/config/content/elb`.
