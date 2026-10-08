# ai_automators (AI Automators) 1.4.x — agent index

Submodule of `ai` (AI Core). Automatically generates/amends field values when an entity is
saved. You attach an **automator** to a field: pick a **rule** (`AiAutomatorType` plugin
matched to the field type), a **worker type** (`AiAutomatorProcessRule` plugin — how/when it
runs), and a prompt. Requires AI Core + a configured provider, Token, and Field UI (to
configure). No `configure` route of its own; automators are set on the field's config form.

Core mental model: `ai_automator` config entity = (rule + worker type + entity/bundle/field
+ prompt). On save, the module's `hook_entity_*` hooks run the rule to produce the value.

- **The two plugin types & how to write a rule** → [plugins/ai_automators.md](plugins/ai_automators.md)
- **Attach an automator to a field; config keys, entities, routes** → [configure/ai_automators.md](configure/ai_automators.md)
- **Run automators from code / expose as an agent tool** → [api/ai_automators.md](api/ai_automators.md)
- **Observe or alter a run (events + alter hooks)** → [extend/ai_automators.md](extend/ai_automators.md)
- **Drush generator for a new automator-type plugin** → [drush/ai_automators.md](drush/ai_automators.md)
- **Permissions** → [permissions/ai_automators.md](permissions/ai_automators.md)
