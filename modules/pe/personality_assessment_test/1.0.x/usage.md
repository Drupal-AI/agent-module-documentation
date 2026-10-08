<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Renders a 28-question DISC-style personality quiz and stores each respondent's computed trait scores as a node.

---

The module exposes a page/route `/personality-test` (permission `access content`, GET+POST). On GET it renders the quiz via the `personality_test_quiz` theme, fed a fixed 28-question trait dataset from `src/Options.php`; front-end JavaScript scores the answers into Dominance/Influence/Steadiness/Conscientiousness percentages. On POST the controller reads the JSON body's `finalResult` map, builds an HTML results table, and saves it into a new node of type `personality_assessment_test` (fields `field_personality_test_user_id`, `field_personality_test_result` with format `full_html`), returning the table as JSON. A `PersonalityTestQuizBlock` block lets you embed the quiz elsewhere.

Setup: create the `personality_assessment_test` content type and its two fields (the module expects them), enable the module, and link to `/personality-test` or place the block.

---

- Offer visitors a DISC-style personality quiz at `/personality-test`.
- Render the 28-question quiz using the `personality_test_quiz` theme.
- Embed the quiz anywhere with the `PersonalityTestQuizBlock` block.
- Score responses into Dominance/Influence/Steadiness/Conscientiousness percentages (client-side).
- Save each respondent's result as a `personality_assessment_test` node.
- Record the respondent's user id on the result node.
- Store the formatted result table in a `full_html` node field.
- Return the result table as JSON from the POST endpoint.
- Let users revisit their saved result nodes over time.
- Review submitted results in the Drupal admin content list.
- Provide the fixed trait dataset from `Options::getSampleData()` on GET.
- Link the quiz from menus or pages for user onboarding/engagement.
- Create the required content type and fields before enabling the feature.
