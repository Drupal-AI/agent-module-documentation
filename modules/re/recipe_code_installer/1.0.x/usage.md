<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Recipe Code Installer installs bundled code from recipes as a custom module.

---

Recipe Code Installer **lets Drupal Recipes package and install bundled code as a custom module** — copying
code shipped inside a recipe into the project's codebase (e.g. `modules/custom`) so it becomes an installable
module, for recipes that need to ship logic, not just config. It is in the Development package.

Use it to apply recipes that bundle code. It is a developer/devops tool with an important trust boundary:
installing bundled code is **effectively installing arbitrary code** — that code will run with full Drupal
privileges once enabled. So **only apply recipes from trusted sources** (a malicious recipe could bundle a
malicious module, just like a malicious composer package), review the bundled code before enabling, and treat
recipe application as a privileged deployment action (not something to expose to untrusted users). It has no
runtime access-control role. Apply trusted recipes.

---

- Install bundled code from recipes.
- Copy recipe code into the codebase.
- Make it an installable module.
- Serve developers/devops.
- Support code-shipping recipes.
- Write module files.
- TREAT installing code as arbitrary code.
- Only apply recipes from TRUSTED sources.
- Review bundled code before enabling.
- Treat recipe application as privileged deployment.
- Have no runtime access-control role.
- Apply trusted recipes.
- Handle recipe code.
- Install code.
- Configure the install.
- Bundle code.
- Handle the recipe.
- Install modules.
- Trust the source.
- Provide recipe code installation.
