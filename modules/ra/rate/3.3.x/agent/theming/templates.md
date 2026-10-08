<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Templates, libraries, results & Views

## Widget templates (styles)

A widget's `template` field selects a built-in style, each with its own CSS/JS library
(`rate/w-<style>`): `custom`, `fivestar`, `numberupdown`, `emotion`, `thumbsup`,
`thumbsupdown`, `yesno`. Add or modify styles from code with `hook_rate_templates()` (see
[../hooks/rate.md](../hooks/rate.md)).

## Twig templates (override in your theme)

| Template | Renders |
|---|---|
| `rate-widget.html.twig` | the widget itself (buttons/options) |
| `rate-widgets-summary.html.twig` | the results summary; receives `disabled` and `deadline_disabled` vars |
| `form-element--rate-rating.html.twig` | the individual rating form element |

Copy the file into your theme's `templates/` to customize. The summary template is the one to
override to change how vote totals are displayed.

## Vote result functions (VotingAPI plugins)

Rate registers VotingAPI `VoteResultFunction` plugins used to total results per widget:

| Plugin id | Meaning |
|---|---|
| `rate_count` | number of votes |
| `rate_average` | average value (percentage widgets) |
| `rate_sum` | sum of values (points widgets) |
| `rate_count_up` | number of up votes |
| `rate_sum_up` | sum of up votes |

(A `RateVoteResultFunction` derivative exposes these per widget/entity combination.) These are
VotingAPI's plugin type — Rate defines instances, not a new plugin manager.

## Views integration

Add a **"Rate widget"** field (`RateWidgetField`) to a View. Configure which column holds the
entity id, which widget to show (if a bundle has several), and the display mode (Full /
Summary / Read only). Note: you cannot sort/filter on the Rate widget field itself — add a
VotingAPI results relationship and sort/filter on that instead.

## Node results tab

`/node/{node}/node-rating` (route `rate.node_results_page`, controller
`WidgetResultsController::nodeResults`, permission `view rate results page`) lists per-widget
voting results for a node. Other entity types need a custom controller/route (mirror the node
implementation).
