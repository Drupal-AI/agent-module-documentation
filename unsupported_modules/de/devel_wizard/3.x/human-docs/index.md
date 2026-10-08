# Devel Wizard — manual setup guide

**Devel Wizard** (`devel_wizard`) is a developer productivity tool that scaffolds
Drupal code from reusable generators it calls **"spells"**. Instead of hand-writing
the boilerplate for a new module, content type, entity type, plugin manager,
controller, event subscriber, route param converter, image effect, library, Behat
test, or even a whole Drush project, you fill in a spell's form (or run its Drush
command) and Devel Wizard emits the code for you to review and refine.

Each spell is an autocomplete-rich form under `/admin/devel-wizard-spell` — the
autocomplete helps you pick existing modules, themes, profiles, libraries and
entity types as you fill it in. Every spell is also exposed as a matching Drush
command, so you can generate the same scaffolding non-interactively from CI or a dev
shell. A few spells (for example the Drush-project and package-manager spells) shell
out to run `composer`/`drush`; they build their commands as argument arrays passed
to Symfony Process, so there's no shell-metacharacter injection.

This is firmly a **development-time tool**. Its entire surface sits behind
restricted permissions (`devel_wizard.spell` for the spell list, forms and
autocomplete endpoints; `devel_wizard.settings.admin` for its settings), and
because it can execute shell processes by design, it **should not be enabled on
production**. It depends on core's **Config** module, targets Drupal 11, and is not
covered by Drupal's security advisory policy — review before use.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and grant its permissions.

The module does have a small settings page (`/admin/config/development/devel-wizard-settings`),
but the day-to-day work happens on the spell forms rather than a global config
screen, so setup is covered here rather than in a separate Configuration page.

## Where it lives in the admin menu

- **Spell overview:** `/admin/devel-wizard-spell` (requires the
  `devel_wizard.spell` permission) — lists the available spells; each spell has its
  own form at `/admin/devel-wizard-spell/{spell}`.
- **Settings:** `/admin/config/development/devel-wizard-settings` (requires the
  `devel_wizard.settings.admin` permission).

## How to use it

1. **Enable it in a development environment** and grant `devel_wizard.spell` (and,
   if needed, `devel_wizard.settings.admin`) to trusted developer roles only.
2. **Open the spell list** at `/admin/devel-wizard-spell` and pick a spell for what
   you want to generate — a module, content/block/taxonomy type, entity type,
   controller, plugin manager, and so on.
3. **Fill in the form** (using the autocompletes) and generate, or run the spell's
   matching **`drush`** command from the CLI for the same result.
4. **Review the generated code** before committing it. Never leave the module
   enabled on production.
