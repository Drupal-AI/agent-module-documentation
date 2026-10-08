# Configuration

The settings page is at **Configuration → Development → Sanitize Placeholder**
(`/admin/config/development/sanitize-placeholder`).

## Add field rules

The heart of the configuration is the list of **rules** for the fields you want to
populate. For each rule you pick:

- an **entity** (for example user, node);
- a **bundle** (the content type or other bundle);
- a **field** on that bundle;
- a **strategy** — the kind of fake value to generate (first name, last name,
  institution, domain, a pattern, and so on).

You can also set the **username maximum length**, which the username cleanup uses
when shortening overlong names (it removes characters like `+` and `@` and
normalises dots to underscores).

## Determinism and locale

- **Deterministic mode** — when enabled, the same entity receives consistent
  values across runs, which is what you want for repeatable Behat or Kernel test
  fixtures. Determinism also applies whenever you pass a `--seed` on the command
  line.
- **Faker locale** — sets the locale for strategies that use it (names, domains,
  addresses). This setting only has an effect when the optional Faker library is
  installed; without Faker it is ignored and disabled in the form.

Remember to **Save configuration** when you are done.

## How it runs

- **Automatically after `drush sql:sanitize`.** The module's post‑hook fires after
  sanitization and acts only on fields that Drush actually sanitized *and* that
  match your rules. It also runs after `drush sql:sync --sanitize` when that flow
  invokes `sql:sanitize`. The automatic hook always runs with scope
  **sanitized**.
- **On demand with `drush sp:fake`** (alias `sp:fake-fields`). Run it yourself to
  apply the configured field strategies whenever you like. It accepts:
  - `--entity`, `--bundle`, `--field` — narrow which fields are processed;
  - `--scope=all|empty|sanitized` — choose which existing values to replace:
    **empty** fills only empty values, **sanitized** fills empty values plus ones
    that look sanitized (such as lorem‑ipsum or redacted text), and **all**
    replaces regardless of the current value;
  - `--limit` — cap how many entities are processed;
  - `--seed` — force deterministic output for this run.

Generated values are always trimmed to each field's configured maximum length
(and to the username cap where that applies).

## A typical setup

1. Add rules for the fields you want populated (entity, bundle, field, strategy).
2. Optionally set the username max length and turn on deterministic mode with a
   locale.
3. Save the configuration.
4. Run `drush sql:sanitize` to apply everything, or `drush sp:fake` on demand.
