<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Save Entities — agent index

Form to **bulk-save (re-save) nodes and media of certain types** — triggers save hooks/pipelines
(re-generate derived data, re-run processors). Config at `save_entities.node_form`; provides permissions.
Version **2.0.0**. Core `^10||^11`.

Admin/maintenance tool — re-saving runs the full save pipeline (revisions, side effects, performance);
**restrict to trusted admins**, use deliberately. Acts with operator's privileges; no access role.
