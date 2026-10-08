# Recipe Code Installer — manual setup guide

**Recipe Code Installer** (`recipe_code_installer`) fills a gap in Drupal's
**Recipes** system. Core recipes are excellent at installing modules and applying
configuration, but they **cannot ship custom code**. Recipe Code Installer bridges
that: when a recipe is applied, it looks for a `code/` subdirectory inside the
recipe, extracts the custom module it finds there into your project's custom
modules directory, and installs it as a proper Drupal module.

This is aimed at the real‑world case where a solution needs a little bespoke code —
a validation constraint, a small service, a hook — that isn't worth publishing as a
standalone contrib module but still has to travel with the recipe. It runs as the
**last stage** of recipe application (listening for the recipe‑applied event), so it
works alongside the Recipe Unpack Composer plugin, which operates at a different
point in the lifecycle.

By deliberate design, the module that a recipe ships in its `code/` folder must use
the **same machine name as the recipe** — a recipe named `foo_bar` ships a `foo_bar`
module. That guardrail keeps provenance clear (you can always see which recipe added
which custom module), discourages using recipes as a general module‑distribution
mechanism, and nudges teams to keep bundled code small and project‑specific while
reusable code goes through normal Composer packages. A **development mode** is
available that symlinks the code instead of copying it, which is handy while you're
building a recipe.

> **Security — this installs code, and installed code runs with full privileges.**
> Bundling a module inside a recipe means that, when the recipe is applied, its code
> is written into your codebase and enabled — which is **effectively running
> arbitrary code**, exactly like a malicious Composer package could. So: **only apply
> recipes from sources you trust**, review the bundled code before applying, and
> treat recipe application as a privileged deployment action, never something exposed
> to untrusted users. The module has no runtime access‑control role of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no settings page** — Recipe Code Installer acts automatically when a
recipe is applied. See "How to use it" below.

## How to use it

1. Install and enable Recipe Code Installer ([Installation](installation/index.md)).
2. Obtain (or author) a **trusted** recipe whose folder includes a `code/`
   subdirectory containing a custom module named the same as the recipe — for
   example:

   ```
   enhanced_event_recipe/
   ├── code/            # custom module code, machine name = recipe name
   │   ├── enhanced_event_recipe.info.yml
   │   ├── enhanced_event_recipe.module
   │   └── src/…
   ├── config/          # standard recipe configuration
   └── recipe.yml       # standard recipe definition
   ```

3. **Review the bundled code** before you proceed — you are about to install it.
4. Apply the recipe the usual way (for example with core's recipe apply command).
   As the final step, Recipe Code Installer extracts the `code/` module into your
   custom modules directory and installs it.
5. Confirm the new module is present and enabled (**Extend**, or `drush pml`).

While developing a recipe, you can turn on the module's **development mode** so the
bundled code is symlinked into place rather than copied, letting you edit it live.
