# Theming

`hook_theme` (in `security_review.module`) registers four templates under `templates/`.
Override by copying the template into your theme.

| Theme hook | Template | Variables |
|---|---|---|
| `run_and_review` | `run-and-review.html.twig` | `date`, `checks` (result ints converted to `success`/`fail`/`warning`/`info` strings; adds `icons` with core check/warning/error SVG URLs in preprocess). |
| `check_evaluation` | `check-evaluation.html.twig` | `additional_paragraphs`, `finding_items`, `hushed_items`. |
| `check_help` | `check-help.html.twig` | `paragraphs`. |
| `general_help` | `general-help.html.twig` | `paragraphs`, `checks`. |

## Library
`security_review/run_and_review` (`security_review.libraries.yml`) attaches
`css/security_review.run_and_review.css` plus `core/drupal`, `core/jquery`, `core/once`.

A check's `getDetails()` typically returns a render array with
`'#theme' => 'check_evaluation'` to display its findings.
