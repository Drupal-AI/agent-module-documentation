<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Personality Test (personality_assessment_test) — agent index

**DISC-style personality quiz at `/personality-test`; POSTed results are saved as a node.**

- **Version:** 1.0.x (dev-1.0.x checkout)
- **Core:** ^9 || ^10 || ^11
- **Route:** `personality_test.content` → `/personality-test`, methods GET+POST, perm `access content`. Controller `PersonalityTestController::content`.
- **Block:** `PersonalityTestQuizBlock`. **Theme:** `personality_test_quiz` (template `personality-test-quiz.html.twig`). **Data:** fixed 28-question set in `src/Options.php`.
- **Expects** a `personality_assessment_test` node type with `field_personality_test_user_id` and `field_personality_test_result` (full_html).

See [api/endpoint.md](api/endpoint.md).