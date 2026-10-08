A hidden, **deprecated** submodule of AI Agents. It ships no code and should not be enabled.

---

`ai_agents_extra_tools` is marked `lifecycle: experimental` and `deprecated: true` in its info file (the maintainers note it may have security issues and that its tools are being moved to other packages). On a current release it contains only `ai_agents_extra_tools.info.yml` and an `.install` file — no `src/`, so it defines no plugins, services, routes, or permissions. Do not build against it. If you were looking for agent tools, use the `AiFunctionCall` tools shipped by the parent `ai_agents` module instead.

---

- Do **not** enable this module — it is deprecated and empty.
- For agent tools, use the parent module's `AiFunctionCall` plugins instead.
- If you inherited a site with it enabled, plan to remove it.
