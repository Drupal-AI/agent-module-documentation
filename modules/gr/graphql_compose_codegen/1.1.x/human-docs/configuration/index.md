# Configuration

Go to **Configuration → Development → GraphQL Compose Codegen**
(`/admin/config/development/graphql-compose-codegen`). These three settings shape
what the generator produces and where it writes. (You can also set them with
`drush config:set` or by editing `graphql_compose_codegen.settings.yml` in your
config sync directory.)

## Shared base type name

The name of the shared base TypeScript type that your bundles extend — default
**`NodeCommonFields`**. This represents the fields common to all your bundles, so
the per‑bundle output only needs to add the fields specific to each one.

## Base type fields

The list of fields that already live in the shared base type. These are
**excluded** from the per‑bundle output, so a field you've declared as common
isn't repeated on every bundle's type. Keep this list in step with what your base
type actually contains — the Status report (`/admin/reports/status`) checks that
the configured base‑type fields exist on at least one bundle.

## Default output directory

Where generated files are written by default, relative to the Drupal root or given
as an absolute path. You can override it per run with `--output-dir` on
`drush gqcc:generate`. The generator includes a safety guard that prevents writing
to dangerous filesystem locations.

## Running the generator

Point the generator at your frontend project root:

```bash
drush gqcc:generate --output-dir=../ui
```

The four scaffold artefacts land under `{output-dir}/generated/`. They carry a
`.generated` suffix and are intentionally **not referenced anywhere** — review
each file, merge the pieces you need into your own `types/index.d.ts`, your
node‑by‑path query, your `NodeRenderer.tsx` and your `components/drupal/`
directory, then delete the generated files once you've integrated them.

Useful companions:

- `drush gqcc:diff` — see what changed before regenerating.
- `drush gqcc:validate` — verify on‑disk scaffolds match the live schema; exits
  non‑zero, so wire it into CI or a pre‑commit hook to fail the build when someone
  forgets to regenerate after a content‑model change.
- `--dry-run` and `--allow-external` are available on the generate command; writes
  are idempotent, so nothing churns when nothing changed.
