<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Dopup displays a webform inside a configurable popup block, in the style of sumo.me, for lead-generation and marketing prompts.

The module provides a "Dopup" block whose configuration form lets a site builder pick a webform (only webforms tagged with the `dopup` category are offered), choose a popup position, set trigger behavior (after N seconds, on scroll to a percentage of the page, etc.), and add custom styles. The chosen webform is rendered into a hidden container and revealed by the module's JavaScript according to the trigger. Block settings are keyed by block id and stored in `dopup.settings` config.

Two routes exist: an admin settings form at `/admin/config/system/dopup/{block}` gated by the `administer dopup configuration` permission (restrict access), and a webform autocomplete endpoint at `/dopup/autocomplete-webform` gated only by `access content`. The autocomplete controller runs an entity query with `accessCheck(FALSE)` and returns matching webform machine names/titles, so any user who can view content — including anonymous — can enumerate all webform ids on the site (recorded finding, Danger 1). Typical setup: create a webform, add the `dopup` category to it, enable the module, place the Dopup block, and configure its trigger and styling.
---
Dopup embeds a webform in a configurable, trigger-based popup block for lead capture.
---
- Create a webform to use as the popup body.
- Add the category `dopup` to that webform so it appears in the block config.
- Enable the module (requires the Webform module).
- Place a "Dopup" block in a region.
- Select the webform to show in the popup.
- Choose the popup position (center, corners, or custom).
- Trigger the popup a number of seconds after page load.
- Trigger the popup when the visitor scrolls to a page percentage.
- Add custom CSS to style the popup.
- Restrict the popup to specific pages via block visibility.
- Show the popup only to anonymous visitors via role visibility.
- Use the popup for newsletter sign-ups.
- Use the popup for a "Get a Quote" lead form.
- Collect submissions through the standard Webform results UI.
- Adjust the settings form per block instance at `/admin/config/system/dopup/{block}`.
- Grant the `administer dopup configuration` permission to trusted editors.
- Style multiple popups differently by placing separate blocks.
- Disable a popup by unplacing or disabling its block.
- Review captured leads in Webform submissions.
- Export webform submissions for CRM import.
