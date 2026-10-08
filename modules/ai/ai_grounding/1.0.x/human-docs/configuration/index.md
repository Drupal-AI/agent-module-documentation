# Configuration

AI Grounding's behavior is controlled from a small settings form, and its
results can be reviewed in a report. Both are restricted to administrators.

## Open the settings form

Go to `/admin/config/ai/grounding`. You need the restricted **Administer AI
Grounding** permission.

## What you configure

The settings determine how the scores translate into actions:

- **Per-sentence threshold** — the minimum grounding score a single sentence
  must reach to count as *supported*. Sentences below it are marked unsupported.
  Raise it to be stricter about each individual claim; lower it to tolerate
  looser paraphrasing.
- **Overall threshold** — the cutoff the answer's average score is compared
  against to choose the final action. An answer that clears it can be allowed;
  one that falls short is flagged, made to abstain, or held, depending on your
  enforcement choice.
- **Enforcement / action mapping** — how the overall score maps to the four
  actions: **allow** (let it through), **flag** (pass but mark it),
  **abstain** (replace with a "not enough information" response), or **hold**
  (keep it back for human review).
- **Scorer** — which grounding-scorer plugin grades the sentences. The default
  is `lexical_overlap`, a deterministic, offline word-overlap scorer that costs
  nothing to run. If you have installed a custom scorer plugin, you can select
  it here.

Save the form to apply your thresholds. They take effect the next time your
pipeline calls the verifier service.

## The grounding report

Go to `/admin/config/ai/grounding/report` (restricted **View AI Grounding
reports** permission) to inspect grounding outcomes — the per-sentence scores,
which source best matched each sentence, and the action each answer received.
Use it to calibrate your thresholds: if legitimate answers are being held too
often, loosen the thresholds; if unsupported claims are slipping through as
allowed, tighten them.
