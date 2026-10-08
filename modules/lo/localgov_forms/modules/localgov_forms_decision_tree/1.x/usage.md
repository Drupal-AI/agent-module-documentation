A LocalGov Forms example submodule that installs a demo webform showing how to build a decision-tree / smart-answer form with conditional questions.

---

LocalGov Forms Demo Decision Tree is a pure example module (package *LocalGov Drupal Examples*). Enabling it imports a single demo webform, *"Demo Decision Tree: Find the Perfect Playlist"* (`localgov_forms_demo_descion_tree`), available at `/form/localgov-forms-demo-descion-tree`. The form illustrates the standard Webform technique for a decision tree: a set of `radios` questions where each follow-up question is revealed by a conditional `#states` rule keyed on the answer to the previous one, so the path a user sees depends on their earlier choices. It ships no PHP logic, no routes, services, permissions or config schema — just the webform config entity — and depends only on Webform. Use it as a copyable reference for building your own branching council forms (eligibility checkers, "which service do I need", triage flows).

---

- Learn, from a working example, how to build a decision-tree/smart-answer form in Webform without custom code.
- See the `#states` conditional-visibility pattern that reveals a follow-up question based on a previous radio answer.
- Copy the demo webform as a starting point for an eligibility checker or "which service do I need" flow.
- Prototype a triage form (report-it, apply-for, tell-us) using branching questions.
- Demonstrate to content designers how later questions can depend on earlier answers.
- Provide a ready-made `/form/localgov-forms-demo-descion-tree` page for training or workshops.
- Export the demo webform's YAML to understand the exact `#states` value/`checked` syntax.
- Test that conditional-visibility rules behave as expected on your theme.
- Build a multi-branch "find the right option" form (the demo branches music era → genre → sub-choice).
- Show how a single webform can encode several answer paths rather than separate forms.
- Uninstall it safely once you have copied the pattern (it only adds the demo config entity).
- Pair with the parent localgov_forms styling for a government-looking smart-answer form.
- Reference the demo when documenting your council's own decision-tree forms.
- Validate Webform's conditional logic on Drupal 10 and 11.
- Teach editors to add options and branches by editing the radios elements and their `#states`.
