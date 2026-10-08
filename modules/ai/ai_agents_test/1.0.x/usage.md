<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AI Agents Test provides a content entity that describes a test for an AI agent — the input, the expectation — which can be run from the UI or exported as configuration and run as part of a test suite.

---

Agents are hard to change safely. A prompt edit, a model swap or a new tool can improve one case and quietly break three others, and unlike ordinary code there is no compiler to tell you. The answer is the same as for any other behaviour you cannot reason about statically: keep a body of cases and re-run them. This module makes those cases first-class objects in Drupal — created and edited like content, listed in a View, run with a button, and exportable to config so they travel with the site and can run in CI.

That dual nature is the useful part. During development a test is a content entity you tweak and re-run interactively; for a pipeline the same test is configuration a test runner executes. The permissions match: `administer ai_agents_test` (`restrict access: true`), plus separate `view` and `edit` permissions so the people who write tests need not be the people who administer the agent framework.

Both this module and the wider `ai_agents` framework are moving quickly — it is `lifecycle: experimental` at **1.0.0-alpha4**, so expect the entity shape and the runner interface to change. That is an argument for adopting it early on a project that is actively building agents, and against depending on its exported format for anything long-lived yet.

---

- Define a repeatable test for an AI agent.
- Re-run a body of cases after a prompt change.
- Catch a regression introduced by a model swap.
- Test an agent from the admin UI.
- Export tests as configuration.
- Run agent tests in a CI pipeline.
- List and filter tests in a View.
- Give a prompt engineer test-authoring rights only.
- Separate test authoring from agent administration.
- Build a regression suite for agent behaviour.
- Compare agent output before and after a change.
- Document expected agent behaviour as data.
- Share tests across environments through config.
- Evaluate a new tool's effect on existing cases.
- Track which agent behaviours are covered.
- Onboard a new developer to an agent's expected behaviour.