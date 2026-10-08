Crisis Mode adds one predefined, configurable site-wide block that a site can turn on and off to broadcast an urgent crisis or emergency message.

---

On install the module creates a single disabled block instance (`crisismodeblock`, plugin `crisis_mode_block`) placed first in the content region of the active theme. From the settings form at `/admin/config/system/crisis_mode` (permission `administer crisis mode`) an administrator ticks a "Crisis Situation" checkbox to enable the block and configures its title, rich-text message (shown wherever the block is placed), an optional "more information" link to an internal node, target region, background colour, background image, block image, and — on multilingual sites — a per-language visibility restriction. Saving the form enables or disables the block accordingly and flushes all caches. The same on/off toggle is exposed to the command line via the Drush command `drush crisis-mode on|off` (alias `crisis`). The block renders through the `crisis_mode` theme hook and `crisis-mode.html.twig`, attaching the module's CSS library; configuration is translatable and config-translation aware, so the title, message and link text can be overridden per language. Supports Drupal 8.8 through 11.

---

- Show a site-wide emergency banner during an outage or incident.
- Broadcast a crisis-communication message to every page at once.
- Enable the message instantly by ticking the "Crisis Situation" checkbox and saving.
- Disable the message just as quickly by unticking the checkbox.
- Flip crisis mode on/off from the CLI with `drush crisis-mode on` / `drush crisis-mode off`.
- Toggle crisis mode from a deploy or automation script using the Drush alias `drush crisis`.
- Display a configurable crisis title heading in the block.
- Present a rich-text (full HTML) crisis message body.
- Add a call-to-action button linking to an internal node with more information.
- Customise the link button label (defaults to "More Information").
- Choose which theme region the crisis block appears in (defaults to Content).
- Set a custom background colour for the crisis block.
- Upload a background image for the crisis block.
- Upload a foreground/illustration image shown inside the block.
- Restrict the block to specific languages on multilingual sites.
- Provide translated title, message and link text per language via config translation.
- Pre-configure the message ahead of time so it is ready before any crisis occurs.
- Keep the block dormant (disabled) during normal operation with nothing shown to visitors.
- Place the crisis message as the first block in its chosen region for prominence.
- Give editors with the "administer crisis mode" permission a single dedicated screen to manage all crisis settings.
- Announce planned maintenance windows to all visitors.
- Post a temporary service-status notice across the whole site.
