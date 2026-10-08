<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# personality_assessment_test — the /personality-test endpoint

Route `personality_test.content` at `/personality-test`, permission `access content`, methods GET + POST.
Controller: `Drupal\personality_test\Controller\PersonalityTestController::content`.

## GET
Returns a render array (`#theme => 'personality_test_quiz'`) with `#questions` = the fixed 28-item trait list from `Options::getSampleData()`. Client-side JS presents the quiz and computes DISC scores.

## POST
- Reads the raw request body as JSON; expects `{"finalResult": {"<Trait>": <score>, ...}}`.
- Builds an HTML `<table>` of trait → score, then `Node::create([...])->save()` with:
  - `type` = `personality_assessment_test`
  - `field_personality_test_user_id` = current user id
  - `field_personality_test_result` = { value: table HTML, format: `full_html` }
- Returns `JsonResponse(['finalResult' => <table html>])`; missing `finalResult` → 400.

## Prerequisites
The `personality_assessment_test` content type and both fields must already exist; the module does not create them.
