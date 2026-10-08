# Configuration

Setting up MeetMy.bot Clone is a two‑part job: enter the **global settings** once,
then **place bot blocks** wherever you want them (each block can override the
global values). No complex setup is required — after the basic global configuration
the module works immediately.

## Part 1 — Global configuration

1. Log in as an administrator and go to **Configuration → Web Services →
   MeetMy.bot Clone**, or navigate directly to
   `/admin/config/services/meetmy-bot-clone`.
2. Fill in the fields:

   - **Bot title** — the name shown for the bot, for example "Customer Support
     Assistant".
   - **MeetMy.bot Clone service URL** — the service URL from Eternity.ac. This is the
     value that makes the bot work; without it there is nothing to embed.
   - **Window dimensions** — the preferred size of the bot window: **width** between
     200 and 2000 px, and **height** between 300 and 1200 px.
   - **Preview video URL** *(optional)* — a short video that introduces the bot
     before a visitor interacts with it.

3. Save the form.

## Part 2 — Place the bot block

1. Go to **Structure → Block Layout** (`/admin/structure/block`).
2. Click **Place block** in the region where you want the bot to appear.
3. Find and select the **MeetMy.bot Clone** block.
4. Configure block‑specific options as needed:

   - **Overrides** — each block can override the global **title**, **dimensions**, and
     **preview‑video** preferences, so different placements can behave differently.
   - **Visibility** — use Drupal's standard block visibility settings to control which
     **pages** and **user roles** see the bot, plus caching behaviour.

5. Save the block.

## Multiple bots

Because it is block‑based, you can place several MeetMy.bot Clone blocks — for
example a support bot on help pages and a sales bot on product pages — each with its
own title, size and visibility. Repeat Part 2 for each.

## Test and privacy notes

Visit a page where you placed a block to confirm the bot opens in its modal overlay.

Keep in mind that the bot is embedded from the **external MeetMy.bot / Eternity.ac
service**: visitor interactions load resources from and are handled by that
third‑party service. Treat the **service URL** as a configuration secret where
appropriate, ensure visitors' privacy/consent expectations are met for a third‑party
chat widget, and confirm your Drupal site can reach the service over the network.
