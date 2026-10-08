# Configuration

Consent Popup has no central settings page — everything is configured on the
**block instance** you place. Place it once, edit its settings, and you are done.

## Place the block

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Find the **Consent Popup** block and click **Place block** in the region you
   want (for a site‑wide banner, a region present on every page).
3. In the "Configure block" dialog, use the standard **Visibility** tabs if you
   want to limit the popup to certain pages, roles, or content types.

## The block's own settings

The block instance form is where the module's real configuration lives. All of the
text is editable, so you can word the notice however you like:

- **Notice / message text** — the main text shown in the popup.
- **Accept behaviour** — when a visitor accepts, a global cookie is stored on the
  site so the popup is not shown again. You configure the cookie as part of the
  block settings.
- **Decline text and link** — when a visitor declines, the popup shows your
  configured decline text along with a link to a page you choose (for example a
  page explaining what declining means, or your privacy policy).
- **Appearance** — you can set which page elements are **blurred** while the popup
  is open, plus the popup's **background colour** and **background opacity**, to
  match your theme and draw appropriate attention.

## Save

Click **Save block**. The popup appears on the pages you targeted. Because it is
block configuration, it exports and deploys with the rest of your block layout.

## A reminder on scope

Accepting stores a cookie and dismisses the notice; declining shows your decline
message and link. Neither action blocks or unblocks any third‑party script — this
is a notice, not a consent manager. If you find yourself wanting the popup to
control whether analytics or marketing tags run, that is the signal that you need a
full consent manager instead (see the [overview](../index.md)).
