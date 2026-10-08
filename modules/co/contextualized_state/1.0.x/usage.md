<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Contextualized State provides a developer API for maintaining fine-grained, per-user context stored in the session, so the system can behave differently depending on a user's current context.

---

Developers define a Context class (extending `BaseContext`) and a ContextualizedStateProvider plugin (annotation `@ContextualizedStateProvider`). Context is set by dispatching a `ContextEvent` (`ContextEvent::ON_SET_CONTEXT`) via the event dispatcher; a `ContextSubscriber` resolves which provider should handle it (optionally forced with a `plugin_id`, grouped by a `type`) and stores the resulting context. Values are later read through the `contextualized_state.context_manager.service` (`ContextualizedStateManager::getContext($plugin_id)`), which returns the context object exposing `getAll()` and `getState('key')->getValue()`. A bundled `contextualized_state_examples` submodule ships a Soccer context/provider and a dispatch example form.

Operational note: state is contextual to the user session, so behavior varies per user; there are no routes or permissions in the main module (the examples submodule adds an example form route). It is infrastructure for other modules to build on.

---
- Enable the module to gain the context state API.
- Create a Context class extending `BaseContext`.
- Create a `@ContextualizedStateProvider` plugin for it.
- Dispatch a `ContextEvent` to set context values.
- Pass `plugin_id` on the event to target a specific provider.
- Use the `type` attribute to group related contexts.
- Read context via `contextualized_state.context_manager.service`.
- Call `getContext($plugin_id)` to retrieve a context object.
- Use `getAll()` to read every stored context value.
- Use `getState('key')->getValue()` for a single value.
- Enable `contextualized_state_examples` to study the Soccer example.
- Try the DispatchExampleForm to set example context.
- Vary rendering or logic based on the current user's context.
- Extend the provider manager with additional context providers.
- Group contexts with a shared type for bulk handling.
- Store campaign-specific data per user session.
- Reset or overwrite a context by dispatching a new event.
- Build A/B or personalization logic on stored context.
- Inspect the provider manager for registered providers.
- Reuse the example form as a template for dispatching events.
