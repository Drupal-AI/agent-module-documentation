# Configuration

Seeding is driven by **rules** you define for source → target language pairs. Once
a matching rule exists, layouts are copied automatically the first time a
translation is saved — there is no per-editor opt-in checkbox.

## Open the settings form

1. Log in as a user with the **Administer LB translation seed** permission.
2. Go to **Configuration → Regional & language → Layout Builder Translation
   Seed**, or navigate directly to `/admin/config/regional/lb-translation-seed`.

> Make sure you have completed the post-installation steps first (Layout Builder
> with overrides enabled, and the Layout field marked translatable). Without them,
> all translations share one stored layout and seeding has no visible effect.

## Add a seeding rule

Click **Add seeding rule** and define:

- **Source language** — the language whose layout is copied from.
- **Target language** — the language the new translation is created in.
- **Entity type** — the entity type the rule applies to (for example Content /
  node).
- **Bundle(s)** — optionally, one or more bundles to limit the rule to (for
  example only the Article content type). Leave unfiltered to apply to all bundles
  of the entity type.

Multiple rules can coexist on one site — for example `en → en-us`, `en → en-gb`,
and `fr → fr-ca` — so you can seed several regional or language variants
independently.

## Per-rule options

Each rule also lets you toggle:

- **UUID regeneration** — give every cloned component a freshly generated UUID so
  it stays independent of the source. (Recommended; on by default.)
- **Inline-block cloning** — deep-clone the `block_content` entities referenced by
  inline-block components and rewire the clones to the translation, so editing
  inline content in the translation does not bleed back into the source.

You can also **enable or disable a rule without deleting it**, which is handy for
temporarily pausing seeding for a language pair.

## Permissions

Under **People → Permissions**, the module adds two:

- **Administer LB translation seed** (`administer lb translation seed`) — manage
  the seeding rules on this form. Grant to trusted administrators.
- **Reseed layout from source translation**
  (`reseed layout from source translation`) — enables the **"Reseed layout from
  <source>"** button on a destination translation's edit form, letting editors
  re-baseline a translation from the latest source layout on demand. Grant to the
  translator/editor roles that should be allowed to overwrite a translated layout.
