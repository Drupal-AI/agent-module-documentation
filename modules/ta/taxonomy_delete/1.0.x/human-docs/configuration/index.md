# Configuration

Taxonomy Delete stores no settings — it is an action tool. "Configuration" here
means granting the right permissions and knowing how to use the delete form and
the Drush command. **Everything on this page permanently deletes taxonomy terms,
so read the warnings before you use it.**

## Permissions (set these first)

The module defines one permission, and the admin form requires a second core one:

- **Delete taxonomy terms** (`delete taxonomy terms`) — the module's own
  permission, marked security‑sensitive.
- **Administer site configuration** — a core permission the delete **form**
  additionally requires.

To reach the admin form, a user must hold **both** permissions. Grant them under
**People → Permissions** (`/admin/people/permissions`), and only to trusted
administrators.

## Using the delete form

1. Go to **Structure → Taxonomy → Taxonomy Delete**
   (`/admin/structure/taxonomy/taxonomy-delete`) — or click the **Taxonomy
   Delete** action link on the Taxonomy vocabularies page.
2. The form lists every vocabulary as a checkbox. Tick the one(s) you want to
   empty. (If no vocabularies exist yet, the form shows a notice with a link to
   add one.)
3. Submit. The module finds every term in the selected vocabularies and deletes
   them with a batch process — one term per step, so large vocabularies delete
   reliably without timing out.
4. When it finishes, a confirmation message appears (and the emptied
   vocabularies are noted in the site log on the `taxonomy_delete` channel). If a
   selected vocabulary had no terms, you get a "No taxonomy terms found." notice
   instead.

> **The form has no separate confirmation step** — submitting deletes the terms
> immediately. There is no undo. Double‑check which vocabularies are ticked
> before you submit.

## Using the Drush command

For scripts, CI, or the command line, use `taxonomy-delete:term-delete` (alias
`tdel`) with one or more vocabulary **machine names**:

```bash
# One vocabulary
drush tdel tags

# Several at once (comma-separated)
drush taxonomy-delete:term-delete tags,categories

# Skip the interactive confirmation prompt (for scripts)
drush tdel tags -y
```

Unlike the form, the Drush command **prompts for confirmation** before deleting
(decline and nothing happens); add `-y` to skip the prompt in automated runs. It
also uses a batch process. Note that the command does not check that the
vocabulary name exists — a typo simply matches no terms and reports "No taxonomy
terms found."

## What gets deleted (and what to watch out for)

- **All terms** in the selected vocabularies are removed. The deletion bypasses
  per‑term access checks — reaching the tool already requires the restricted
  permissions above — so it is unconditional for the chosen vocabularies.
- Deletion **cascades** exactly as deleting a term normally does in core: field
  data that referenced a deleted term is affected, and child terms are re‑parented
  per core behaviour.
- The vocabularies themselves are **not** deleted — only their terms. You are
  left with empty vocabularies you can reuse or delete separately.

Because this is irreversible, take a database backup before emptying any
vocabulary whose terms you might need again.
