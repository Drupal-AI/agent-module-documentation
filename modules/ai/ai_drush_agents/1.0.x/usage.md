AI Drush Agents adds Drush commands that run AI Agents (from the `ai_agents` module) interactively from the command line, including ready-made agents that explain Drush commands and summarize pending configuration-export changes.

---

The module is a thin CLI front-end for the `ai_agents` framework. `agents:run` lets you pick any `ai_agent` config entity on the site and hold a back-and-forth chat with it in the terminal, rendering the agent's markdown replies with `sevenecks/markdown-terminal`. Two bundled agents ship as config: `drush_explain_agent` (exposed as `agents:drush_explain`) inspects the list of Drush commands available on the system — and, if needed, the source code of a specific command class — to tell you which command to run for a described task; `config_export_explainer` (exposed as `agents:config_export_explain`) computes the diff between active and staged configuration and explains, in plain language, what a `drush config:export` would change. The agents reach this data through four `AiFunctionCall` tool plugins the module provides: `get_drush_commands`, `get_drush_code`, `get_config_entity`, and `config_diff`. A working AI provider must be configured through the `ai`/`ai_agents` stack for any of the commands to produce output. All functionality is command-line only; the module defines no routes, permissions, or config-schema of its own.

---

- Install alongside `ai_agents` and a configured AI provider, then drive agents entirely from Drush.
- Run `drush agents:run` to interactively choose any AI agent on the site and chat with it.
- Run `drush agents:run config_export_explainer` to launch a specific agent by its machine ID non-interactively at the prompt.
- Use the `agent` alias as a shortcut for `agents:run`.
- Ask "what changed?" before a config export: `drush agents:config_export_explain` (alias `agecex`) summarizes the active-vs-staged diff in readable prose.
- Review a large pending config export without eyeballing raw YAML diffs line by line.
- Onboard a teammate by having the config-export explainer describe what a deployment's staged config will alter.
- Find the right Drush command for a task with `drush agents:drush_explain` (alias `agedre`) — describe the goal, get a suggested command and usage example.
- Discover commands provided by contrib/custom modules you have installed but do not remember the syntax for.
- Let the Drush explainer read a specific command's class source to clarify exactly what an unfamiliar command does before you run it.
- Prototype your own conversational CLI workflows by creating new `ai_agent` entities and running them through `agents:run`.
- Integrate AI-assisted answers into local development and CI shells where a browser UI is unavailable.
- Get plain-language explanations of Drupal configuration entities during debugging sessions.
- Reuse the module's `config_diff` tool plugin as context provider inside your own custom agents.
- Reuse the `get_drush_commands` / `get_drush_code` tool plugins to give a custom agent awareness of the site's Drush command surface.
- Speed up deployment reviews by pairing `config_export_explain` with your normal `config:status` / `config:export` workflow.
- Provide a guided, chat-style entry point to Drush for developers less familiar with the command catalog.
- Script repeatable agent runs in shell aliases or Makefile targets around `drush agents:run <id>`.
- Explain unfamiliar third-party module configuration by loading its config entities through the bundled config-export agent.
- Keep AI interactions in the terminal for developers who prefer CLI-first tooling over an admin UI.
