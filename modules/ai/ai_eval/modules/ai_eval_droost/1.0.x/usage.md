A submodule of AI Eval that adds a deterministic grader scoring the real Drupal state an AI agent built, checked through read-only Droost MCP tools instead of an LLM judge.

---

AI Eval Droost Oracle (`ai_eval_droost`) ships one ai_eval grader plugin, `droost_state`. Where AI Eval's other graders read an agent's prose response or run an LLM-as-judge, this grader ignores the response text entirely and instead inspects the queryable Drupal state the agent produced. It does so through Droost (`drupal/droost`), an MCP toolkit built on `mcp_server`, using only its read and validate tools: it reads a view's configuration and executes the view for real (returning actual rows), and it reads an entity's persisted Canvas component tree and validates it with Canvas's own validators. An eval question carries an assertion spec under `metadata.droost` (a target plus a non-empty list of assertions); the `AssertionRunner` fetches the target once and evaluates each assertion (config-tier checks against the model, in-band checks against a real execution). The task scores 5.0 only if every assertion passes, 0.0 otherwise, and a question with no `droost` spec skips (NULL, excluded from averaging), so the grader can sit in any target's grader list. The module deliberately never uses Droost's gated write/eval tools, needing neither `allow_destructive` nor `allow_eval`. It has no routes, forms, permissions, or config — just two services and the grader plugin. Requires `ai_eval` and `droost`.

---

- Grade an agent's Drupal build task by the state it produced, not the text it wrote.
- Score a "create a view" task by executing the view and counting the rows it actually returns.
- Catch a config-valid-but-broken view (e.g. a hidden exposed-filter default) that a diff would pass.
- Assert that a view display exists and that its path equals an expected value.
- Discover the exposed query identifier the build actually used (assert on the field, not the id).
- Grade a Canvas page by its persisted component tree (component counts, a component's inputs).
- Validate a persisted Canvas tree through Canvas's own validators rather than by rendering.
- Add deterministic, zero-LLM-cost state grading to any ai_eval target's grader list.
- Skip cleanly on questions that carry no `metadata.droost` spec (no false failures).
- Fail-closed on a malformed droost spec (score 0.0 with a setup-failure reason, never a silent skip).
- Restrict grading to a read/validate tool allowlist so evaluation never mutates the site.
- Get per-assertion PASS/FAIL reason lines for debugging why a build was scored as it was.
- Reuse a proven Python prototype grader's semantics as a faithful in-Drupal PHP port.
- Combine state-based grading with AI Eval's LLM judges on the same target.
- Evaluate build agents against SWE-bench-style discriminating cases (correct vs. broken builds).
