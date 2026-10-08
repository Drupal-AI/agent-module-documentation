<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Tailwind CSS Utilities (tailwindcss_utility) — agent index

**Collects Tailwind utility classes (incl. Layout Builder), compiles CSS via a JIT handler, and injects it through a stack middleware.**

- **Version:** 2.0.x
- **Core:** ^10 | ^11
- **Dependencies:** file
- **Configure:** `tailwindcss_utility.custom_styles` → `/admin/appearance/tailwind`
- **Storage:** `RuleStorageFactory` → `TailwindRuleStorageConfig` / `TailwindRuleStorageDatabase`
- **Compile/inject:** `TailwindJsHandler`, `StackMiddleware/Tailwind`
- **LB integration:** `Form/LayoutFormsAlter`, `EventSubscriber/SectionSubscriberRenderArray`
- **Routes:** custom_styles (perm `administer tailwindcss_utility`), class_autocomplete (same perm), **add_rules_api** `/tailwindcss-utility/add-rules-api` (perm `access tailwindcss_utility endpoint`)

**Security:** Admin form + autocomplete are gated by `administer tailwindcss_utility`. The **add-rules API** (`AddRulesApi::addRules`) is a permission-gated *write* endpoint (`access tailwindcss_utility endpoint`); the module's own permission description warns it "can be exploited" — grant to trusted editors only. No anonymous/`_access:TRUE` routes.

See [configure/styles.md](configure/styles.md) and [api/add-rules.md](api/add-rules.md)
