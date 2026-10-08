# Configuration

Setting up this block is a two‑part job: enter the two text messages on the
module's settings form, then place the block in a region.

## 1. Grant the permission

Give the **`administer correspondence_helper_block settings`** permission to the
trusted roles that should be allowed to edit the block's text. Do this at **People
→ Permissions** (`/admin/people/permissions`).

## 2. Set the text

1. Go to **`/admin/config/correspondence_helper_block`**.
2. Fill in the two fields:
   - **Communication Text Message** — shown *before* the on‑file email address.
     This is the reminder line, e.g. "We will send your confirmation to:".
   - **Support Contact Text** — holds your support‑team contact information, shown
     alongside the message.
3. Save. The values are stored in the module's configuration
   (`correspondence_helper_block.settings`).

Both fields are textareas, and their content is treated as trusted admin
text — only give the editing permission to roles you trust.

## 3. Place the block

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Place the **Correspondence Helper Block** in any region you like — an account
   page sidebar or a confirmation area are natural choices.
3. Configure the standard block visibility settings as needed, and save.

When rendered, the block shows your **Communication Text Message**, the current
user's own account email, and then the **Support Contact Text**.

## Multilingual sites

To translate the two messages, use Drupal's standard configuration translation
workflow on the module's settings config.

## Restyling

The module defines a `correspondence_helper_block` theme hook, so you can override
its template in your theme if you want to change the block's markup or styling
rather than just its wording.
