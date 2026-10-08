<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AI Readme Generator auto-generates a README.md for any installed contrib or custom Drupal module by scanning its code and summarising it with an AI provider.

---

AI Readme Generator is a developer tool for producing module documentation. An administrator configures an AI provider (OpenAI or Groq), API key and model on a settings form, then either uses the "Generate README.md" form (pick a module from a dropdown, click generate) or the Drush command `readme-generate <machine_name>`. The module resolves the selected module's directory, scans its files with the `innoraft/ai-readme-generator` PHP package (`CodebaseScanner`), sends the collected structure to the configured chat endpoint (`AIResponse::summarizeArray()`), and writes the returned Markdown to a `README.md` inside that module's directory. Both admin routes require the `administer site configuration` permission. The heavy lifting (code scan + HTTP call to the AI provider) lives in the Composer package `innoraft/ai-readme-generator`, not in the Drupal module itself, which only wires up the forms and the Drush command.

---

- Generate a README.md for a contrib module before contributing it to Drupal.org.
- Generate a README.md for an in-house custom module.
- Batch-document several modules by running the Drush command per module.
- Produce a consistent README structure across a team's modules.
- Regenerate a README after a module's code has changed substantially.
- Configure OpenAI as the summarising provider (GPT-3.5 Turbo / GPT-4).
- Configure Groq as the summarising provider (llama3-8b-8192).
- Set the model per provider on the AI configuration form.
- Kick off generation from the admin UI at `/admin/config/ai-readme-generator/generate-readme`.
- Kick off generation from the CLI: `drush readme-generate my_module`.
- Document a module directly on the server without leaving the site.
- Speed up module publishing / codebase cleanup tasks.
- Fill in missing README files across a legacy codebase.
- Give reviewers a starting-point README to edit rather than a blank file.
- Scan a module's `.info.yml`, PHP classes and hooks for the summary input.
- Keep documentation generation self-contained (no other Drupal AI modules required).
- Review and edit the AI-produced README before committing it.
- Limit who can generate READMEs to site administrators.
- Choose a cheaper/faster model for quick drafts and a stronger model for final output.
- Automate first-draft documentation during early module development.
