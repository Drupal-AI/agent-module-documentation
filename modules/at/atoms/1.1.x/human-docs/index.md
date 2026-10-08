# Atoms — manual setup guide

**Atoms** (`atoms`) lets you define small, globally reusable pieces of content —
each one a named, typed value that editors fill in once and templates or code reuse
everywhere. An atom can be plain text, a formatted (rich‑text) blurb, a number, a
checkbox, a link, a date/time, or an entity reference. It solves the everyday
problem of scattering small site‑wide values — a phone number, a promo blurb, a
call‑to‑action link — across nodes, blocks, and config: define each once as an atom
and reference it by machine name.

There is an important split in how Atoms works. **Atom definitions live in code** —
a module ships a `*.atoms.yml` file (or implements the `hook_atoms_alter()` hook) to
declare which atoms exist and what type each is. You do **not** create atoms
ad‑hoc through the UI. What editors *do* edit in the UI is the **values** of those
atoms, on an overview page under Content. This keeps the set of atoms under version
control while letting non‑developers keep the content current, including per‑language
translations.

Rendering happens through a Twig extension: `{{ atom('machine_name') }}` outputs an
atom in a template, `atomString('machine_name')` gives a plain string, and
`atomLazy('machine_name')` produces a cacheable lazy placeholder — each optionally
taking a language code. In PHP you can fetch render arrays via the `atoms`
view‑builder service. The module runs on Drupal 10 and 11, and an optional
**Atoms Media Library** submodule adds a media atom type. Every route is
permission‑gated; there are no anonymous or mutating endpoints and no outbound HTTP.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and (optionally) enable the Media Library submodule.

## Where it lives in the admin menu

- **Editors** set atom values at **Content → Atoms** (`/admin/content/atoms`), with
  translation forms per language.
- A small **settings** form sits at **Configuration → Content authoring → Atoms
  settings** (`/admin/config/content/atoms/settings`).

Access is controlled by four permissions — *administer atoms*, *configure atoms*,
*edit atom*, and *translate atom* — so you can, for example, let translators edit
values without giving them the settings form.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. **Declare atoms in code.** In a module, ship a `mymodule.atoms.yml` file (or
   implement `hook_atoms_alter()`) describing each atom's machine name, type, label,
   and group:

   ```php
   /** hook_atoms_alter(&$definitions) */
   function mymodule_atoms_alter(&$definitions) {
     $definitions['site_phone'] = [
       'type'  => 'text',        // text, text_format, number, checkbox,
       'label' => 'Site phone',  // date_time, link, entity, media (+ submodule)
       'group' => 'contact',
     ];
   }
   ```

   New definitions are picked up automatically when a module is installed (or call
   `\Drupal::service('atoms.builder')->rebuild();`).
3. **Editors fill in the values** at **Content → Atoms**, per language where needed.
4. **Render** the atom in a Twig template:

   ```twig
   {{ atom('site_phone') }}         {# render array, HTML-safe #}
   {{ atomString('site_phone') }}   {# plain string #}
   {{ atomLazy('site_phone') }}     {# cacheable lazy placeholder #}
   ```

To add your own atom value‑type, create a plugin under `src/Plugin/Atoms/` with the
`Atoms` annotation; the Media Library submodule is a worked example that adds a
media atom.
