# context — agent start

A `context` config entity = a set of **conditions** + **reactions**. When conditions match the
request, reactions fire (place blocks, switch theme, add body class, set title/template
suggestions, menu trail). Conditions **reuse core Condition plugins**; reactions are Context's
own `ContextReaction` plugin type. No core-module dependencies declared. Release candidate
(5.0.0-rc2). The build UI lives in the **context_ui** submodule (`/admin/structure/context`);
the base module itself has no `configure` route.

- How a context is structured (conditions vs reactions, block placement) → [configure/context.md](configure/context.md)
- Add a custom reaction (the ContextReaction plugin type) → [plugins/context.md](plugins/context.md)
- Get active reactions in code (context.manager service) → [api/context.md](api/context.md)
- Hooks: the `context_condition_info` alter + entity hooks → [hooks/context.md](hooks/context.md)
- Admin UI to build contexts → see submodule `context_ui`
