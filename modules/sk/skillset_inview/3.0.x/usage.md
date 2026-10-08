<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Skillset Inview lets you present a list of skills with proficiency levels as animated bars, intended for portfolio/CV pages, exposed through a field type plus a block.

---

It ships a `SkillsetItem` field type with a matching widget and two field formatters (`SkillsetItemFormatter` and a meter variant), an admin colour/theme form (`skillset_inview.color`), a preview controller, and a reorder/overview page (`skillset_inview.order`, the configure route). Two Twig extensions support the templates: `unescape` (decodes HTML entities) and `HexToRgb` (colour conversion). Everything behind the admin routes is gated by the `administer skillset inview` permission.

The module is presentational and admin-driven; skill data is authored by editors through the field/block config. One code note for maintainers: the `unescape` Twig filter marks its output as safe HTML after `html_entity_decode`, so templates must only feed it trusted, admin-entered values. Typical setup is: enable the module, add the Skillset field to an entity or place the block, choose colours, and order the skills.

---
- Show a portfolio "skills" section with animated proficiency bars.
- Add a Skillset field to a content type or user profile.
- Place the skills block in a region.
- Use the meter formatter for a gauge-style display.
- Configure bar/theme colours via the admin colour form.
- Preview the skill block before publishing.
- Reorder skills through the overview page.
- Convert hex colours to RGB in templates via the Twig filter.
- Restrict skill administration with the dedicated permission.
- Display named skills with percentage levels.
- Build a CV/resume page with visual skill ratings.
- Theme skill bars to match a portfolio design.
- Render skills inline via the standard field formatter.
- Group multiple skills in one field.
- Customize labels and values per skill.
- Reuse the block across several pages.
