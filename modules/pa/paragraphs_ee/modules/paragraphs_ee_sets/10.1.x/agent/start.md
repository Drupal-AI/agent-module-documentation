# paragraphs_ee_sets — agent start

Bridge submodule of **paragraphs_ee**. Brings the Paragraphs Editor Enhancements tile dialog to
**Paragraphs Sets**: predefined reusable paragraph "sets" appear as icon tiles in a dedicated
"Paragraphs Sets" group inside the enhanced add dialog. Depends on `paragraphs_ee` and
`paragraphs_sets`; core `^10 || ^11`. No config, permissions, routes or services of its own.

Active only when a Paragraphs widget uses **modal add mode** and has Paragraphs Sets enabled
(`paragraphs_sets.use_paragraphs_sets`). It respects the widget's `sets_allowed` restriction and
installs with module weight 20 so it runs after both parent modules.

- How it restyles set buttons & adds the "Paragraphs Sets" tab → [theming/paragraphs_ee_sets.md](theming/paragraphs_ee_sets.md)
