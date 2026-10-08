# Score base field, tokens, computation

## The `webform_score` base field
Added to `webform_submission` entities via `hook_entity_base_field_info`
(`webform_score.module`). Type `fraction` (from the Fraction module):
- `numerator` = total points scored, `denominator` = total possible points.
- Default view display: `fraction_percentage` (precision 0, `auto_precision` FALSE).
- Read-only: `edit` access is always forbidden ("calculated automatically upon saving").

## Reading it in code
```php
$score = $submission->webform_score;               // FractionItem
$num   = $score->numerator;
$den   = $score->denominator;
$pct   = $den ? round($num / $den * 100) : NULL;   // percentage
```

## Tokens (`hook_token_info` / `hook_tokens`)
On `webform_submission`:
- `[webform_submission:webform_score]` — percentage string, e.g. `77%` (empty if denominator 0).
- `[webform_submission:webform_score_numerator]` — points scored.
- `[webform_submission:webform_score_denominator]` — max points.

Use these in confirmation messages, emails, or computed twig.

## How it is computed
`HookService::webformSubmissionPreSave($submission)` (invoked from
`webform_score_webform_submission_presave`):
1. Loop over `$submission->getWebform()->getElementsInitializedAndFlattened()`.
2. For each element whose Webform element plugin implements `QuizInterface`, add
   `getMaxScore($element)` to `denominator` and `score($element, $submission)` to `numerator`.
3. Assign both onto `$submission->webform_score`.

So the score is always recalculated from current element config on every save — there is no stored
per-answer score, only the submission total.
