# Resume state — no longer a cursor

This file held a page number while the campaign walked drupal.org's feed page by page. It has not
been meaningful since **wave 51**: `scripts/next-wave.sh` now recomputes what is undocumented from
disk on every call, by checking whether `modules/<first-two-letters>/<project>/` exists, so there
is no cursor to keep in sync and nothing here to advance.

The number below is left as the historical value at wave 51. Do not treat it as current state.

61

## Where resume state actually lives

- **What is documented** — the `modules/` tree itself. `scripts/next-wave.sh` reads it.
- **What is on disk but undocumented** — `scripts/undocumented-on-disk.sh`, which is the check to
  run before committing a wave.
- **What must never be served again** — `scripts/.campaign-skip`, one project per line with a
  comment giving the reason. This carries the real accumulated state: projects with no Drupal 11
  release, patch sets that no longer apply, metapackages, project→module renames
  (`imce_search_2` → `imce_search_plugin`, `entity_meta_relation` → `emr`), and modules that break
  the site badly enough to be excluded (`wisski`, `bs_lib`, `apigee_m10n`).
- **How far through the list the campaign is** — `scripts/next-wave.sh 5000 | wc -l` gives the
  number of undocumented projects remaining.
