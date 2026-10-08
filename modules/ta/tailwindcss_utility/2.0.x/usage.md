<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Tailwind CSS Utilities lets site builders apply Tailwind utility classes across Drupal (including Layout Builder sections/blocks) and have the corresponding CSS generated and served automatically.
---
Class rules are kept in a pluggable `RuleStorage` backend (config or database, via `RuleStorageFactory` / `TailwindRuleStorageConfig` / `TailwindRuleStorageDatabase`). A `TailwindJsHandler` drives Tailwind CSS generation for the collected classes, and a `Tailwind` stack middleware injects the generated stylesheet into responses. Editors get a class autocomplete controller and a Layout Builder form alter (`LayoutFormsAlter`) plus a section render-array event subscriber that let Tailwind classes be attached to layout sections/blocks. A styles admin form lives at `/admin/appearance/tailwind`.

Security-relevant surface: three routes. `tailwindcss_utility.custom_styles` (the styles form) and `tailwindcss_utility.class_autocomplete` require the admin permission `administer tailwindcss_utility`. The third, `tailwindcss_utility.add_rules_api` (`/tailwindcss-utility/add-rules-api` → `AddRulesApi::addRules`), is gated by a **separate** permission `access tailwindcss_utility endpoint` whose own description warns it "can be exploited" and should be given to trusted editors only — it writes CSS rules into storage, so treat it as a privileged write endpoint and keep it off untrusted roles. Setup: enable the module, choose a rule-storage backend, grant permissions carefully, then configure/apply classes at `/admin/appearance/tailwind` or through Layout Builder.
---
- Apply Tailwind utility classes to Layout Builder sections.
- Add Tailwind classes to individual blocks in a layout.
- Configure custom Tailwind styles at /admin/appearance/tailwind.
- Autocomplete Tailwind class names while editing.
- Store class rules in configuration for export/deploy.
- Store class rules in the database for high-volume sites.
- Auto-generate CSS for only the classes actually used (JIT).
- Serve the compiled Tailwind stylesheet via stack middleware.
- Grant `administer tailwindcss_utility` to theme admins.
- Restrict the add-rules API permission to trusted editors only.
- Programmatically add CSS rules through the add-rules API endpoint.
- Include or exclude Tailwind core classes in autocomplete.
- Switch the rule-storage backend via the storage factory.
- Attach utility classes through the Layout Builder form alter.
- Post-process section render arrays to inject classes.
- Build utility-first component styling without a custom theme build step.
- Toggle which classes are compiled into the served CSS.
- Audit stored Tailwind rules before deployment.
- Keep generated CSS in sync as new classes are added.
- Provide editors a guarded self-service styling workflow.
