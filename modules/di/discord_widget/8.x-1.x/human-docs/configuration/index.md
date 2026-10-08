# Configuration

Discord Widget has no site‑wide settings page. You configure it on the **block**
itself, so each block instance can embed a different server with its own size and
theme.

## Step 1 — enable the widget in Discord

The Discord widget only works if the target server has the feature turned on:

1. In Discord, open **Server Settings → Widget** (also called *Enable Server
   Widget*).
2. Turn the widget **on** and note the **Server ID** shown there — you will paste
   it into Drupal. (You can also find the Server ID from Discord's Developer Mode
   by right‑clicking the server icon and choosing *Copy Server ID*.)

## Step 2 — place and configure the block

1. Log in as a user with the **Administer blocks** permission.
2. Go to **Structure → Block layout** (`/admin/structure/block`) and click **Place
   block** in the region where you want the widget (a sidebar is common). Choose
   the **Discord Widget** block.
3. Fill in the block's configuration fields:
   - **Server ID** (`server_id`) — the numeric ID of your Discord server, from
     Step 1. This is required; it is what tells Discord which server's widget to
     show.
   - **Width** (`frame_width`, default 350) — the iframe width. Enter a plain
     number; the module adds the `px` unit for you.
   - **Height** (`frame_height`, default 500) — the iframe height, again as a plain
     number.
   - **Theme** (`theme`) — choose **dark** (the default) or **light** to match your
     site's look.
4. As with any block, you can use the **Visibility** conditions to limit which
   pages the widget appears on (for example, only the front page).
5. Click **Save block**.

## Notes

- You can place multiple Discord Widget blocks, each with a different Server ID —
  handy if you host more than one community.
- The Server ID is trusted admin input and is rendered through a Twig template with
  normal autoescaping, so it is not a stored‑XSS vector.
- The module makes **no server‑side requests** — the visitor's browser loads the
  iframe directly from Discord. Because that is a third‑party frame, consider a
  cookie/consent gate if your privacy policy requires one.
- The widget's language follows Discord, not your Drupal site's language.
