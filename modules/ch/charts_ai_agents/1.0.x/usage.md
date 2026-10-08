Charts AI Agents lets an AI provider generate Drupal Views rendered as charts from a natural-language prompt.

---

The module ships a single AI Agent plugin, `charts_views_agent` (class `ChartsViewsAgent`), that extends the Views Agent from the AI Agents module (`ai_agents_extra`). It is driven through the AI Agents framework: you talk to it from the Explore page (`/admin/config/ai/agents/explore?agent_id=charts_views_agent`) or from the AI Chatbot block. From free text the agent decides whether the request is a create, edit, delete or information task, works out the entity type and bundle, the view type (page/block/...), the view style (defaults to `chart`), the fields or rendered view mode to show, and the filters. When the style is `chart` it also builds the full Charts style settings — library (default Highcharts), chart type (line/bar/pie/...), label field, data providers with per-series colors, stacking, axis titles/min/max, legend, tooltips and 3D/polar toggles — then creates and saves the View entity. It requires the AI Agents framework with a configured AI provider, the Charts module, and one Charts rendering sub-module (e.g. Charts Highcharts); access is restricted to users with the `administer views` permission.

---

- Create a chart view of a content type from a plain-language request ("chart the download stats node").
- Generate a Highcharts line chart of two numeric fields over a date/label field.
- Build a bar or pie chart view without hand-editing Views UI.
- Pick the chart library (Highcharts by default) via prompt wording.
- Set per-series data providers and hex colors from the prompt.
- Configure axis titles, min/max, prefixes/suffixes and label rotation through natural language.
- Toggle stacking, data labels, data markers, tooltips, legend position, 3D or polar options by describing them.
- Create field-based views (needed for chart settings) rather than rendered-content views.
- Create rendered-content views using a chosen view mode (e.g. teaser) when charts are not needed.
- Auto-generate a machine name, path, title and description when the user omits them.
- Add a page display and a default display in one step with a sensible pager.
- Create administrative table views with common fields (title, status, created, changed) and operations links.
- Add filters inferred from the prompt (title contains, status, taxonomy term, date offset, content-type filter).
- Restrict a generated view to a permission or role when asked.
- Answer questions about views without making changes (information action).
- Drive view creation from the AI Chatbot block placed on the site.
- Drive view creation interactively from the AI Agents Explore page.
- Prototype dashboards quickly by generating several chart views from short prompts.
- Use the agent as a starting point/example for building other Charts-related AI agents.
