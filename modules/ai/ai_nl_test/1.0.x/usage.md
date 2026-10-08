Runs plain-English browser regression tests for a Drupal site by letting an LLM drive Playwright through the Model Context Protocol, executed from the command line via Drush.

---

AI Natural Language Test lets site builders and QA teams write end-to-end regression tests as YAML files whose steps are plain English ("Navigate to /login", "Click the Save button", "Verify the page title contains Success"). A Drush command discovers those `*.test.yml` files, and for each one spawns a bundled Node.js runner (`scripts/drupal_runner.js`) that connects to a Playwright Model-Context-Protocol server, streams the natural-language steps to an OpenAI model, and lets the model call browser tools to carry out and assert each step. The run produces console pass/fail output plus HTML reports and screenshots under the module's `artifacts/` directory. The OpenAI API key is read from the Key module (recommended) or the `OPENAI_API_KEY` environment variable. The module is operated entirely from Drush — it exposes no web pages that run tests, only an admin settings form (`/admin/config/system/ai-nl-test`) for the Node binary path, timeout, key selection, model, headless flag, and output directories. Node.js 18+ and an `npm install` inside the module directory are required before tests can run.

---

- Write Drupal regression tests in plain English instead of PHPUnit or raw Playwright code.
- Let non-developers (QA, site builders) author `*.test.yml` scenarios with readable steps.
- Drive a real browser (Playwright) to click, type, navigate, and assert against your live site.
- Run a single natural-language test from Drush during a release check.
- Run every discovered test in one batch and get an aggregate pass/fail summary.
- List all available tests (name, folder, tags, path) without running them.
- Filter which tests run by folder, name pattern, or tags.
- Discover tests shipped by the module, by Drupal core (`core/tests/playwright`), or by contrib modules.
- Validate site behavior after a module update, config change, or deployment.
- Capture screenshots automatically at key steps for visual evidence.
- Generate self-contained HTML reports with an action-by-action timeline and embedded screenshots.
- Toggle headless vs. headed (VNC-friendly) browser runs per invocation or via config.
- Store the OpenAI API key securely through the Key module rather than in settings.
- Fall back to the `OPENAI_API_KEY` environment variable when no key entity is selected.
- Choose which OpenAI model interprets the steps.
- Configure a per-script execution timeout for long browser flows.
- Point the runner at a specific Node.js binary path when Node is not on the system PATH.
- Integrate natural-language smoke tests into CI by invoking the Drush command.
- Keep reusable regression scenarios that run unchanged across environments.
- Get human-readable failure explanations (expected vs. actual) rather than stack traces.
