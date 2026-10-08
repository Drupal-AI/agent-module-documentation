<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AI Site Manager lets an administrator describe a site-management task in plain English and turns it into one specific, previewed command that must be explicitly confirmed before it runs.
---
A request ("enable the Metatag module", "clear all caches", "turn on maintenance mode") is interpreted into one command, action, and parameter set — either by the configured AI provider (via the AI module) or by plain keyword matching when no provider is configured or the AI's confidence is too low. The user is shown an exact, human-readable preview with a risk level before anything runs. v1 supports three `AICommand` plugins: module enable/uninstall (`ModuleCommand`), cache clear (`CacheCommand`), and maintenance-mode toggle (`MaintenanceModeCommand`). Every interpretation and execution is written to an audit log at Reports » AI Site Manager History, including who requested it, what was matched, and the outcome.

Access is split by design in `ChatForm`: any user with `access ai site manager` can type a request and preview an action, but only users with the restricted `administer ai site manager` permission can confirm and execute — the confirm button's `#access` and the `confirmSubmit()` handler both re-check that permission, and the handler re-validates before executing. A flood limit (configurable) bounds prompts per user so a single account cannot run up unbounded AI-provider cost ("Analyze" requests count, confirmations do not). The module delegates all provider calls to AI Core (no stored key, no direct TLS handling). This is a two-step, human-in-the-loop, permission-gated design rather than an autonomous agent.
---
- Enable a module by describing it in plain English.
- Uninstall a module via a natural-language request.
- Clear all caches with a chat command.
- Toggle maintenance mode on or off.
- Preview the exact action and its risk level before running.
- Require an explicit human confirmation step for every action.
- Restrict execution to holders of `administer ai site manager`.
- Let non-admins preview actions with `access ai site manager` only.
- Fall back to keyword matching when no AI provider is configured.
- Fall back to keywords when AI confidence is too low.
- Audit every interpretation and execution with who/what/outcome.
- Review history at Reports » AI Site Manager History.
- Bound per-user prompt volume with a flood limit to cap AI cost.
- Interpret requests in a chosen language on multilingual sites.
- Delegate provider calls to AI Core with no stored key.
- Re-validate the action at execution time, not just at preview.
- Prevent preview-only users from executing anything.
- Configure the provider/model and flood limit in settings.
- Use as a guided, human-in-the-loop admin assistant.
- Keep a compliance trail of AI-suggested administrative actions.
