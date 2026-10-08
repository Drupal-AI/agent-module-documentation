<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Boolean Advanced Formatter gives Boolean fields a formatter that can render only one of the two states - for example, output text only when the value is true and nothing when false.

Use it for badges, flags or conditional labels driven by a Boolean field.

---

Install with `composer require drupal/boolean_advanced_formatter` and enable it (`drush en boolean_advanced_formatter`); it depends on core `field`.

On the entity's Manage Display, choose the Boolean Advanced formatter for a Boolean field and configure which state to display and its label/markup.

---

- Format Boolean fields with single-state display.
- Show output only when the value is true.
- Show output only when the value is false.
- Configure per-state labels or markup.
- Apply via the field's Manage Display screen.
- Depend only on core Field module.
- Target Drupal 10.
- Provide a field-formatter plugin.
- Require no routes or permissions.
- Suit badges, flags and conditional labels.
- Suppress the opposite state entirely.
- Keep configuration within Field UI.
- Work with any Boolean field.
- Add no front-end libraries.
- Serve as a focused display enhancement.
- Improve control over Boolean rendering.
- Complement core's default Boolean formatter.