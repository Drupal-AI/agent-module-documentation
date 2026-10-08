AI Penpot reads a Penpot design's live context over the Penpot RPC API and hands it to Drupal AI Agent tools, so the Drupal Canvas AI assistant can build pages and components from the real design.

---

AI Penpot is a connection module between a Penpot instance (Penpot Cloud or self-hosted) and Drupal's AI Agents. It authenticates to the Penpot RPC API with a stored access token and exposes two AI function-call tools: one lists the pages of a Penpot file, the other reads a single page's design context - its solid-fill colours, typography styles, the real (verbatim) text content and a shape outline. The design data is summarized into a compact YAML block that an AI agent consumes as the source of truth for a build. Configuration (instance URL, token Key, default file) is set on an admin form; the token is held in the Key module and encrypted at rest via Easy Encryption. On install the module can seed editable AI Context guidance (build rules, accessibility rules, component-mapping governance) that Penpot-aware agents follow. There are no browser, login, or file-upload steps: everything runs server-side from PHP, mirroring the design reads a Penpot MCP server surfaces.

---

- Give the Drupal Canvas AI assistant the real colours, type and text of a Penpot design instead of a screenshot.
- Paste a Penpot workspace or view link into the AI panel and have the agent extract the file id and page id automatically.
- List every page of a Penpot file so an agent can plan one Canvas page per design page.
- Read one Penpot page's design context: solid fill colours (with opacity), typography styles (family/weight/size), verbatim text runs and a named-shape outline.
- Map a design's colours onto the active theme's design tokens / CSS custom properties rather than hard-coding hex values.
- Fill built components with the design's real text content (larger text sizes treated as headings, smaller as body/labels).
- Build full sites section by section, reusing existing theme components before creating new ones.
- Connect to Penpot Cloud (https://design.penpot.app) using a personal access token.
- Connect to a self-hosted Penpot instance (with the enable-access-tokens flag on) at your own base URL.
- Configure a default Penpot file id so tools can be called without a link each time.
- Test the Penpot connection from the settings page before wiring the tools into an agent.
- Resolve a page by name (case-insensitive) or by page id, falling back to the file's first page.
- Store the Penpot access token in a Key entity, encrypted at rest, instead of in plain config.
- Seed and edit AI build/accessibility guidance as AI Context items (when the ai_context module is installed).
- Enforce WCAG 2.1 AA accessibility rules on everything an agent builds from a design.
- Apply component-mapping governance so the AI reuses or extends existing components before scaffolding new ones.
- Use the same design tokens across Drupal Core and Drupal CMS - the module is theme- and framework-agnostic.
- Pair it with AI Figma to support both Penpot and Figma design sources on the same site.
- Surface a status-report requirement that warns when the Penpot base URL or token is not yet configured.
- Restrict who can read Penpot design context with a dedicated permission separate from module administration.
