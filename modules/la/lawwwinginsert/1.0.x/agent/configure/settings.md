<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Lawwwing

Route `lawwwings.settings` → `/admin/config/lawwwing` (permission `administer lawwwing settings`). Form `LawwwingSettingsForm` writes `lawwwing.settings`:

- **`script_id`** (textfield) — your Lawwwing widget ID. When empty, nothing is injected.
- **`active_in_admin`** (checkbox) — include the script on admin routes (off by default; `AdminContext::isAdminRoute()` gates it).
- **`allowed_roles`** (checkboxes) — inject only for users holding one of the selected roles. To show the banner to anonymous visitors, select the *anonymous* role.

## Injection logic (`Hooks::insertScript`, `hook_page_attachments`)
1. Read `script_id`; add cache tag `config:lawwwing.settings`; bail if empty.
2. If on an admin route and `active_in_admin` is false → bail.
3. If the current user shares no role with `allowed_roles` → bail.
4. Otherwise attach the `<script src="https://cdn.lawwwing.com/widgets/current/{script_id}/cookie-widget.min.js" data-lwid="{script_id}">` tag to `html_head`.

Add `cdn.lawwwing.com` to your CSP `script-src`. Note the module machine name is `lawwwing` (enable with `drush en lawwwing`).
