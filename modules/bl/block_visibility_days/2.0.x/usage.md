<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Block Visibility Days adds a day-of-week condition so a block shows only on the weekdays you tick.

---

Block Visibility Days enhances core's block visibility settings with a single "Days Visibility" condition. On any block's Configure > Visibility settings you get a Days fieldset with seven checkboxes (Sunday through Saturday); the block is rendered only on the days you check and hidden on the others. It is implemented as one core Condition plugin (id `block_visibility_days`, in `src/Plugin/Condition/BlockVisibilityDays.php`), evaluating the current day with PHP `date('D')`. If no day is checked the condition passes (block always shown), so it is safe to leave unset. Note the on-disk 2.0.0 source supports day-of-week ONLY — there is no date-range/calendar feature despite older project text. This controls when a block is DISPLAYED, not who can access content; it has no dependencies, no configuration page, and no permissions of its own. Works on Drupal 8 through 11.

---

- Show a block only on specific weekdays.
- Hide a block on weekends (check Mon–Fri only).
- Show a weekend-only promo block (check Sat and Sun).
- Show a "Monday special" banner on Mondays only.
- Rotate different blocks in the same region by day.
- Show a weekday phone-support notice, hide it on weekends.
- Display a Friday newsletter call-to-action.
- Keep a block visible every day by leaving all days unchecked.
- Combine with core's other visibility conditions (pages, roles, content type) on the same block.
- Apply the condition per block placement from Structure > Block layout.
- Enhance core block visibility without custom code.
- Add day scheduling to menu, custom, or view blocks.
- Give site builders a no-code weekday toggle for any block.
- Show a lunchtime menu block on chosen days.
- Hide a maintenance-window notice on days it does not apply.
- Show a recurring weekly-event reminder block.
- Present day-specific announcements in a header region.
- Use the block plugin summary (JS) to see which days are selected at a glance.
- Enable via drush (`drush en block_visibility_days`) or the Extend page, then configure per block.
