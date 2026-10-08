<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
## What it does

- Adds a "Discord Widget" block that renders the official Discord server widget as an iframe.
- Lets site visitors see who is online in your Discord server and click to join.
- Server ID, iframe width/height and light/dark theme are configured per block instance.

---

## Install & configure

- Enable the module; it provides only a block plugin (no routes, no permissions of its own).
- In your Discord server, enable the widget (Server Settings -> Widget) and copy the Server ID.
- Place the "Discord Widget" block via Block Layout (or Layout Builder) and enter the Server ID, dimensions and theme.

---

## Usage & behaviour

- The block plugin id is `discord_widget`; place it in any region like a normal block.
- Configuration keys: `server_id`, `frame_width` (default 350), `frame_height` (default 500), `theme` (`dark`/`light`).
- The rendered iframe points at Discord's own widget endpoint using the configured server id.
- Block config is set by users with the standard `administer blocks` permission, so the embedded server id is trusted admin input.
- Output is produced through a Twig template (`templates/`) with normal autoescaping, so the server id is not a stored-XSS vector.
- No server-side HTTP requests are made; the browser loads the iframe directly from Discord.
- Multiple blocks can embed different servers on different pages.
- The widget only works if the target Discord server has its widget feature enabled.
- Width/height are free-text numeric fields (the "px" unit is added by the template).
- Works with block visibility conditions to show the widget only on selected pages.
- No dependency on the sibling `discord` (webhook) module; the two are independent.
- Purely presentational — it stores no data and defines no cron or queue work.
- Safe on multilingual sites; the widget language follows Discord, not Drupal.
- Removing the block or disabling the module cleanly removes the embed.
- Consider a cookie/consent gate if your privacy policy requires it, since the iframe is third-party.
- Good fit for community, gaming, or open-source project sites that run a public Discord.
