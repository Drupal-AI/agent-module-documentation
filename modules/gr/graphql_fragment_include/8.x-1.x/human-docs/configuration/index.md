# Configuration

Configuring this module is a single setting — the directory where your fragment
files live — plus the workflow of writing those files and referencing them from
queries.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → GraphQL → Fragment Include**, or navigate directly to
   `/admin/config/graphql/fragment-include`.

## Fragments base directory

This is the one field on the form. It tells the module where to look for the
`.gql` files you include.

- Enter a path that **starts with a leading slash** and is **relative to the
  Drupal root** (`DRUPAL_ROOT`) — for example
  `/sites/default/graphql/fragments`.
- The directory must be readable by Drupal when queries execute. A location
  under `/sites/default/` is typical.

Click **Save configuration** when you're done.

> **Security note:** Point this at a directory that contains *only* fragment
> files. The loader will read any file whose resolved path falls inside the base
> directory — not strictly files ending in `.gql` — and the containment check
> matches on the directory name as a prefix. To stay safe, keep the fragments
> directory dedicated to fragments, and avoid sibling directories whose names
> begin with the same text as your base directory's name.

## Writing and including fragments

1. Create `.gql` files inside the base directory. You can organise them into
   subdirectories, and a fragment file may itself include other fragments —
   nesting is resolved recursively, and each fragment is loaded at most once.
2. At the top of a query, add one include line per fragment, using the path
   *relative to the base directory*:

   ```graphql
   # include Image.gql
   {
     content: nodeById(id: "1") {
       ... on NodeArticle {
         image: fieldImage { entity { ...Image } }
       }
     }
   }
   ```

   Before the query runs, the loader replaces each `# include X` line with the
   contents of that file.

## When an include doesn't resolve

If a fragment file can't be found (or resolves to a path outside the base
directory), the include is simply skipped and a warning is logged. Check
**Reports → Recent log messages** (dblog) under the `graphql_fragment_include`
channel to see what was skipped.

## Two caveats to expect

- Because the include syntax lives in a GraphQL *comment*, clicking
  **Prettify** in the GraphiQL IDE will strip your `# include` lines. Keep the
  authoritative version of your queries in files, not in the IDE.
- If you need a different include syntax, you can change it by extending the
  `graphql_fragment_include.graphql_fragment_loader` service in a custom module.
