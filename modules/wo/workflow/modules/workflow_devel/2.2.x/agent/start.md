<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Workflow Devel — agent index

Workflow submodule for add-on developers: implements **every** Workflow hook (and related core
hooks/events) and shows a message each time one fires, so you can trace the transition lifecycle.
Depends on `workflow`. Not for production. No routes, permissions, config, or schema.

- **The full list of hooks/events it implements and how to use them as a template** →
  [hooks/reference.md](hooks/reference.md)

Key facts: service `Drupal\workflow_devel\Hook\WorkflowDevelHooks` (`#[Hook]` methods, with
`#[LegacyHook]` wrappers in `.module`) plus `WorkflowDevelEventSubscriber` on
`WorkflowEvents::PRE_TRANSITION` / `POST_TRANSITION`. Enable → do a transition → read the messages
→ disable. To write your own reactions, see the parent's
[hooks doc](../../../../2.2.x/agent/hooks/hooks.md).
