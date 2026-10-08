AIA (AI Architect / AI Assistant) generates real Drupal configuration — content types, fields, taxonomies, blocks, views, menus, and paragraph types — from plain-English prompts, with a mandatory dry-run preview and full rollback on every change.

---

AIA lets a site builder describe a structural goal in natural language and have the AI plan and apply the matching Drupal configuration. It ships seven `AiaAction` plugins (generate_content_type, add_field, generate_taxonomy, generate_view, generate_block, generate_menu, generate_paragraph_type) plus a free-form router that either matches a single action or plans a multi-step pipeline. Every request is two-phase: the AI returns structured JSON that is schema- and business-rule validated, a colour-coded diff is shown, and only an explicit apply writes to the site. Each applied change is recorded as an `aia_task` entity with a task-history report and one-click rollback. Access is gated by the single `administer aia` permission (restricted). The AI backend is pluggable through the `ai` module; a deterministic keyword-based `MockAIRequestService` is the wired default so the whole pipeline works with no provider or API cost during development. Drive it from the CLI (`drush aia:*`) or the admin form at `/admin/config/development/aia`.

---

- Scaffold a complete content type ("a product type with title, SKU, price, and product images") in one prompt, with fields, form display, and view display configured.
- Add a single field to an existing content type by describing it ("a reading-time field on articles").
- Generate a taxonomy vocabulary pre-populated with terms ("Categories: News, Reviews, Tutorials").
- Build a view with page/block displays, fields, and a bundle filter from a description.
- Create a reusable custom block (`block_content`) with body text and a chosen text format.
- Generate a menu with nested navigation links ("Footer menu with Privacy Policy, Terms, Accessibility").
- Create a Paragraphs paragraph type with fields (requires the optional `paragraphs` module).
- Type a free-form goal in the web UI and let the router pick the right action automatically.
- Plan and run a multi-step "pipeline" (e.g. content type + listing view + nav link) as one session with a shared rollback grouping.
- Preview every change as a structured diff before anything is written (`drush aia:dry-run <action>`).
- Apply changes non-interactively in scripts with `drush aia:execute <action> --auto-approve`.
- Resolve naming conflicts interactively on the CLI: stop, or auto-increment to the next free machine name.
- Undo any applied change by task ID with `drush aia:rollback <id>` or the rollback form link.
- Review a full audit trail of AI-generated changes (action, user, timestamp, session, status) at `/admin/reports/aia`.
- Develop and test the full flow offline with the deterministic Mock AI service (no API key, no cost).
- Switch to a real LLM (Anthropic, Gemini, OpenAI, etc.) by pointing `aia.ai_request_service` at `AIRequestService` and configuring an `ai` provider.
- Prototype an information architecture quickly on a fresh site, then roll it all back when done.
- Let content teams request common structures without hand-editing YAML or clicking through Field UI.
- List available actions and inspect the active AI service with `drush aia:list` and `drush aia:info`.
- Toggle post-apply cache clearing and detailed watchdog logging from the settings form.
- Seed demo or QA environments with reproducible content models via the Mock service's keyword-mapped responses.
