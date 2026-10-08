# Configuration

Page Swap needs no settings forms, content types, or text‑format changes. The one
setup step is granting the permission; after that, you use the swap tool itself.

## Grant the permission

Under **People → Permissions** (`/admin/people/permissions`), tick **Use Page
Swap** for the administrator roles that should be allowed to perform swaps, and
save. Because a swap irreversibly changes public URLs and site structure, this is a
**restricted** permission — grant it only to trusted roles.

## Perform a swap

1. Go to **Configuration → Content authoring → Page Swap**
   (`/admin/config/content/page-swap`).
2. In the first autocomplete field, type the title of the **Original** page (the one
   currently on the live URL). In the second, type the title of the **Replacement**
   page.
3. Click **Show Preview**. Page Swap renders both pages side by side in iframes so
   you can compare them, and displays an **Execution Plan** — a detailed summary of
   every action the swap will perform (alias movement, menu updates, system‑page
   changes, publish‑state change).
4. Configure the optional fields:
   - **New alias for the original** — the original can be given a new alias or left
     without one after the swap.
   - **Publish state sync** — optionally publish the replacement during the swap if
     it is not already published.
   - **System page checkboxes** — if the original is set as the site's **homepage**,
     **403 access‑denied** page, or **404 not‑found** page, individual checkboxes let
     you update each of those settings as part of the swap.
5. Review the plan carefully, then click **Apply Page Swap**. Nothing is changed
   until you click this.

## What the swap does

- **Path alias** — the original's URL alias is moved to the replacement (the
  original gets your chosen new alias, or none).
- **Menu links** — every menu item pointing to the original is retargeted to the
  replacement, preserving position, parent, and the full hierarchy of child links.
- **System pages** — any homepage/403/404 assignment you ticked is updated.
- **Revisions** — both nodes get a new revision, so the change is clearly recorded.
- **Redirect / Pathauto** — if those modules are present, redirect creation is
  suppressed during the swap and Pathauto is prevented from overwriting the new
  alias.

## Audit log

If you enabled the **Swap History** (`page_swap_history`) submodule, every swap is
recorded with a timestamp and the user who performed it, viewable from its dedicated
administration tab.
