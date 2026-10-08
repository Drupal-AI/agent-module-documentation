# Configuration

SCIE works out of the box — everything here is **optional**. When you enable the
module it scores all content immediately with sensible defaults, so you only need
this page if you want to change how scoring behaves or turn on publish control.

## The scoring dashboard

The main day-to-day surface is the SCIE dashboard: an accessible, ARIA-compliant,
screen-reader-optimised, mobile-responsive interface that lists your content with
its scores. Columns are **sortable** and results are **filterable**, and each score
is **colour-coded** into Excellent / Good / Needs Improvement / Poor bands so you
can spot weak content quickly. Each score breaks down into the four dimensions
(Structural Quality out of 30, Readability out of 20, Semantic Quality out of 30,
and Content Richness out of 20) that add up to the 0–100 total.

## Publish control (minimum score threshold)

You can have SCIE **block publishing** of content that scores below a minimum. The
threshold is configurable and defaults to **50**. With it enabled:

- Content is validated in **real time** while editing.
- If the score is below the minimum, publishing is blocked with a clear message
  that states the current score and the required minimum.

Raise the threshold to enforce stricter editorial standards, or lower it (or leave
publish control off) if you only want scoring for insight rather than as a gate.

## Self-learning

SCIE can improve its semantic scoring over time by learning from your best content.
When you mark content as an **Editor's Pick**, the engine analyses it and
dynamically adjusts its semantic weights toward your organisation's own writing
patterns — so it becomes better tuned to your site without manual configuration.

## Advanced settings

Beyond the threshold and self-learning, additional **advanced settings** are
available for power users who want to fine-tune the engine. Most sites will not
need to change them — the defaults are designed to work well immediately.
