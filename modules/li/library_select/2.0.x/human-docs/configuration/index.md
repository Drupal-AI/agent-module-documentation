# Configuration

Configuration has three parts: deciding **which libraries editors may choose**,
deciding **which entities can select them**, and controlling **who is allowed to
select** at all.

## Open the settings

Go to **Configuration → Development → Library Select**
(`/admin/config/development/library_select_entity`).

## Choose the selectable libraries

This is where you define the set of registered libraries editors can pick from.
Because the choices are drawn from libraries that modules and themes have already
registered, the list is bounded to what your site actually ships — editors cannot
type in an arbitrary URL or paste raw code. Curate this list so it contains only
libraries you are happy to have loaded on individual pages. Where the module
integrates with the **CodeMirror Editor**, code fields get syntax highlighting for
a more comfortable editing experience.

## Choose which entities can select

Enable Library Select on the entities (content types and other entity bundles)
where editors should be able to attach libraries. Only the entities you turn on
get the selection field, so you can keep it to the content types where per‑page
libraries actually make sense.

## The permission — keep it to trusted editors

Library Select provides its own permission that controls who can select libraries.
Grant it under **People → Permissions** (`/admin/people/permissions`) to trusted
editor roles only. Attaching a library loads its JavaScript and CSS on the page,
so this permission effectively decides who can cause extra scripts to run — treat
it as a sensitive, editorial‑trust permission. The module has no other
access‑control role beyond it.

## Page‑level rules with Context

If you enabled the **`library_select_context`** submodule, you can attach
libraries to pages through the **Context** module's rules instead of choosing per
node — useful when a library should load across a whole section of the site rather
than on individual pieces of content.
