<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Contextualized state (contextualized_state) — agent index

**Plugin-based API for per-user, session-scoped context state driven by dispatched events.**

- **Version:** 1.0.x
- **Core:** ^9 || ^10
- **Plugin type:** `@ContextualizedStateProvider` (manager `plugin.manager.contextualized_state_provider`).
- **Service:** `contextualized_state.context_manager.service` (`ContextualizedStateManager`) — `getContext($plugin_id)`.
- **Events:** dispatch `ContextEvent::ON_SET_CONTEXT`; `contextualized_state.context.event_subscriber` (`ContextSubscriber`) resolves and stores the context.
- **Submodule:** `contextualized_state_examples` (Soccer context/provider, DispatchExampleForm route).

**Security:** developer API; the main module exposes no routes or permissions and stores context in the user session. The examples submodule adds an example form route only. No anonymous mutating endpoints in the core module.

See [plugins/providers.md](plugins/providers.md).
